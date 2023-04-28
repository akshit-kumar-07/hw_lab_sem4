#include <stdio.h>
int main()
{
	int n;scanf("%d",&n);
	int i=0;int arr[n];
	while(i<n){
		scanf("%d",&arr[i]);
		i++;
	}
	int max=1;int min=99;int ele1=0;int ele2=0;
	int j=0;i=0;
	while(i<n){
		int count=0;
		j=0;
		while(j<n){
			if(arr[i]==arr[j]) count++;
			j++;
		}
		//printf("num=%d count=%d\n",arr[i],count);
		if(count>max) {max=count;ele1=arr[i];}
		if(count<min) {min=count;ele2=arr[i];}
		i++;
	}
	if(max==1) printf("No mode\n");
	if(max>1) printf("the element having max freq is %d\n",ele1);
	if(min==1 && max==1) printf("No min mode\n");
	if(max!=1) printf("the element having min freq is %d\n",ele2);
	return 0;
}
