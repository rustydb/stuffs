#include <string> // Strings
#include <iostream> // cout
#include <stdlib.h> // rand
//#include <array> // throws CC++11 error
//#include <algorithm> // is_sorted {only in C++11, if using 11 then uncomment this and comment out template}

using namespace std;

/*
 * Test OpenACC with basic class containing a public member and an augmented quicksort
 */
class myarray {
    public:
        int foo[10000];
};

// Workaround for not using C++11
//template <class ForwardIterator>
    //bool is_sorted (ForwardIterator first, ForwardIterator last) {
    //if (first==last) return true;
    //ForwardIterator next = first;
    //while (++next!=last) {
        //if (*next<*first)     // or, if (comp(*next,*first)) for version (2)
          //return false;
        //++first;
    //}
    //return true;
//}

int partition(int* input, int p, int r) {
    int pivot = input[r];
    #pragma acc data copyin(input[p:r])
    #pragma acc kernels
    for (p; p < r;) {
        for(p; input[p] < pivot; p++) {
        }
        for(r; input[r] > pivot; r--) {
        }
    #pragma acc data copyout(input[:])
    //while (p < r) {
        //while (input[p] < pivot)
            //p++;

        //while (input[r] > pivot)
            //r--;
        if (input[p] == input[r])
            p++;
        else if (p < r) {
            int tmp = input[p];
            input[p] = input[r];
            input[r] = tmp;
        }
    }
    return r;
}

void quicksort(int arr[], int p, int r) {
    if (p < r) {
        int j = partition(arr, p, r);
        quicksort(arr, p, j - 1);
        quicksort(arr, j + 1, r);
    }
}

int main() {
    myarray arr;
    int i;
    static unsigned int seed = 5323;
    // pseudo-random generator
#pragma acc kernels
    for (i = 0; i < 1000; i++) {
        //foo[i] = rand(); // rand not available on accelerator
        arr.foo[i]  = ((seed = (8253729 * seed + 2396403)) % 3276795);
    }
    quicksort(arr.foo, 0, 999);
    for (i = 0; i < 1000; i++) {
        cout << arr.foo[i] << "\n";
    }
    cout << endl;
    return 1;
}
