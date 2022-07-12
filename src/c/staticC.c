#include <stdio.h>
//
// Author: Russell Bunch
//
int staticVarMethod(){
	static int counter = 0 ;
	return counter++ ;
}
int main() {
	printf("%x\n",staticVarMethod()) ;
	printf("%x\n",staticVarMethod()) ;
	printf("%x\n",staticVarMethod()) ;
	return 0 ;
}
