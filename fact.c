#include<stdio.h>
int main()
{
	int fact=1,n=5;
	for(int i=n;i>=1;i--)
		fact=fact*i;
	printf("%d",fact);
}

