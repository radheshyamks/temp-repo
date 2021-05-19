#include <stdio.h>
#include <string.h>
int main(int argc, char* argv[])
{
	char str1[10] = "thisis";
	char str2[100] = "Clanguage";
	printf("%s\n", str1);
	printf("%s\n", str2);
	char* str3 = strcat(str2, str1);
	printf("str1 = %s\n", str1);
	printf("str2 = %s\n", str2);
	printf("str3 = %s\n", str3);
	return 0;
}
