#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <sys/wait.h>

int main() {
	char* cmd = (char*)"ls -a";
	FILE* fpipe = popen(cmd, "w");
}