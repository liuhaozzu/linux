#include <stdio.h>
#define LEN 8
int arr[LEN]={6,3,7,1,2,9,8,0};


void swap(int i,int j){
	int tmp=arr[i];
	arr[i]=arr[j];
	arr[j]=tmp;
}

int partition(int start,int end){
	int pivot=arr[end];
	int i=start-1;
	int j=end;
	while(i<j){
		while(i<j && arr[++i]<pivot){
		}
		while(j>i && arr[--j]>pivot){
		}
		if(i<j){	
			swap(i,j);
		}
	}
	if(j<end){
		swap(j,end);
	}
	printf("sort: %d %d %d %d %d %d %d %d \n",arr[0],arr[1],arr[2],arr[3],arr[4],arr[5],arr[6],arr[7]);
	return j;
}

void  quick_sort(int start,int end){
	int mid;
	if(end>start){
		mid=partition(start,end);
		quick_sort(start,mid-1);
		quick_sort(mid+1,end);
	}
}
int main(void){
	quick_sort(0,LEN-1);
	printf("sort: %d %d %d %d %d %d %d %d \n",arr[0],arr[1],arr[2],arr[3],arr[4],arr[5],arr[6],arr[7]);
}
