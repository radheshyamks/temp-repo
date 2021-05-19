#include <stdio.h>
#include <error.h>
#include <stdlib.h>
/* gets
 * puts
 * putc
 * getchar
 * fputs
 * fputc
 * putchar
 * fopen()
 * fclose()
 * fprintf();
 * fscanf();
 * */
int main(int argc, char* argv[])
{
	FILE* fptr = fopen("../WRfile.txt", "w");
	if(fptr == NULL){
		perror("file can not be open\n");
		exit(-1);
	}
	printf("------------Enter * to break the loop-----------------\n");
	char ch;
	while(1){
		ch = getchar();
		if('*' == ch){
			break;
		}
		int err = fputc(ch, fptr);
		if(err == EOF){
			perror("fail to write to WRfile.txt file\n");
			exit(-1);
		}
	}
	fclose(fptr);
	return 0;
}
