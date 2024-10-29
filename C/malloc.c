#include <stdio.h>
#include <stdlib.h>
#define BUFF_SIZE 10
int main(int argc, char* argv[],char** env){
	char* cptr = (char*)malloc(sizeof(char)*BUFF_SIZE);
	for(int i=0; i<BUFF_SIZE; i++){
		if(i==BUFF_SIZE-1){
			cptr[i] = '\0';
		}else{
			cptr[i] = 'A'+i;
		}
	}
	printf("%s\n", cptr);
	return 0;
}
