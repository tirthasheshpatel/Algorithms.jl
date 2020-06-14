#include <stdlib.h>

int maxelement(int *arr, int n)
{
    int max_index = 0, i;
    for( i=0 ; i<n ; i++ ) if( arr[i] > arr[max_index] ) max_index = i;
    return max_index;
}

void countingsort(int *arr, int *aux, int n)
{
    int max_index     = maxelement(arr, n), i;
    int freq_arr_size = arr[max_index] + 1;

    int *freq = ( int * ) calloc( freq_arr_size, sizeof( int ) );

    for( i=0 ; i<n ; i++ ) {
        freq[ arr[ i ] ]++;
    }

    for( i=1 ; i<arr[ max_index ] + 1 ; i++ ) freq[ i ] += freq[ i-1 ];

    for( i=0 ; i<n ; i++ ) {
        aux[ freq[ arr[ i ] ] - 1 ] = arr[ i ];
        freq[ arr[ i ] ]--;
    }
}
