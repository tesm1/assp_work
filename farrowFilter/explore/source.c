#include <inttypes.h>
#include <stddef.h>

#include <tceops.h>


#define SCALE_FACTOR 4
#define S8_NEGATIVE_MAX 128
#define HEADER_LEN 44

// 5 for 4 cycles per sample
#define BUFFER_SIZE 5



static inline int mul( int in1, int in2 ) {
	return (in1 * in2) >> SCALE_FACTOR;
}



void farrow_filter( int *restrict input_line, int *restrict delay_line, int *restrict output_line )
{

	for (int i = 0; i < BUFFER_SIZE-1; i++)
	{
		// Y[N] = X[N] + d[N] * (X[N-1] - X[N]);
		output_line[i] = input_line[i+1] + mul(delay_line[i], (input_line[i] - input_line[i+1]));
	}

	// shift last sample to start
	input_line[0] = input_line[BUFFER_SIZE-1];
}






static void __attribute__((noinline)) filter_loop( void )
{
	int status = 1, _status;


	int sample1, sample2, sample3;
	int delay1, delay2, delay3;
	int out1, out2, out3;

	int input_line[BUFFER_SIZE] = { 0 };
	int delay_line[BUFFER_SIZE] = { 0 };

	int output_line[BUFFER_SIZE-1] = { 0 };



	// ------------- take first sample --------------
	_TCEFU_FIFO_U8_STREAM_IN("stream_in", 0, input_line[0], status);
	_TCEFU_FIFO_U8_STREAM_IN("delay_in", 0, delay1, _status);

	out1 = input_line[0] + mul(delay1, (0 - (input_line[0] - S8_NEGATIVE_MAX)));

	_TCEFU_FIFO_U8_STREAM_OUT("stream_out", out1);
	// ----------------------------------------------



	while (status > 0)
	{
		for (int i = 1; i < BUFFER_SIZE; i++)
		{
			_TCEFU_FIFO_U8_STREAM_IN("delay_in", 0, delay_line[i-1], _status);
			_TCEFU_FIFO_U8_STREAM_IN("stream_in", 0, input_line[i], status);
		}

		farrow_filter(input_line, delay_line, output_line);

		for (int i = 0; i < BUFFER_SIZE-1; i++)
		{
			_TCEFU_FIFO_U8_STREAM_OUT("stream_out", output_line[i]);
		}
	}

}




// faster to copy directly, than to filter with the zeros
static void __attribute__((noinline)) copy_header( void )
{
	int data, delay;
	int status = 1, _status;

	for (int i = 0; i < HEADER_LEN; i++)
	{
		_TCEFU_FIFO_U8_STREAM_IN("stream_in", 0, data, status);
		_TCEFU_FIFO_U8_STREAM_IN("delay_in", 0, delay, _status);
		_TCEFU_FIFO_U8_STREAM_OUT("stream_out", data);
	}
}



int main( void )
{
	copy_header();
	filter_loop();

	return 0;
}