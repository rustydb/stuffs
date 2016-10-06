#include <iostream>
#include <cstdlib> // rand, RAND_MAX

using namespace std;

int main () {
    /* This makes a seed with the system clock. Allowing a different
     * random number to be generated. Without this, a random number
     * is created once, so every subsequent time we run this program
     * it will always have the same number (which obviously we don't want)
     */
    srand(time(NULL));
    /*
     * rand() returns a random integer, however there is a 'max' value
     * that rand() returns called RAND_MAX. Dividing by this gives us a
     * decimal (since we are getting a 'percentage'). Static casting (or
     * even regular casting as per the commented example) to a double gives
     * us a random number between 0.0 and 1.0.
     */
    double ran_num = static_cast<double>(rand())/RAND_MAX;
    // double ran_num = (double)(rand()/RAND_MAX);
    cout << "Random number is: " << ran_num << endl;
    return 0;
}

