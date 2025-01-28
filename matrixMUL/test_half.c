#include <stdio.h>
#include <inttypes.h>


#include <float.h>






#define HALF_PMAX 65504
#define HALF_NMIN -65504

// #define HALF_PMAX 65509
// #define HALF_NMIN -65505

typedef uint16_t HALF;



static inline float saturate_half( float value )
{
	int32_t integer_part = value;
	if (integer_part < HALF_NMIN) {
		return HALF_NMIN;
	}
	else if (integer_part > HALF_PMAX) {
		return HALF_PMAX;
	}
	else {
		return value;
	}
}



static uint32_t halfToFloatI(HALF y)
{
    int s = (y >> 15) & 0x00000001;                            // sign
    int e = (y >> 10) & 0x0000001f;                            // exponent
    int f =  y        & 0x000003ff;                            // fraction

    // need to handle 7c00 INF and fc00 -INF?
    if (e == 0) {
        // need to handle +-0 case f==0 or f=0x8000?
        if (f == 0)                                            // Plus or minus zero
            return s << 31;
        else {                                                 // Denormalized number -- renormalize it
            while (!(f & 0x00000400)) {
                f <<= 1;
                e -=  1;
            }
            e += 1;
            f &= ~0x00000400;
        }
    } else if (e == 31) {
        if (f == 0)                                             // Inf
            return (s << 31) | 0x7f800000;
        else                                                    // NaN
            return (s << 31) | 0x7f800000 | (f << 13);
    }

    e = e + (127 - 15);
    f = f << 13;

    return ((s << 31) | (e << 23) | f);
}

static HALF floatToHalfI(uint32_t i)
{
    register int s =  (i >> 16) & 0x00008000;                   // sign
    register int e = ((i >> 23) & 0x000000ff) - (127 - 15);     // exponent
    register int f =   i        & 0x007fffff;                   // fraction

    // need to handle NaNs and Inf?
    if (e <= 0) {
        if (e < -10) {
            if (s)                                              // handle -0.0
               return 0x8000;
            else
               return 0;
        }
        f = (f | 0x00800000) >> (1 - e);
        return s | (f >> 13);
    } else if (e == 0xff - (127 - 15)) {
        if (f == 0)                                             // Inf
            return s | 0x7c00;
        else {                                                  // NAN
            f >>= 13;
            return s | 0x7c00 | f | (f == 0);
        }
    } else {
        if (e > 30)                                             // Overflow
            return s | 0x7c00;
        return s | (e << 10) | (f >> 13);
    }
}


float HALFToFloat( HALF y )
{
    union { float f; uint32_t i; } v;
    v.i = halfToFloatI(y);
    return v.f;
}

HALF floatToHALF( float i )
{
    union { float f; uint32_t i; } v;
	float rfs = saturate_half(i);
    v.f = rfs;
	// v.f = i;
    return floatToHalfI(v.i);
}


// half operations
HALF mulh( HALF i1, HALF i2 )
{
	float i1f = HALFToFloat(i1);
	float i2f = HALFToFloat(i2);

	float rf = i1f * i2f;

	float rfs = saturate_half(rf);

	HALF r = floatToHALF(rfs);

	return r;
}

HALF addh( HALF i1, HALF i2 )
{
	float i1f = HALFToFloat(i1);
	float i2f = HALFToFloat(i2);

	float rf = i1f + i2f;
	float rfs = saturate_half(rf);

	HALF r = floatToHALF(rfs);

	return r;
}








#define FRAC_LEN 5


int main( void )
{
	printf("[*] sanity check!}\n");

	// float a = 14.321f;
	// float a = 143.3211f;
	// float b = -15.321f;


	// HALF hp1 = floatToHALF(a);
	// HALF hp2 = floatToHALF(b);

	// printf("half1: %.*f\n", FRAC_LEN, HALFToFloat(hp1));
	// printf("half2: %.*f\n", FRAC_LEN, HALFToFloat(hp2));


	// HALF add_res = addh(hp1, hp2);
	// printf("add result: %.*f\n", FRAC_LEN, HALFToFloat(add_res));


	// HALF mul_res = mulh(hp1, hp2);
	// printf("mul result: %.*f\n", FRAC_LEN, HALFToFloat(mul_res));


	// test addition
	// add_res = 0;
	// for (size_t i = 1; i < 11; i++)
	// {
	// 	HALF fxp = floatToHALF(i * 2.41f);
	// 	printf("fxp: %.*f\n", FRAC_LEN, HALFToFloat(fxp));
	// 	add_res = addh(add_res, fxp);
	// 	printf("add result: %.*f\n\n", FRAC_LEN, HALFToFloat(add_res));
	// }


	// test multiplication
	// mul_res = 1;
	// for (size_t i = 1; i < 11; i++)
	// {
	// 	HALF fxp = floatToHALF(i * 2.41f);
	// 	printf("fxp: %.*f\n", FRAC_LEN, HALFToFloat(fxp));
	// 	mul_res = mulh(mul_res, fxp);
	// 	printf("mul result: %.*f\n\n", FRAC_LEN, HALFToFloat(mul_res));
	// }


	// conver random floats
	float randomFloats[10] = {0.235, 0.678, 0.123, 0.789, 0.456,0.912, 0.334, 0.157, 0.864, 0.479};
	HALF sum = 0;
	HALF mul = 1;
	for (int i = 0; i < 10; i++)
	{
		HALF hp = floatToHALF(randomFloats[i]);
		sum = addh(sum, hp);
		mul = mulh(mul, hp);
		printf("half: %.*f\n", FRAC_LEN, HALFToFloat(hp));
	}

	printf("sum: %.*f\n", FRAC_LEN, HALFToFloat(sum));
	printf("mul: %.*f\n", FRAC_LEN, HALFToFloat(mul));

	return 0;
}