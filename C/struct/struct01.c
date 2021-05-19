#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>
int Int(int, int);
void Char(char, char);
float Float(float, double);
typedef struct abc{
	int (*iptr)(int, int);
	void (*cptr)(char, char);
	float (*fptr)(float, double);
}F;
int main(int argc, char* argv[], char** env)
{
	F s = {Int, Char, Float};
	int i = s.iptr(10, 30);
	s.cptr('A', 'B');
	float f = s.fptr(20.45f, 50.56);
	printf("%d %f\n", i, f);
	printf("offsetof iptr = %lu\n", offsetof(F, iptr));
	printf("offsetof cptr = %lu\n", offsetof(F, cptr));
	printf("offsetof fptr = %lu\n", offsetof(F, fptr));
	return 0;
}
int Int(int i, int j){
	i += 10;
	j += 20;
	printf("this is Int fucntion\n");
	return j*i;
}
void Char(char c1, char c2)
{
	c1+=10;
	c2+=5;
	printf("this is Char function\n");
	printf("%c %c\n", c1, c2);
}
float Float(float f, double d)
{
	f+=30;
	d+=60;
	printf("this is %s function\n",__FUNCTION__);
	return f+(float)d;
}
