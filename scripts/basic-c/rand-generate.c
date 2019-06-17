#include <stdio.h>
#include <stdlib.h>
#define N 20000
int a[N];

void gen_random(int upper_bound)
{
	int i;
	for (i = 0; i < N; i++) {
		a[i] = rand() % upper_bound;
	}
}

void print_random(void)
{
	int i;
	for (i = 0; i < N; i++) {
		printf("%d ", a[i]);
	}
	printf("\n");
}

int howmany(int value)
{
	int count = 0, i;
	for (i = 0; i < N; i++) {
		if (a[i] == value) {
			++count;
		}
	}
	return count;
}

int main(void)
{
	int i;
	gen_random(10);
	printf("value\thow many\n");

	for (i = 0; i < 10; i++) {
		printf("%d\t%d\n", i, howmany(i));
	}

	//print_random();
	return 0;
}
