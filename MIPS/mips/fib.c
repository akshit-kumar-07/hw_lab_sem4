#include <stdio.h>
int main()
{
	int n;scanf("%d",&n);
	int a=1;int b=1;
	printf("%d %d ",a,b);
	int i=3;
	while(i<=n)
	{
		int temp=b;
		b=a+b;
		a=temp;
		printf("%d ",b);
		i++;
	}
	return 0;
}
