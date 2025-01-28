#include <stdio.h>
#include <math.h>
#include <inttypes.h>

#include <limits.h>

// #define USE_SATURATION

#define FXP_FRAC_LEN 6

#define FXP_SCALE_FACTOR (1 << FXP_FRAC_LEN)

// #define FXP_PMAX (((1 << (15 - FXP_FRAC_LEN)) - 1) - (1 << FXP_FRAC_LEN))
// #define FXP_NMIN ((1 << (15 - FXP_FRAC_LEN)))


#define FXP_PMAX 32767
#define FXP_NMIN -32768

typedef int16_t fixedPoint_t;



// fixedPoint_t float_to_fixedPoint( float value );
// float fixedPoint_to_float( fixedPoint_t fxp );
// fixedPoint_t mul_fixedPoint( fixedPoint_t fxp_a, fixedPoint_t fxp_b );
// fixedPoint_t add_fixedPoint( fixedPoint_t fxp_a, fixedPoint_t fxp_b );



// #define SATURATE_FXP(v) ((v) > FXP_PMAX ? FXP_PMAX : ((v) < FXP_NMIN ? FXP_NMIN : (v)))


// static inline float saturate_half( float d, float min, float max )
// {
// 	const float t = d < min ? min : d;
// 	return t > max ? max : t;
// }





#define BUFFSIZE 128
// https://stackoverflow.com/questions/111928/is-there-a-printf-converter-to-print-in-binary-format?page=2&tab=scoredesc#tab-top
uint32_t char_to_bin10( uint8_t ch )
{
	uint32_t sum = 0;
	uint32_t power = 1;

	while (ch)
	{
		sum += ((ch & 1) > 0) ? power : 0;
		power *= 10;
		ch >>= 1;
	}
	return sum;
}

// best version I think? or the first one
void printIn_binaryV2( const uint64_t num )
{
	char buffer[BUFFSIZE] = {0};
	const uint64_t bitmask = 0xFFULL;
	uint8_t shift = 0, bytes = 0, temp = 0;

	if (num <= UCHAR_MAX) {
		bytes = 1;
		shift = 0;
	}
	else if (num <= USHRT_MAX) {
		bytes = 2;
		shift = 8;
	}
	else if (num <= ULONG_MAX) {
		bytes = 4;
		shift = 24;
	}
	else if (num <= ULLONG_MAX) {
		bytes = 8;
		shift = 56;
	}
	else if (num > ULLONG_MAX) {
		fprintf(stderr, "%s\n", "[!] Number too large > uint64\n");
		return;
	}

	for (int i = 0, ret = 0; i < bytes; i++, shift -= 8)
	{
		temp = (num >> shift) & bitmask;
		if (temp > 0) {
			ret += snprintf(buffer+ret, BUFFSIZE-ret, "%08u ", char_to_bin10(temp));
		}
		else {
			ret += snprintf(buffer+ret, BUFFSIZE-ret, "00000000 ");
		}
	}

	printf("in binary V2: %s\n", buffer);
}




static inline fixedPoint_t saturate_fixedPoint( int32_t value )
{
	const int32_t temp = (value < FXP_NMIN) ? FXP_NMIN : value;
	return (temp > FXP_PMAX) ? FXP_PMAX : temp;
}


fixedPoint_t float_to_fixedPoint( float value )
{
	int32_t res = value * FXP_SCALE_FACTOR;
	// int32_t res = round((double)value * FXP_SCALE_FACTOR);
	fixedPoint_t fxp = saturate_fixedPoint(res);
	return fxp;
}


static inline float fixedPoint_to_float( fixedPoint_t fxp ) {
	// return round((float)fxp / FXP_SCALE_FACTOR);
	return (float)fxp / FXP_SCALE_FACTOR;
}


fixedPoint_t mul_fixedPoint( fixedPoint_t fxp_a, fixedPoint_t fxp_b )
{
	// two 16-bit numbers MULTIPLIED requires 32-bits for the result
	int32_t res = ((int32_t)fxp_a * fxp_b) >> FXP_FRAC_LEN;
	// int32_t res = round((double)((int32_t)fxp_a * fxp_b) / FXP_SCALE_FACTOR);
	fixedPoint_t fxp = saturate_fixedPoint(res);
	return fxp;
}

fixedPoint_t add_fixedPoint( fixedPoint_t fxp_a, fixedPoint_t fxp_b )
{
	// two 16-bit numbers ADDED requires 17-bits for the result
	int32_t res = (int32_t)fxp_a + fxp_b;
	fixedPoint_t fxp = saturate_fixedPoint(res);
	return fxp;
}



