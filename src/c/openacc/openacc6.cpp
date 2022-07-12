#include <string> // Strings
#include <iostream> // cout
#include <stdlib.h> // rand

using namespace std;

/*
 * Test OpenACC with basic class containing a private member and functions to access it
 */
class array {
    int foo[10000];
    public:
        void mod(int, int);
        int ret(int);
        int* ret();
};

void array::mod(int j, int x) {
    foo[j] = x;
}

int array::ret(int j) {
    return foo[j];
}

int* array::ret() {
    return foo;
}

int main() {
    array arr;
    int i, random;
    static unsigned int seed = 5323;
    // pseudo-random generator
#pragma acc kernels loop
    for (i = 0; i < 1000; i++) {
        //foo[i] = rand(); // rand not available on accelerator
        random = ((seed = (8253729 * seed + 2396403)) % 3276795);
        arr.mod(i, random);
    }
    for (i = 0; i < 1000; i++) {
        cout << arr.ret(i) << "\n";
    }
    cout << endl;
    return 1;
}
