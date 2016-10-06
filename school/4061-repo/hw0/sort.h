// file containing various sorting algorithms written in C

// Quicksort
void quicksort( int a[], int l, int r) {
	int j ;
	if( l < r ) {
		// divide and conquer
		j = partition( a, l, r) ;
		quicksort( a, l, j-1) ;
		quicksort( a, j+1, r) ;
	}	
}
int partition( int a[], int l, int r) {
	int pivot, i, j, t ;
	pivot = a[l] ;
	i = l; j = r+1 ;
	while( 1) {
		do ++i; while( a[i] <= pivot && i <= r ) ;
		do --j; while( a[j] > pivot ) ;
		if( i >= j ) break ;
		t = a[i]; a[i] = a[j]; a[j] = t ;
	}
	t = a[l]; a[l] = a[j]; a[j] = t ;
	return j ;
}