fixedPoint_t dot_product_fixedPoint( const float* vec1, const float* vec2, size_t length )
{
    fixedPoint_t dot_res = 0;
    for (size_t i = 0; i < length; i++)
	{
        fixedPoint_t fxp1 = float_to_fixedPoint(vec1[i]);
        fixedPoint_t fxp2 = float_to_fixedPoint(vec2[i]);
        fixedPoint_t product = mul_fixedPoint(fxp1, fxp2);
        dot_res = add_fixedPoint(dot_res, product);
		printf("dotprod result: %.*f\n\n", FXP_FRAC_LEN, fixedPoint_to_float(dot_res));
    }
    return dot_res;
}





int main( void )
{
	// float a = 14.321f;
	// float b = -143.3211f;

	// fixedPoint_t fxp1 = float_to_fixedPoint(a);
	// fixedPoint_t fxp2 = float_to_fixedPoint(b);

	// printf("fix1: %.*f\n", FXP_FRAC_LEN, fixedPoint_to_float(fxp1));
	// printf("fix2: %.*f\n", FXP_FRAC_LEN, fixedPoint_to_float(fxp2));

	// printIn_binaryV2(fxp1);

	// fixedPoint_t add_res = add_fixedPoint(fxp1, fxp2);
	// printf("add result: %.*f\n", FXP_FRAC_LEN, fixedPoint_to_float(add_res));


	// fixedPoint_t mul_res = mul_fixedPoint(fxp1, fxp2);
	// printf("mul result: %.*f\n\n", FXP_FRAC_LEN, fixedPoint_to_float(mul_res));


	// int32_t k = 1<<31;
	// double t = k;
	// printf("test: %f\n", t);
	// #define DIV 41
	// printf("test: %f\n", t/DIV);
	// printf("test: %f\n", round(t/DIV));



	// test addition
	// add_res = 0;
	// for (size_t i = 1; i < 11; i++)
	// {
	// 	fixedPoint_t fxp = float_to_fixedPoint(i * 2.41f);
	// 	printf("fxp: %.*f\n", FXP_FRAC_LEN, fixedPoint_to_float(fxp));
	// 	add_res = add_fixedPoint(add_res, fxp);
	// 	printf("add result: %.*f\n\n", FXP_FRAC_LEN, fixedPoint_to_float(add_res));
	// }


	// test multiplication
	// mul_res = 1 << FXP_FRAC_LEN;
	// for (size_t i = 1; i < 11; i++)
	// {
	// 	fixedPoint_t fxp = float_to_fixedPoint(i * 2.41f);
	// 	printf("fxp: %.*f\n", FXP_FRAC_LEN, fixedPoint_to_float(fxp));
	// 	mul_res = mul_fixedPoint(mul_res, fxp);
	// 	printf("mul result: %.*f\n\n", FXP_FRAC_LEN, fixedPoint_to_float(mul_res));
	// }


	// test dotproduct
    // float vec1[10] = {1.2f, 2.4f, 3.6f, 4.8f, 6.0f, 7.2f, 8.4f, 9.6f, 10.8f, 12.0f};
    // float vec2[10] = {0.5f, 1.0f, 1.5f, 2.0f, 2.5f, 3.0f, 3.5f, 4.0f, 4.5f, 5.0f};
	// dot_product_fixedPoint(vec1, vec2, 10);



	// conver random floats
 	float randomFloats[10] = {0.235, 0.678, 0.123, 0.789, 0.456,0.912, 0.334, 0.157, 0.864, 0.479};
	fixedPoint_t sum = 0;
	fixedPoint_t mul = 1 << FXP_FRAC_LEN;
	for (int i = 0; i < 10; i++)
	{
		fixedPoint_t fxp = float_to_fixedPoint(randomFloats[i]);
		sum = add_fixedPoint(sum, fxp);
		mul = mul_fixedPoint(mul, fxp);
		// printf("mul: %.*f\n", FXP_FRAC_LEN, fixedPoint_to_float(mul));

		printf("fix: %.*f\n", FXP_FRAC_LEN, fixedPoint_to_float(fxp));
	}

	printf("sum: %.*f\n", FXP_FRAC_LEN, fixedPoint_to_float(sum));
	printf("mul: %.*f\n", FXP_FRAC_LEN, fixedPoint_to_float(mul));


    return 0;
}