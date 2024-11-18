#include<stdio.h>
int main()
{
	int n,j,i;
	printf("Enter the no of processes: ");
	scanf("%d",&n);
	int p[n],s,allocated=-1;
	printf("Enter the size of each process:\n");
	for(i=0;i<n;i++)
	{
		printf("Size of p%d: ",i+1);
		scanf("%d",&p[i]);
	}
	printf("Enter the no of memory slots: ");
	scanf("%d",&s);
	int sl[s],bn[s];
	printf("Enter the size of each slot:\n");
	for(i=0;i<s;i++)
	{
		printf("Size of s%d: ",i+1);
		scanf("%d",&sl[i]);
	}
	for(i=0;i<n;i++)
	{
		for(j=0;j<s;j++)
		{
			if(sl[j]==allocated)
			     continue;
			else if(p[i]<=sl[j])
			{
				sl[j]=allocated;
				bn[j]=i+1;
				break;
		    }
		}
    }
    printf("\nProcess No.\tProcess Size\tBlock No.\n");
    for (i = 0; i < n; i++)
	 {
        printf("%d\t\t%d\t\t",i + 1, p[i]);
        if(bn[i] != 0)
            printf("%d\n",bn[i]);
        else
            printf("Not Allocated\n");
    }
}