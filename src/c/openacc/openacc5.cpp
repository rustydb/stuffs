#include <stdio.h>
#include <iostream>

using namespace std;

class myarray {
    public:
        int foo[10000];
};

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
    //for (i = 0; i < 1000; i++) {
        //cout << arr.foo[i] << "\n";
    //}
    //cout << endl;
    return 1;
}
