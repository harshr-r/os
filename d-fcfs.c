// FCFS => First Come First Serve

#include <stdio.h>
#include <stdlib.h>

int main()
{
    int n, i, hp, st = 0;
    float avg;

    printf("\nEnter the Request value Size Here : ");
    scanf("%d", &n);

    int R[n];

    printf("\nEnter %d Request Values Here : ", n);
    for(i = 0; i < n; i++)
        scanf("%d", &R[i]);

    printf("\nEnter your Head Pointer Value : ");
    scanf("%d", &hp);

    for(i = 0; i < n; i++)
    {
        st += abs(hp - R[i]);
        hp = R[i];
    }

    avg = (float)st / n;

    printf("\nThe Total Sum is %d", st);

    printf("\nThe Average value is %.2f ", avg);

    return 0;
}