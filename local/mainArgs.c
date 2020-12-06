#include <stdio.h>
int main(int argc, char* argv[], char** env)
{
	printf("%d\n", argc);
	for(int i=0; i<argc; i++){
		printf("%s ", argv[i]);
	}
	printf("\nenvironment\n");
	for(int i=0; env[i] != NULL; i++){
		printf("%s ", env[i]);
	}
	return 0;
}
