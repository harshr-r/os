// SSTF -> Shortest Seek Time First

#include <stdio.h>
#include <stdlib.h>

int main()
{
    int n, head_pointer;

    printf("\nEnter no of Requests Here : ");
    scanf("%d", &n);

    int A[n], Right[n], Left[n];

    int right_count = 0, left_count = 0;

    printf("\nEnter your %d values Here : ", n);
    for(int i = 0; i < n; i++)
        scanf("%d", &A[i]);

    printf("\nEnter your Head Pointer Here : ");
    scanf("%d", &head_pointer);

    for(int i = 0; i < n; i++)
    {
        if(A[i] > head_pointer)
            Right[right_count++] = A[i];
        else
            Left[left_count++] = A[i];
    }

    for(int i = 0; i < left_count; i++)
    {
        for(int j = i+1; j < left_count; j++)
        {
            if(Left[i] > Left[j])
            {
                int temp = Left[i];
                Left[i] = Left[j];
                Left[j] = temp;
            }
        }
    }

    for(int i = 0; i < right_count; i++)
    {
        for(int j = i+1; j < right_count; j++)
        {
            if(Right[i] > Right[j])
            {
                int temp = Right[i];
                Right[i] = Right[j];
                Right[j] = temp;
            }
        }
    }


    int right, left, d1, d2, sum = 0;

    right = 0, left = left_count - 1;

    while(left >= 0 && right < right_count)
    {
        d1 = abs(head_pointer - Right[right]); 

        d2 = abs(head_pointer - Left[left]);

        if(d1 < d2)
        {
            sum = sum + d1;
            head_pointer = Right[right++];
        }
        else
        {
            sum = sum + d2;
            head_pointer = Left[left--];
        }
    }

    while(left >= 0)
    {
        sum = sum + abs(head_pointer - Left[left]);
        head_pointer = Left[left--];
    }


    while(right < right_count)
    {
        sum = sum + abs(head_pointer - Right[right]);
        head_pointer = Right[right++];  
    }

    printf("\nSum = %d", sum);

    return 0;
}