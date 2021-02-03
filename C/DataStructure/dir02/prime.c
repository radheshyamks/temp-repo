#include <stdio.h>
#include <math.h>
typedef unsigned long long uint32_t;
void sqrt_prime(uint32_t, uint32_t);
void loop_prime(uint32_t, uint32_t);
int main(int argc, char* argv[])
{
	uint32_t x, y;
	printf("Enter the Range: ");
	scanf("%llu%llu", &x, &y);
	printf("\nsqrt prime\n");
	sqrt_prime(x, y);
	printf("\nloop prime\n");
	loop_prime(x, y);
	return 0;
}
void sqrt_prime(uint32_t x, uint32_t y)
{
	unsigned char flag=1;
	uint32_t cnt=0;
	for(; x<=y ; x++){
		flag=1;
		for(uint32_t i=2; i <= sqrt(x); i++){
			cnt++;
			if(x%i == 0){
				flag=0;
				break;
			}
		}
		if(flag==1){
			printf("%llu ", x);
		}
	}
	printf("\nsqrt count=%llu\n", cnt);
}
/*bad algorithm*/
void loop_prime(uint32_t x, uint32_t y)
{
	uint32_t k, cnt=0;
	for(; x<=y; x++){
		k=0;
		for(uint32_t i=2; i<x; i++){
			cnt++;
			if(x%i == 0){
				k++;
			}
		}
		if(k==0){
			printf("%llu ", x);
		}
	}
	printf("\nloop count=%llu\n", cnt);
}
