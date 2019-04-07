#include <stdio.h>
unsigned int a,b,mask=0x0000ff00;
int main(void){	
	a=0x12345678;
	b=(a&mask)>>8;
	printf("%d",b);
}
