void swap(int* a, int* b)
{
    int temp = *a;
    *a = *b;
    *b = temp;
}

int partition(int *arr, int start, int end)
{
    int pivot = arr[end];
    int i = start-1, j = start, k = end;

    while( j != k ) {
        if( arr[ j ] <= arr[ k ] ) {
            i++;
            swap( &arr[ i ], &arr[ j ] );
        }
        j++;
    }
    swap( &arr[ i+1 ], &arr[ k ] );

    return i+1;
}

void quicksort(int *arr, int start, int end)
{
    if(start < end) {
        int i = partition( arr, start, end );
        quicksort( arr, start, i-1 );
        quicksort( arr,   i+1, end );
    }
}
