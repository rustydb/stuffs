#include <stdlib.h>
#include <iostream>

using namespace std;

class oacc {
    private:
        int count;
        int *counter;
        oacc() {};
    public:
        oacc(int x) {
        count = x;
        counter = new int[count];
#pragma acc enter data create(nvidia)
#pragma acc update device(nvidia)
#pragma acc enter data create(counter[0:count])
        }
        ~oacc() {
            delete [] counter;
#pragma acc exit data delete(counter[0:count])
#pragma acc exit data delete(nvidia)
        }
};

int main() {
    oacc thing(10);
    //cout << "Count is: " << thing.ret_count() << endl;
    return 0;
}
