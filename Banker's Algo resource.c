#include <stdio.h>

void calculate_need(int n, int m, int max[n][m], int allocation[n][m], int need[n][m]) {
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            need[i][j] = max[i][j] - allocation[i][j];
        }
    }
}

int is_safe(int n, int m, int available[m], int allocation[n][m], int need[n][m]) {
    int work[m];
    int finish[n];
    int safe_sequence[n];
    int count = 0;

    for (int i = 0; i < m; i++) {
        work[i] = available[i];
    }

    for (int i = 0; i < n; i++) {
        finish[i] = 0;
    }

    while (count < n) {
        int found = 0;

        for (int i = 0; i < n; i++) {
            if (!finish[i]) {
                int can_allocate = 1;
                for (int j = 0; j < m; j++) {
                    if (need[i][j] > work[j]) {
                        can_allocate = 0;
                        break;
                    }
                }

                if (can_allocate) {
                    for (int j = 0; j < m; j++) {
                        work[j] += allocation[i][j];
                    }
                    safe_sequence[count++] = i;
                    finish[i] = 1;
                    found = 1;
                }
            }
        }

        if (!found) {
            printf("The system is not in a safe state.\n");
            return 0;
        }
    }

    printf("The system is in a safe state.\nSafe Sequence: ");
    for (int i = 0; i < n; i++) {
        printf("%d ", safe_sequence[i]);
    }
    printf("\n");
    return 1;
}

int request_resources(int process_id, int n, int m, int request[m], int available[m], int allocation[n][m], int need[n][m]) {
    for (int i = 0; i < m; i++) {
        if (request[i] > need[process_id][i]) {
            printf("Error: Process %d requested more than its need.\n", process_id);
            return 0;
        }
        if (request[i] > available[i]) {
            printf("Process %d must wait since resources are not available.\n", process_id);
            return 0;
        }
    }

    for (int i = 0; i < m; i++) {
        available[i] -= request[i];
        allocation[process_id][i] += request[i];
        need[process_id][i] -= request[i];
    }

    if (is_safe(n, m, available, allocation, need)) {
        printf("Process %d has been allocated the resources.\n", process_id);
        return 1;
    } else {
        for (int i = 0; i < m; i++) {
            available[i] += request[i];
            allocation[process_id][i] -= request[i];
            need[process_id][i] += request[i];
        }
    }
}