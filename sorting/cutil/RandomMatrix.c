#define _XOPEN_SOURCE
#include <stdlib.h>

#define A( i, j ) *( ap + (j)*lda + (i) ) // march through the matrix in F_CONTIGUOUS (column-major) manner

void RandomMatrix(int m, int n, double *ap, int lda)
/**
 * Overwrites `ap` with random numbers in the range [0, 1)
 * 
 * @param m number of rows in the matrix
 * @param n number of columns in the matrix
 * @param ap pointer to the array
 * @param lda size of an entry in the array
 * 
 * @returns void
 */
{
    int i, j;
    for ( i=0 ; i<m ; i++ )
        for ( j=0 ; j<n ; j++ )
            A( i, j ) = drand48();
}
