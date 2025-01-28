#include <tceops.h>


#define HEADER_LEN 44
#define S8_NEGATIVE_MAX 128
#define SCALE_FACTOR 8

#define BUFFER_SIZE 7

// filter coeff
#define K0 37
#define K1 109
#define K2 109
#define K3 37




void fir_filter( int *restrict input_line, int *restrict output_line )
{
    int result = 0;
	int result2 = 0;



	for (int i = 0; i < BUFFER_SIZE-3; i++)
	{
		_TCE_MY_MAC(input_line[i], K0, result);
		_TCE_MY_MAC(input_line[i+1], K1, result);
		_TCE_MY_MAC(input_line[i+2], K2, result);
		_TCE_MY_MAC(input_line[i+3], K3, result);

		output_line[i] = (result >> SCALE_FACTOR) + S8_NEGATIVE_MAX;
	}


	// shift last 3 unprocessed samples to start for the next call
	input_line[2] = input_line[BUFFER_SIZE-1];
	input_line[1] = input_line[BUFFER_SIZE-2];
	input_line[0] = input_line[BUFFER_SIZE-3];

}



void __attribute__((noinline)) filterloop( void )
{
	int status = 1;
    int input_line[BUFFER_SIZE] = { 0 };
 	int output_line[BUFFER_SIZE-3] = { 0 };


	while (status > 0)
	{
		for (int i = 3; i < BUFFER_SIZE; i++)
		{
			_TCEFU_FIFO_U8_STREAM_IN("stream_in", 0, input_line[i], status);
			input_line[i] -= S8_NEGATIVE_MAX;
		}

		fir_filter(input_line, output_line);

		for (int i = 0; i < BUFFER_SIZE-3; i++)
		{
			_TCEFU_FIFO_U8_STREAM_OUT("stream_out", output_line[i]);
		}
	}

}



void __attribute__((noinline)) copy_header( void )
{
	int status = 1;
	int input;

	for (int i = 0; i < HEADER_LEN; i++)
	{
		_TCEFU_FIFO_U8_STREAM_IN("stream_in", 0, input, status); // read new sample
		_TCEFU_FIFO_U8_STREAM_OUT("stream_out", input); // write sample, pitäskö check out status myös?
	}
}




int main(void)
{
	copy_header();
	filterloop();

	return 0;
}