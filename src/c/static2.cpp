#include <iostream>
using namespace std ;
//
// Author: Russell Bunch
//
/* Example 2:
 * This node class demonstrates what happens without
 * declaring counter as a static variable.
 */
class node {
	public:
		int counter ;
		node() {
			counter = 0 ;
		}
} ;
int main() {
	node first ;
	first.counter = 1 ;
	node second ;
	node third ;
	third.counter = 3 ;
	cout << first.counter << endl <<
			second.counter << endl <<
			third.counter << endl ;
}