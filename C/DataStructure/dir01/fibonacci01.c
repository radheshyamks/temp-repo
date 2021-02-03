#include <stdio.h>
#define N 20
typedef unsigned long long ull;
void fib1();
void fib2();
ull fib_recursion(ull n);
void fib_pre_calc();
static ull*ptr=NULL;
int main(int argc, char* argv[])
{
	fib_pre_calc();
	printf("%s\n", "fib_recursion");
	for(int i=0; i< N; i++){
		printf("%d'th term = %llu\n", i+1, fib_recursion(i));
	}
	printf("cnt = %llu\n", *ptr);
	fib1();
	fib2();
	printf("exiting main...\n");
	return 0;
}
void fib_pre_calc(){
	ull fib[N];
	fib[0] = 0;
	fib[1] = 1;
	static ull cnt;
	printf("%s\n", __FUNCTION__);
	for(int i=2; i< N; i++){
		fib[i] = fib[i-2] + fib[i-1];
		cnt++;
	}
	for(int i=0; i< N; i++){
		printf("%d'th term = %llu\n", 1+i, fib[i]);
	}
	printf("cnt = %llu\n", cnt);
	return;
}
ull fib_recursion(ull n){
	static ull cnt;
	ptr = &cnt;
	if(n==1 || n==0){
		cnt++;
		return n;
	}else{
		cnt++;
		return fib_recursion(n-1)+fib_recursion(n-2);;
	}
}
void fib1(){
	long long i = -1, j = 1;
	static ull cnt;
	ull k;
	printf("%s\n", __FUNCTION__);
	for(int l=0; l<N; l++){
		k = i+j;
		i = j;
		j = k;
		printf("%d'th term = %llu\n", l+1,  k);
		cnt++;
	}
	printf("cnt = %llu\n", cnt);
}
void fib2(){
	long long i=0, j=1;
	static ull cnt;
	ull k=i;
	printf("%s\n", __FUNCTION__);
	for(int l=0; l<N; l++){
		printf("%d'th term = %llu\n", l+1, k);
		i = j;
		j = k;
		k = i+j;
		cnt++;
	}
	printf("cnt = %llu\n", cnt);
}
