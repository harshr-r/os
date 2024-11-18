#include <stdio.h>

int available[3] = {10, 5, 7};
int max[5][3] = {{7, 3, 9}, {2, 0, 2}, {3, 2, 2}, {2, 2, 3}, {3, 3, 2}};
int allocation[5][3] = {{0, 1, 0}, {2, 0, 0}, {3, 0, 2}, {2, 1, 1}, {0, 0, 2}};
int need[5][3];

void calculate_need() {
  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 3; j++) {
      need[i][j] = max[i][j] - allocation[i][j];
    }
  }
}

int is_safe() {
  int work[3];
  int finish[5] = {0};
  int safe_sequence[5];
  int count = 0;

  for (int i = 0; i < 3; i++) {
    work[i] = available[i];
  }

  while (count < 5) {
    int found = 0;

    for (int i = 0; i < 5; i++) {
      if (!finish[i]) {
        int can_allocate = 1;

        for (int j = 0; j < 3; j++) {
          if (need[i][j] > work[j]) {
            can_allocate = 0;
            break;
          }
        }

        if (can_allocate) {
          for (int j = 0; j < 3; j++) {
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
  for (int i = 0; i < 5; i++) {
    printf("%d ", safe_sequence[i]);
  }
  printf("\n");
  return 1;
}

int main() {
  calculate_need();
  is_safe();
  return 0;
}