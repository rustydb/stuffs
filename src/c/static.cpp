#include <iostream>
using namespace std ;
//
// Author: Russell Bunch
//
/* Example 1:
 * This node class demonstrates how a counter can
 * be used to count each time a class is instantiated.
 * Static is used here because it keeps a running total.
 */
class node {
	public:
		static int counter ;
		node(){
			counter++ ;
		}
} ;
	/*
	 * This is the preferred way to access a static member of
	 * a class. We can do this without instantiating an object
	 * of the class because counter exists independently of each
	 * instantiated object (because it is static). This will
	 * always modify the variable (comparing it to the access
	 * method below).
	 */
int node::counter = 0 ;
int main() {
	/*
	 * You can access static member from a class (still before
	 * instantiating an object of that class) in a method.
	 * This is only ran when the method is called.
	 */
	// node::counter = 1 ;
	node first ;
	node second ;
	node third ;
	cout << first.counter << endl <<
			second.counter << endl <<
			third.counter << endl ;
	return 0 ;
}