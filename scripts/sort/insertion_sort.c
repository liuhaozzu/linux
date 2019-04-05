#include <stdio.h>
#define LEN 5
int arr[LEN]={10,5,2,4,7};
void insertion_sort(void){
	int i,j,key;
	for(j=1;j<LEN;j++){
		printf("%d, %d, %d, %d, %d\n",arr[0],arr[1],arr[2],arr[3],arr[4]);
		key=arr[j];
		i=j-1;
		while(i>=0 && arr[i]>key){
			arr[i+1]=arr[i];
			i--;
		}
		arr[i+1]=key;
	}
	printf("%d, %d, %d, %d, %d\n",arr[0],arr[1],arr[2],arr[3],arr[4]);
}
int main(void){
	insertion_sort();
	return 0;
}
