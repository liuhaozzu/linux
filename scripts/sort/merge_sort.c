#include <stdio.h>
#define LEN 5
int arr[LEN]={10,6,3,1,2};

void merge_sort(int start,int mid,int end){
	int n1=mid-start+1;
	int n2=end-mid;
	int left[n1],right[n2];
	int i,j,k;

	for(i=0;i<n1;i++){
		left[i]=arr[start+i];
	}
	for(j=0;j<n2;j++){
		right[j]=arr[mid+1+j];
	}
	i=j=0;
	k=start;

	while(i<n1 && j<n2){
		if(left[i]<right[j]){
			arr[k++]=left[i++];
		}else{
			arr[k++]=right[j++];
		}
	}

	while(i<n1){
		arr[k++]=left[i++];
	}
	while(j<n2){
		arr[k++]=right[j++];
	}
}
void sort(int start,int end){
	int mid;
	if(start<end){
		mid=(start+end)/2;
		printf("sort (%d-%d, %d-%d) %d %d %d %d %d\n",start,mid,mid+1,end, arr[0],arr[1],arr[2],arr[3],arr[4]);
		sort(start,mid);
		sort(mid+1,end);
		merge_sort(start,mid,end);
		printf("sort (%d-%d, %d-%d) %d %d %d %d %d\n",start,mid,mid+1,end, arr[0],arr[1],arr[2],arr[3],arr[4]);

	}
}

int main(void){
	sort(0,LEN-1);
	return 0;
}

