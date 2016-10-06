#include <stdio.h>
//
// Author: Russell Bunch
//
/*
 * Basic C struct. Needs struct keyword
 * for every instantiation.
 */
struct dog {
	int numLegs ;
	int maxRunVel ;
} ;
/*
 * Typedef struct for C, gives a label and
 * it allows things to be declared as
 * def_cat (or cat) "name of object" without
 * the "struct" keyword in front of the
 * instantiation.
 */
typedef struct cat {
	int numLegs ;
} def_cat ;
int main() {
	// Dog
	struct dog hurtDog ;
	printf("hurtDog with no specified legs: %d\n", hurtDog.numLegs) ;
	hurtDog.numLegs = 3 ;
	printf("hurtDog with 3 legs: %d\n", hurtDog.numLegs) ;
	struct dog hurtDogPuppy ;
	printf("hurtDogPuppy with no specified legs: %d\n", hurtDogPuppy.numLegs) ;
	// Cat
	def_cat mutatedCat ;
	printf("mutatedCat with no specified legs: %d\n", mutatedCat.numLegs) ;
	mutatedCat.numLegs = 5 ;
	printf("mutatedCat with 5 legs: %d\n", mutatedCat.numLegs) ;
	def_cat mutatedCatKitten ;
	printf("mutatedCatKitten with no specified legs: %d\n", mutatedCatKitten.numLegs) ;
	return 0 ;
}