#include <stdlib.h>

void swap(double *, double *);

void merge(double *arr, int left, int mid, int right)
{
    int left_size  = mid-left+1;
    int right_size = right-mid ;

    double *arr_left  = ( double * ) malloc( left_size  * sizeof( double ) ),
           *arr_right = ( double * ) malloc( right_size * sizeof( double ) );

    for( int i=left  ; i<=mid   ; i++ )  arr_left[ i-left  ] = arr[ i ];
    for( int i=mid+1 ; i<=right ; i++ ) arr_right[ i-mid-1 ] = arr[ i ];

    int i=left, j=left, k=mid+1;

    while( j<=mid && k<=right ) {
        if( arr_left[ j-left ] < arr_right[ k-mid-1 ] ) {
            arr[ i ] =  arr_left[ j-left ];
            i++;
            j++;
        }
        else {
            arr[ i ] = arr_right[ k-mid-1 ];
            i++;
            k++;
        }
    }

    while( j<=mid  ) {
        arr[ i ] = arr_left[ j-left ];
        i++;
        j++;
    }
    while( k<=right ) {
        arr[ i ] = arr_right[ k-mid-1 ];
        i++;
        k++;
    }

    free(arr_left);
    free(arr_right);
}

void mergesort(double *arr, int left, int right)
{
    if( left<right ) {
        int mid = ( left+right ) / 2;
        mergesort( arr, left, mid );
        mergesort( arr, mid+1, right );
        merge( arr, left, mid, right );
    }
}
