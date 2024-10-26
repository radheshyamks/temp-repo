#include <stdio.h>
int main(int argc, char* argv[], char** env)
{
	printf("%d\n", argc);
	for(int i=0; i<argc; i++){
		printf("%s ", argv[i]);
	}
	printf("\nenvironment\n");
	for(int i=0; environ[i] != NULL; i++){
		printf("%s ", environ[i]);
	}
	return 0;
}
