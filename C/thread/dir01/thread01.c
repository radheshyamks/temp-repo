/*addd 1 million natural number*/
#include <stdio.h>
#include <pthread.h>
unsigned long long sum[4];
void* thread_sum(void* arg)
{
	printf("this is thread fun\n");
	int i=0;
	unsigned long val = 4*25000000;
	unsigned long id = (unsigned long)arg;
	unsigned long start = id*(val/4);
	while(i < (val/4)){
		sum[id] += (start + i);
		i++;
	}
	return NULL;
}
int main(int argc, char* argv[]){
	pthread_t tid[4];
	pthread_create(&tid[0], NULL, thread_sum, (void*)0);
	pthread_create(&tid[1], NULL, thread_sum, (void*)1);
	pthread_create(&tid[2], NULL, thread_sum, (void*)2);
	pthread_create(&tid[3], NULL, thread_sum, (void*)3);
	pthread_join(tid[0], NULL);
	pthread_join(tid[1], NULL);
	pthread_join(tid[2], NULL);
	pthread_join(tid[3], NULL);
	printf("grand sum = %llu\n", sum[0]+sum[1]+sum[2]+sum[3]);
	return 0;
}
