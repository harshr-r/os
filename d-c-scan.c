// C-SCAN

#include <stdio.h>
#include <stdlib.h>

int main() {
    int n, hp, high, seek_time = 0;

    printf("\nEnter your no: of Resources Here : ");
    scanf("%d", &n);

    int R[n];

    printf("\nEnter your %d Resource values Here : ", n);
    for (int i = 0; i < n; i++)
        scanf("%d", &R[i]);

    printf("\nEnter your Head Pointer value Here : ");
    scanf("%d", &hp);

    printf("\nEnter your High Limit here : ");
    scanf("%d", &high);

    int Right[n], Left[n], len1 = 0, len2 = 0;

    Right[len1++] = high, Left[len2++] = 0;

    for (int i = 0; i < n; i++) {
        if (R[i] > hp)
            Right[len1++] = R[i];
        else
            Left[len2++] = R[i];
    }

    // Sorting Right array in ascending order
    for (int i = 0; i < len1-1; i++) {
        for (int j = i + 1; j < len1; j++) {
            if (Right[i] > Right[j]) {
                int temp = Right[i];
                Right[i] = Right[j];
                Right[j] = temp;
            }
        }
    }

    // Sorting Left array in descending order
    for (int i = 0; i < len2-1; i++) {
        for (int j = i + 1; j < len2; j++) {
            if (Left[i] > Left[j]) {
                int temp = Left[i];
                Left[i] = Left[j];
                Left[j] = temp;
            }
        }
    }

    // Processing Right array
    for (int i = 0; i < len1; i++) {
        seek_time += abs(hp - Right[i]);
        hp = Right[i];
    }

    // Processing Left array
    for (int i = 0; i < len2; i++) {
        seek_time += abs(hp - Left[i]);
        hp = Left[i];
    }

    float avg = (float)seek_time / n;

    printf("\nThe Total Seek Time is %d", seek_time);
    printf("\nThe Average Seek Time is %.2f\n", avg);

    return 0;
}