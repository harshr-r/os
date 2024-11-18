#include <stdio.h>
#define MAX_BUFFER 100

int buffer[MAX_BUFFER];
int n;
int in = 0;
int out = 0;

void producer() {
    int value;
    while (((in + 1) % n) != out) {
        printf("Enter value to produce (or type 'q' to stop): ");
        int result = scanf("%d", &value);
        if (result == EOF) {
            printf("\nEnd of input detected. Exiting Producer mode.\n");
            break;
        } else if (result != 1) {
            char ch;
            scanf("%c", &ch);
            if (ch == 'q' || ch == 'Q') {
                printf("Exiting Producer mode.\n");
                break;
            } else {
                printf("Invalid input. Please enter an integer or 'q' to quit.\n");
                while ((ch = getchar()) != '\n' && ch != EOF);
                continue;
            }
        }
        buffer[in] = value;
        printf("Produced: buffer[%d] = %d\n", in, buffer[in]);
        in = (in + 1) % n;
    }
    if (((in + 1) % n) == out) {
        printf("Buffer is full! Cannot produce more items.\n");
    }
}

void consumer() {
    while (in != out) {
        printf("Consumed: buffer[%d] = %d\n", out, buffer[out]);
        out = (out + 1) % n;
    }
    if (in == out) {
        printf("Buffer is empty! Cannot consume more items.\n");
    }
}

int main() {
    int choice;
    int running = 1;
    printf("Enter buffer size (max %d): ", MAX_BUFFER);
    if (scanf("%d", &n) != 1 || n <= 0 || n > MAX_BUFFER) {
        printf("Invalid buffer size! Please enter a positive integer up to %d.\n", MAX_BUFFER);
        return 1;
    }
    while (getchar() != '\n' && getchar() != EOF);
    while (running) {
        printf("\n1. Producer\n2. Consumer\nEnter choice: ");
        if (scanf("%d", &choice) != 1) {
            printf("Invalid input! Exiting program.\n");
            break;
        }
        while (getchar() != '\n' && getchar() != EOF);
        switch (choice) {
            case 1:
                producer();
                break;
            case 2:
                consumer();
                break;
            default:
                printf("Invalid choice. Exiting program.\n");
                running = 0;
                break;
        }
    }
    return 0;
}
