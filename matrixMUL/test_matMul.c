#include <stdio.h>
#include <stdbool.h>
#include <inttypes.h>

// set precision for matrix printing
#define PRINT_PRECISION 6

#define FXP_FRAC_LEN 6
#define FXP_SCALE_FACTOR (1 << FXP_FRAC_LEN)

#define FXP_PMAX 32767
#define FXP_NMIN -32768

typedef int16_t fixedPoint_t;



#define HALF_PMAX 65504
#define HALF_NMIN -65504

typedef uint16_t HALF;




static inline fixedPoint_t saturate_fixedPoint( int32_t value )
{
	const int32_t temp = (value < FXP_NMIN) ? FXP_NMIN : value;
	return (temp > FXP_PMAX) ? FXP_PMAX : temp;
}


static inline fixedPoint_t float_to_fixedPoint( float value )
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










// This is a pretty demanding function. loops through all elements twice
void print_matrix( float *matrix, size_t row_len, size_t column_len )
{
    int w, width = 0;

    // check that inputs are valid
    if (matrix == NULL || row_len < 2 || column_len < 2) {
        printf("cannot print matrix\n");
        return;
    }


    for (size_t i = 0; i < row_len; i++)
    {
        for (size_t j = 0; j < column_len; j++)
        {
            w = snprintf(NULL, 0, "%.*f", PRINT_PRECISION, matrix[i * row_len + j]);
            if (width < w) {
                width = w;
            }
        }
    }

    for (size_t i = 0; i < row_len; i++)
    {
        printf("[");
        for (size_t j = 0; j < column_len; j++)
        {
            printf("%*.*f", width+2, PRINT_PRECISION, matrix[i * row_len + j]);
        }
        printf("]\n");
    }
}





int Matrxi_Mul( float *A, float *B,
                float *Result,
				int rows_of_A, int columns_of_A,
				int rows_of_B, int columns_of_B,
				bool Fix_Or_Float16 )
{

    // check for null pointers
    if (A == NULL || B == NULL || Result == NULL) {
		fprintf(stderr, "[!] NULL pointer(s) given as input matrix");
        return 0;
    }

    // check that multiplication is possible
    if (columns_of_A != rows_of_B)
    {
		fprintf(stderr, "[!] (columns of matrix A) != (rows of matrix B)");
        return 0;
    }


    if (Fix_Or_Float16)
    {
		printf("using fixed point s16.%d:\n", FXP_FRAC_LEN);
		fixedPoint_t temp = 0, sum = 0;

		for (int i = 0; i < rows_of_A; i++)
		{
			for (int j = 0; j < columns_of_B; j++)
			{
				sum = 0;
				for (int k = 0; k < columns_of_A; k++)
				{
					temp = mul_fixedPoint( float_to_fixedPoint(A[i * columns_of_A + k]), float_to_fixedPoint(B[k * columns_of_B + j]) );
					sum = add_fixedPoint(sum, temp);
				}
				Result[i * columns_of_B + j] = fixedPoint_to_float(sum);
			}
		}
    }
    else
    {
        printf("using half precision:\n");
		HALF temp = 0, sum = 0;

		for (int i = 0; i < rows_of_A; i++)
		{
			for (int j = 0; j < columns_of_B; j++)
			{
				sum = 0;
				for (int k = 0; k < columns_of_A; k++)
				{
					temp = mulh( floatToHALF(A[i * columns_of_A + k]), floatToHALF(B[k * columns_of_B + j]) );
					sum = addh(sum, temp);
				}
				Result[i * columns_of_B + j] = HALFToFloat(sum);
			}
		}
    }

    print_matrix(Result, rows_of_A, columns_of_B);

    return 1;
}









