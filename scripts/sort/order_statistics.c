#include <stdio.h>
#define LEN 5
int arr[LEN]={5,1,3,2,6};


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
int order_statistics(int start,int end,int k){
	int mid=partition(start,end);

	if(mid==k){
		return arr[k];
	}else if(mid>k){
		return order_statistics(start,mid,k);
	}else{
		return order_statistics(k-mid,end,k-mid);
	}
}
int main(void){
	return order_statistics(0,LEN-1,3);
}
