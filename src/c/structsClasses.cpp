#include <iostream>
#include <string>
using namespace std ;
//
// Authors: Russell Bunch
//
struct dog {
	int numLegs ;
	string name ;
} ;
class cat {
	private:
		int numLegs ;
		string eyeColor ;
	protected:
		string familyMeow ;
	public:
		void setLegs(int newLegs) {
			numLegs = newLegs ;
		}
		void setEyeColor(string newEyeColor) {
			eyeColor = newEyeColor ;
		}
		void print() {
			cout << "Number of legs: " << numLegs << endl ;
			cout << "Eye color: " << eyeColor << endl ;
		}
} ;
class myCat:cat {
	string name ;
	public:
		void setName(string name) {
			this->name = name ;
		}
		void setMeow(string meow) {
			familyMeow = meow ;
		}
		void print() {
			cout << "Name: " << name << endl ;
			cout << "Family Meow Sign: " << familyMeow << endl ;
		}
} ;
int main() {
	// struct
	dog corgie ;
	corgie.numLegs = 2 ;
	cout <<  "Enter a name for the corgie: " << endl ;
	cin >> corgie.name ;
	// class
	cat tabby ;
	tabby.setLegs(4) ;
	tabby.setEyeColor("Brown") ;
	// inheriting
	myCat cocoa ;
	cocoa.setName("Cocoa") ;
	cocoa.setMeow("meowmeow") ;
	// printing
	cout << "Corgie numLegs: " << corgie.numLegs << endl ;
	cout << "Corgie eyeColor: " << corgie.name << endl ;
	cout << "Tabby properties" << endl ;
	tabby.print() ;
	cout << "Cocoa properties" << endl ;
	cocoa.print() ;
	return 0 ;
}