int main( void )
{
    printf("sanity check..\n");
    // float array1[][3] = {{1,2,3}, {4,5,6}, {7,8,9}};
	// float array1[][3] = {{1}, {4}, {6}};
    // float array2[][3] = {{1,2,3}, {4,5,6}, {7,8,9}};
    // float result[3][3];

	float array1[][2] = {{56.3, 54.9}, {3.5, 12.1}};
	float array2[][2] = {{66.5, 61.5}, {74.2, 86.5}};
	// float array1[][2] = {{1.3, 2.9}, {3.5, 4.1}};
	// float array2[][2] = {{5.5, 6.5}, {7.2, 8.5}};
	float result[2][2];

	 int ret;
    // ret = Matrxi_Mul(*array1, (float*)array2, *result, 3, 3, 3, 3, true);
	ret = Matrxi_Mul(*array1, *array2, *result, 2, 2, 2, 2, true);
    if (!ret) {
        printf("failed matrix multiplication...\n");
    }

	// float array3[][2] = {{0.5, 2.3}, {3.9, 7.1}};
	// float array4[][2] = {{1.4, 6.8}, {5.5, 2.6}};
    float array3[2][2] = {{54.5, 2.3}, {44.9, 72.1}};
    float array4[2][2] = {{55.4, 44.8}, {53.5, 22.6}};


	float result2[2][2];

	ret = Matrxi_Mul(*array3, *array4, *result2, 2, 2, 2, 2, false);
    if (!ret) {
        printf("failed matrix multiplication...\n");
    }

	float A[][3] = {{1.0, 2.0, 3.0},
				{4.0, 5.0, 6.0}}; // 2x3 matrix

	float B[][2] = {{7.0, 8.0},
				{9.0, 10.0},
				{11.0, 12.0}}; // 3x2 matrix


	int rows_of_A = 2, columns_of_A = 3;
	int rows_of_B = 3, columns_of_B = 2;

	float Result[rows_of_A][columns_of_B];


	// Result Matrix:
	// 58.00 64.00
	// 139.00 154.00

	int status = Matrxi_Mul(*A, *B, *Result, rows_of_A, columns_of_A, rows_of_B, columns_of_B, false);

    if (status) {
		printf("succ! status code: %d\n", status);
    } else {
        printf("Matrix multiplication failed with status code: %d\n", status);
    }


   float matrix1[][10] = {
        {0.13f, 0.42f, 0.75f, 0.89f, 0.32f, 0.56f, 0.27f, 0.81f, 0.90f, 0.14f},
        {0.48f, 0.19f, 0.68f, 0.93f, 0.58f, 0.21f, 0.94f, 0.33f, 0.77f, 0.72f},
        {0.60f, 0.83f, 0.35f, 0.50f, 0.66f, 0.40f, 0.72f, 0.62f, 0.28f, 0.91f},
        {0.29f, 0.56f, 0.82f, 0.64f, 0.75f, 0.12f, 0.51f, 0.34f, 0.91f, 0.43f},
        {0.85f, 0.74f, 0.67f, 0.29f, 0.15f, 0.56f, 0.77f, 0.93f, 0.41f, 0.69f},
        {0.32f, 0.95f, 0.81f, 0.52f, 0.21f, 0.43f, 0.63f, 0.79f, 0.87f, 0.59f},
        {0.39f, 0.17f, 0.93f, 0.88f, 0.23f, 0.71f, 0.12f, 0.45f, 0.56f, 0.27f},
        {0.77f, 0.64f, 0.56f, 0.94f, 0.18f, 0.73f, 0.25f, 0.68f, 0.84f, 0.49f},
        {0.81f, 0.98f, 0.53f, 0.47f, 0.77f, 0.92f, 0.35f, 0.42f, 0.79f, 0.36f},
        {0.44f, 0.19f, 0.61f, 0.68f, 0.36f, 0.75f, 0.59f, 0.82f, 0.57f, 0.74f}
    };
    float matrix2[][10] = {
        {0.51f, 0.64f, 0.72f, 0.87f, 0.93f, 0.19f, 0.55f, 0.34f, 0.77f, 0.12f},
        {0.36f, 0.58f, 0.49f, 0.25f, 0.67f, 0.29f, 0.79f, 0.53f, 0.85f, 0.60f},
        {0.82f, 0.74f, 0.45f, 0.33f, 0.91f, 0.25f, 0.36f, 0.64f, 0.11f, 0.89f},
        {0.71f, 0.97f, 0.56f, 0.39f, 0.40f, 0.68f, 0.18f, 0.54f, 0.82f, 0.20f},
        {0.92f, 0.17f, 0.29f, 0.83f, 0.12f, 0.67f, 0.57f, 0.36f, 0.90f, 0.41f},
        {0.73f, 0.50f, 0.85f, 0.19f, 0.59f, 0.28f, 0.97f, 0.81f, 0.62f, 0.95f},
        {0.45f, 0.90f, 0.27f, 0.13f, 0.49f, 0.33f, 0.72f, 0.81f, 0.67f, 0.61f},
        {0.39f, 0.74f, 0.15f, 0.53f, 0.61f, 0.84f, 0.82f, 0.71f, 0.50f, 0.16f},
        {0.65f, 0.92f, 0.21f, 0.41f, 0.28f, 0.73f, 0.54f, 0.19f, 0.94f, 0.12f},
        {0.78f, 0.81f, 0.60f, 0.27f, 0.72f, 0.36f, 0.49f, 0.40f, 0.99f, 0.55f}
    };
	float resss[10][10];

	status = Matrxi_Mul(*matrix1, *matrix2, *resss, 10, 10, 10, 10, true);

	status = Matrxi_Mul(*matrix1, *matrix2, *resss, 10, 10, 10, 10, false);




    return 0;
}