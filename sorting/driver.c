#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <math.h>

/* High precision clock. */
double FLA_Clock();

/* Generate a random matrix with values [0,1) using a uniform sampler. */
void RandomMatrix(int, int, double *, int);

/* Swap double precision points */
void swap(double *, double *);

/* Quick Sort */
void quicksort(double *, int, int);

/* Counting Sort */
void countingsort(int *, int *, int);

/* Merge Sort */
void mergesort(double *, int, int);


int main(int argc, char *argv[])
{
    if( argc != 6 ) {
        fprintf(stderr, "usage: ./driver.x <alog> <nrep> <first> <last> <inc>\n");
        return 1;
    }

    int
        first, last, inc, nrep,
        i = 0, j = 0, size;

    double
        dtime, dtime_best;

    int
        *A, *B;

    double
        *C;

    nrep  = atoi( argv[2] );
    first = atoi( argv[3] );
    last  = atoi( argv[4] );
    inc   = atoi( argv[5] );

    last   = ( last / inc ) * inc;
    first  = ( first / inc ) * inc;
    first  = ( first == 0 ? inc : first );

    printf("size, time\n");

    if( strcmp( argv[1] , "counting" ) == 0 ) {
        for( size=last ; size>=first ; size-=inc ) {
            A = ( int * ) malloc( size * sizeof( int ) );
            B = ( int * ) malloc( size * sizeof( int ) );

            for( i=0 ; i<nrep ; i++ ) {
                for( j=0 ; j<size ; j++ ) A[ j ] = rand() % 1000000;

                dtime = FLA_Clock();

                /* Invoke Counting Sort */
                countingsort(A, B, size);

                dtime = FLA_Clock() - dtime;

                if( i == 0 ) dtime_best = dtime;
                else dtime_best = ( dtime < dtime_best ? dtime : dtime_best );
            }

            dtime_best = dtime_best * 1.0e09;
            printf("%5d, %8.4le\n", size, dtime_best);

            free( A );
            free( B );
        }
    }
    else if( strcmp( argv[1] , "quick" ) == 0 ) {
        for( size=last ; size>=first ; size-=inc ) {
            C = ( double * ) malloc( size * sizeof( double ) );

            for( i=0 ; i<nrep ; i++ ) {
                RandomMatrix(size, 1, C, size);

                dtime = FLA_Clock();

                /* Invoke Quick Sort */
                quicksort( C, 0, size-1 );

                dtime = FLA_Clock() - dtime;

                if( i == 0 ) dtime_best = dtime;
                else dtime_best = ( dtime < dtime_best ? dtime : dtime_best );
            }

            dtime_best = dtime_best * 1.0e09;
            printf("%5d, %8.4le\n", size, dtime_best);

            free( C );
        }
    }
    else if( strcmp( argv[1] , "merge" ) == 0 ) {
        for( size=last ; size>=first ; size-=inc ) {
            C = ( double * ) malloc( size * sizeof( double ) );

            for( i=0 ; i<nrep ; i++ ) {
                RandomMatrix(size, 1, C, size);

                dtime = FLA_Clock();

                /* Invoke Merge Sort */
                mergesort( C, 0, size-1 );

                dtime = FLA_Clock() - dtime;

                if( i == 0 ) dtime_best = dtime;
                else dtime_best = ( dtime < dtime_best ? dtime : dtime_best );
            }

            dtime_best = dtime_best * 1.0e09;
            printf("%5d, %8.4le\n", size, dtime_best);

            free( C );
        }
    }

    return 0;
}
