// Attempt at a manual deep-copy
#include <stdlib.h> // malloc, free
#include <openacc.h> // openacc
#include <string> // std namespace, strings

using namespace std;

struct oacc {
    int n;
    int *x;
};

int main() {
    struct oacc *A;
    struct oacc *dA = acc_copyin(A, 2*sizeof(struct oacc));
    for (int i = 0; i < 2; i++) {
        int *dx = acc_copyin(A[i].x, A[i].n*sizeof(int));
        acc_memcpy_to_device(&dA[i].x, &dx, sizeof(int*));
    }
}
