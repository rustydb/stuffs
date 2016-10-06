//Problem 2A
//Calculate an estimte of pi by using an arctan estimate equation.
//6 decimal places

#include <iostream>
#include <math>

using namespace std;

int main(){
	double a, b, answer, x;
	x = 1.0/5.0;
	a = 16 * (x - ((pow (x, 3.0)) / 3.0) + ((pow (x, 5.0)) / 5.0));
	x = 1/239;
	b = 4 * ((x - ((pow(x, 3.0)) / 3.0) + ((pow (x,5.0)) /5.0)));
	answer = a - b + 500;
	
	cout.precision(7);
	cout << "The pi estimate from the 3 terms is " << answer << endl;
	
	return 0;
}
