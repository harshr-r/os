#include <stdio.h>
#include <math.h>

void calculateFCFS(int requests[], int n, int head) {
    int total_head_movement = 0;
    int current_position = head;

    printf("\nOrder of requests: ");
    for (int i = 0; i < n; i++) {
        printf("%d ", requests[i]);
        total_head_movement += abs(current_position - requests[i]);
        current_position = requests[i];
    }

    printf("\nTotal head movement: %d\n", total_head_movement);

    float avg = total_head_movement/n;

    printf("\nAvg: %f", avg);
}

int main() {
    int n, head;

    printf("Enter the number of disk requests: ");
    scanf("%d", &n);

    int requests[n];

    printf("Enter the disk requests:\n");
    for (int i = 0; i < n; i++) {
        printf("Request %d: ", i + 1);
        scanf("%d", &requests[i]);
    }

    printf("Enter the initial head position: ");
    scanf("%d", &head);

    calculateFCFS(requests, n, head);


    return 0;
}