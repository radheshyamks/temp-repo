#include <iostream>
#include <cstdlib>
#include <cmath>
#include <stdio.h>
#define N 20
int fun(char*, char);
int main(int argc, char* argv[])
{
	constexpr int k = 10;
	int t = k;
	std::cout<<"this is main\n";
	std::cout<<"\nfactorial\n";
	ssize_t factorial[N];
	factorial[0]=1;
	for(ssize_t i=1; i<=N; i++){
		factorial[i] = factorial[i-1]*i;
	}
	for(ssize_t i=0; i<=N; i++){
		std::cout<<" "<<factorial[i];
	}
	std::cout<<std::endl;
	char arr[5] = {'q', 'A', 'e', 'A', 'A'};
	int x = fun(arr, 'A');
	std::cout<<"A repeated "<<x<<" times"<<std::endl;
	return 0;
}
int fun(char* p, char ch)
{
	int count=0;
	if(p==nullptr)
		return 0;
	for(; *p != 0; ++p){
		if(*p == ch)
			count++;
		std::cout<<"*p = "<<*p<<std::endl;
	}
//	std::cout<<"*p = "<<*p<<std::endl;
	return count;
}
