// Banker's Algo resource req
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


// Banker's Algo
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

// FCFS with arrival
#include <stdio.h>

int main() {
    int n;
    printf("Enter the number of processes: ");
    scanf("%d", &n);

    int p[n], bt[n], at[n], ct[n], tat[n], wt[n];

    for (int i = 0; i < n; i++) {
        p[i] = i + 1;
    }

    printf("Enter burst time for each process:\n");
    for (int i = 0; i < n; i++) {
        printf("Process %d: ", i + 1);
        scanf("%d", &bt[i]);
    }

    printf("Enter arrival time for each process:\n");
    for (int i = 0; i < n; i++) {
        printf("Process %d: ", i + 1);
        scanf("%d", &at[i]);
    }


    for (int i = 0; i < n - 1; i++) {
        for (int j = i + 1; j < n; j++) {
            if (at[i] > at[j]) {

                int temp = at[i];
                at[i] = at[j];
                at[j] = temp;

                temp = bt[i];
                bt[i] = bt[j];
                bt[j] = temp;

                temp = p[i];
                p[i] = p[j];
                p[j] = temp;
            }
        }
    }

    int current_t = 0;
    for (int i = 0; i < n; i++) {
        if (current_t < at[i]) {
            current_t = at[i];
        }
        ct[i] = current_t + bt[i];
        tat[i] = ct[i] - at[i];
        wt[i] = tat[i] - bt[i];
        current_t = ct[i];
    }

    float total_tat = 0, total_wt = 0;
    for (int i = 0; i < n; i++) {
        total_tat += tat[i];
        total_wt += wt[i];
    }

    float avg_tat = total_tat / n;
    float avg_wt = total_wt / n;

    printf("\nProcess ID\tBurst Time\tArrival Time\tCompletion Time\tTurnaround Time\tWaiting Time\n");
    for (int i = 0; i < n; i++) {
        printf("%d\t\t%d\t\t%d\t\t%d\t\t%d\t\t%d\n", p[i], bt[i], at[i], ct[i], tat[i], wt[i]);
    }

    printf("\nAverage Turnaround Time: %.2f\n", avg_tat);
    printf("Average Waiting Time: %.2f\n", avg_wt);

}


// FCFS without arrival
#include <stdio.h>

int main() {
    int n;
    printf("Enter the number of processes: ");
    scanf("%d", &n);

    int p[n], bt[n], at[n], ct[n], tat[n], wt[n];
    float total_wt = 0, total_tat = 0;

    for (int i = 0; i < n; i++) {
        p[i] = i + 1;
        at[i] = 0;
    }

    printf("Enter burst time for each process:\n");
    for (int i = 0; i < n; i++) {
        printf("Process %d: ", i + 1);
        scanf("%d", &bt[i]);
    }

    ct[0] = bt[0];
    tat[0] = ct[0] - at[0];
    wt[0] = tat[0] - bt[0];
    total_tat += tat[0];
    total_wt += wt[0];

    for (int i = 1; i < n; i++) {
        ct[i] = ct[i - 1] + bt[i];
        tat[i] = ct[i] - at[i];
        wt[i] = tat[i] - bt[i];
        total_tat += tat[i];
        total_wt += wt[i];
    }

    printf("\nProcess ID\tBurst Time\tArrival Time\tCompletion Time\tTurnaround Time\tWaiting Time\n");
    for (int i = 0; i < n; i++) {
        printf("%d\t\t%d\t\t%d\t\t%d\t\t%d\t\t%d\n", p[i], bt[i], at[i], ct[i], tat[i], wt[i]);
    }

    float avg_tat = total_tat / n;
    float avg_wt = total_wt / n;

    printf("\nAverage Turnaround Time: %.2f", avg_tat);
    printf("\nAverage Waiting Time: %.2f", avg_wt);
}


//fork
#include <stdio.h> 
#include <unistd.h> 
int main() 
{ 
	fork(); 
	fork() && fork() || fork(); 
	fork(); 

	printf("forked\n"); 
	return 0; 
}

// first fit
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

// producer consumer
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

// rr
#include <stdio.h>

int main() {
    int n, tq;
    printf("Enter the number of processes: ");
    scanf("%d", &n);

    printf("Enter the time quantum: ");
    scanf("%d", &tq);

    int p[n], bt[n], rbt[n], ct[n], tat[n], wt[n];
    float total_tat = 0, total_wt = 0;

    for (int i = 0; i < n; i++) {
        p[i] = i + 1;
    }

    printf("Enter burst time for each process:\n");
    for (int i = 0; i < n; i++) {
        printf("Process %d: ", i + 1);
        scanf("%d", &bt[i]);
        rbt[i] = bt[i];
    }

    int current_t = 0;
    int completed = 0;

    while (completed < n) {
        for (int i = 0; i < n; i++) {
            if (rbt[i] > 0) {
                if (rbt[i] > tq) {
                    current_t += tq;
                    rbt[i] -= tq;
                } else {
                    current_t += rbt[i];
                    ct[i] = current_t;
                    tat[i] = ct[i];
                    wt[i] = tat[i] - bt[i];
                    total_tat += tat[i];
                    total_wt += wt[i];
                    rbt[i] = 0;
                    completed++;
                }
            }
        }
    }

    printf("\nProcess ID\tBurst Time\tCompletion Time\tTurnaround Time\tWaiting Time\n");
    for (int i = 0; i < n; i++) {
        printf("%d\t\t%d\t\t%d\t\t%d\t\t%d\n", p[i], bt[i], ct[i], tat[i], wt[i]);
    }

    printf("\nAverage Turnaround Time: %.2f\n", total_tat / n);
    printf("Average Waiting Time: %.2f\n", total_wt / n);

}

//sjf without arrival
#include <stdio.h>

int main() {
    int n;
    printf("Enter the number of processes: ");
    scanf("%d", &n);

    int p[n], bt[n], at[n], ct[n], tat[n], wt[n];
    float total_tat = 0, total_wt = 0;

    for (int i = 0; i < n; i++) {
        p[i] = i + 1;
        at[i] = 0;
    }

    printf("Enter burst time for each process:\n");
    for (int i = 0; i < n; i++) {
        printf("Process %d: ", i + 1);
        scanf("%d", &bt[i]);
    }

    for (int i = 0; i < n - 1; i++) {
        for (int j = i + 1; j < n; j++) {
            if (bt[i] > bt[j]) {
                int temp_bt = bt[i];
                bt[i] = bt[j];
                bt[j] = temp_bt;

                int temp_p = p[i];
                p[i] = p[j];
                p[j] = temp_p;
            }
        }
    }

    int current_t = 0;

    for (int i = 0; i < n; i++) {
        ct[i] = current_t + bt[i];
        tat[i] = ct[i] - at[i];
        wt[i] = tat[i] - bt[i];
        current_t = ct[i];

        total_tat += tat[i];
        total_wt += wt[i];
    }

    printf("\nProcess ID\tBurst Time\tArrival Time\tCompletion Time\tTurnaround Time\tWaiting Time\n");
    for (int i = 0; i < n; i++) {
        printf("%d\t\t%d\t\t%d\t\t%d\t\t%d\t\t%d\n", p[i], bt[i], at[i], ct[i], tat[i], wt[i]);
    }

    printf("\nAverage Turnaround Time: %.2f", total_tat / n);
    printf("\nAverage Waiting Time: %.2f", total_wt / n);
}

//SRTF
#include <stdio.h>

int main() {
    int n;
    printf("Enter the number of processes: ");
    scanf("%d", &n);

    int id[n], at[n], bt[n], rt[n], ct[n], tat[n], wt[n];
    float total_tat = 0, total_wt = 0;

    printf("Enter arrival time and burst time for each process:\n");
    for (int i = 0; i < n; i++) {
        id[i] = i + 1;
        printf("Process %d:\n", id[i]);
        printf("Arrival Time: ");
        scanf("%d", &at[i]);
        printf("Burst Time: ");
        scanf("%d", &bt[i]);
        rt[i] = bt[i];
    }

    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (at[j] > at[j + 1]) {
                int temp = at[j];
                at[j] = at[j + 1];
                at[j + 1] = temp;

                temp = bt[j];
                bt[j] = bt[j + 1];
                bt[j + 1] = temp;

                temp = rt[j];
                rt[j] = rt[j + 1];
                rt[j + 1] = temp;

                temp = id[j];
                id[j] = id[j + 1];
                id[j + 1] = temp;
            }
        }
    }

    int completed = 0, current_time = 0, shortest = -1;

    while (completed < n) {
        shortest = -1;

        for (int i = 0; i < n; i++) {
            if (at[i] <= current_time && rt[i] > 0) {
                if (shortest == -1 || rt[i] < rt[shortest]) {
                    shortest = i;
                }
            }
        }

        if (shortest == -1) {
            current_time++;
            continue;
        }

        rt[shortest]--;
        current_time++;

        if (rt[shortest] == 0) {
            ct[shortest] = current_time;
            tat[shortest] = ct[shortest] - at[shortest];
            wt[shortest] = tat[shortest] - bt[shortest];
            total_tat += tat[shortest];
            total_wt += wt[shortest];
            completed++;
        }
    }

    printf("\nProcess ID\tArrival Time\tBurst Time\tCompletion Time\tTurnaround Time\tWaiting Time\n");
    for (int i = 0; i < n; i++) {
        printf("%d\t\t%d\t\t%d\t\t%d\t\t%d\t\t%d\n", id[i], at[i], bt[i], ct[i], tat[i], wt[i]);
    }

    printf("\nAverage Turnaround Time: %.2f\n", total_tat / n);
    printf("Average Waiting Time: %.2f\n", total_wt / n);

    return 0;
}


//c-look
// C-LOOK

#include <stdio.h>
#include <stdlib.h>

int main() {
    int n, hp, seek_time = 0;

    printf("\nEnter your no: of Resources Here : ");
    scanf("%d", &n);

    int R[n];

    printf("\nEnter your %d Resource values Here : ", n);
    for (int i = 0; i < n; i++)
        scanf("%d", &R[i]);

    printf("\nEnter your Head Pointer value Here : ");
    scanf("%d", &hp);

    int Right[n], Left[n], len1 = 0, len2 = 0;

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

//c-scan
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

//fcfs
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

//look
// LOOK

#include <stdio.h>
#include <stdlib.h>

int main() {
    int n, hp, seek_time = 0;

    printf("\nEnter your no: of Resources Here : ");
    scanf("%d", &n);

    int R[n];

    printf("\nEnter your %d Resource values Here : ", n);
    for (int i = 0; i < n; i++)
        scanf("%d", &R[i]);

    printf("\nEnter your Head Pointer value Here : ");
    scanf("%d", &hp);

    //printf("\nEnter your High Limit here : ");
    //scanf("%d", &high);

    int Right[n], Left[n], len1 = 0, len2 = 0;

    //Right[len1++] = high;

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
            if (Left[i] < Left[j]) {
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

//scan
// SCAN

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

    Right[len1++] = high;

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
            if (Left[i] < Left[j]) {
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

//sstf
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

//First fit
#include <stdio.h>

int main() {
    int n, i, m, j, count = 0, k;

    printf("\nEnter the number of Processors: ");
    scanf("%d", &n);

    int P[n], I[n];  // Array for Process values and allocation markers

    printf("\nEnter %d Process Values: ", n);
    for(i = 0; i < n; i++) {
        scanf("%d", &P[i]);
    }

    printf("\nEnter the number of Memory Blocks: ");
    scanf("%d", &m);

    int B[m];  // Array for Memory Block sizes

    printf("\nEnter %d Memory Values: ", m);
    for(i = 0; i < m; i++) {
        scanf("%d", &B[i]);
    }

    printf("\n P[n]          B[m]        \n\n");
    for(i = 0; i < m; i++) {
        if(i < n) {
            printf("P%d = %d", i, P[i]);
            printf("          B%d = %d\n", i, B[i]);
        } else {
            printf("                  B%d = %d\n", i, B[i]);
        }
    }

    // First Fit Algorithm for memory allocation
    for(i = 0; i < n; i++) {
        for(j = 0; j < m; j++) {
            if(P[i] <= B[j]) {
                // Check if block B[j] is already allocated
                for(k = 0; k < count; k++) {
                    if(I[k] == j)
                        break;
                }

                // If not allocated, allocate the memory block to the processor
                if(count == k) {
                    B[j] = P[i];
                    I[count] = j;  // Mark the block as allocated
                    count++;       // Increment the count of allocated blocks
                    break;
                }
            }
        }
    }

    // Output after allocation
    printf("\nAfter Allocating the value Memory Block is:\n");

    for(i = 0; i < m; i++) {
        if(i < n) {
            printf("P%d = %d", i, P[i]);
            printf("          B%d = %d\n", i, B[i]);
        } else {
            printf("                  B%d = %d\n", i, B[i]);
        }
    }

    return 0;
}



//Best fit
#include <stdio.h>

void bestFit(int P[], int n, int B[], int m) {
    int I[n];  // Array for memory block allocation markers
    int count = 0;  // Track number of allocated blocks

    printf("\nBest Fit Allocation:\n");
    
    // Best Fit Algorithm
    for(int i = 0; i < n; i++) {
        int bestIdx = -1;
        int minDiff = 99999;  // Set to a large number

        for(int j = 0; j < m; j++) {
            // Check if block B[j] can accommodate process P[i]
            if(P[i] <= B[j]) {
                int diff = B[j] - P[i];
                if(diff < minDiff) {
                    minDiff = diff;
                    bestIdx = j;
                }
            }
        }

        // If a suitable block is found, allocate it
        if(bestIdx != -1) {
            B[bestIdx] -= P[i];  // Deduct the size of the process from the block
            printf("Process P%d allocated to Block B%d (Remaining Block Size: %d)\n", i, bestIdx, B[bestIdx]);
        } else {
            printf("Process P%d cannot be allocated\n", i);
        }
    }
}

int main() {
    int n, m;

    printf("\nEnter the number of Processes: ");
    scanf("%d", &n);

    int P[n];  // Array for Process values

    printf("\nEnter %d Process Sizes: ", n);
    for(int i = 0; i < n; i++) {
        scanf("%d", &P[i]);
    }

    printf("\nEnter the number of Memory Blocks: ");
    scanf("%d", &m);

    int B[m];  // Array for Memory Block sizes

    printf("\nEnter %d Memory Block Sizes: ", m);
    for(int i = 0; i < m; i++) {
        scanf("%d", &B[i]);
    }

    // Display the processes and memory blocks
    printf("\nProcesses and Memory Blocks:\n");
    printf("\nP[n]          B[m]\n\n");
    for(int i = 0; i < m; i++) {
        if(i < n) {
            printf("P%d = %d", i, P[i]);
            printf("          B%d = %d\n", i, B[i]);
        } else {
            printf("                  B%d = %d\n", i, B[i]);
        }
    }

    // Call Best Fit Allocation
    bestFit(P, n, B, m);

    return 0;
}

//Worst-Fit
#include <stdio.h>

void worstFit(int P[], int n, int B[], int m) {
    int I[n];  // Array for memory block allocation markers
    int count = 0;  // Track number of allocated blocks

    printf("\nWorst Fit Allocation:\n");

    // Worst Fit Algorithm
    for(int i = 0; i < n; i++) {
        int worstIdx = -1;
        int maxDiff = -1;  // Set to a small number

        for(int j = 0; j < m; j++) {
            // Check if block B[j] can accommodate process P[i]
            if(P[i] <= B[j]) {
                int diff = B[j] - P[i];
                if(diff > maxDiff) {
                    maxDiff = diff;
                    worstIdx = j;
                }
            }
        }

        // If a suitable block is found, allocate it
        if(worstIdx != -1) {
            B[worstIdx] -= P[i];  // Deduct the size of the process from the block
            printf("Process P%d allocated to Block B%d (Remaining Block Size: %d)\n", i, worstIdx, B[worstIdx]);
        } else {
            printf("Process P%d cannot be allocated\n", i);
        }
    }
}

int main() {
    int n, m;

    printf("\nEnter the number of Processes: ");
    scanf("%d", &n);

    int P[n];  // Array for Process values

    printf("\nEnter %d Process Sizes: ", n);
    for(int i = 0; i < n; i++) {
        scanf("%d", &P[i]);
    }

    printf("\nEnter the number of Memory Blocks: ");
    scanf("%d", &m);

    int B[m];  // Array for Memory Block sizes

    printf("\nEnter %d Memory Block Sizes: ", m);
    for(int i = 0; i < m; i++) {
        scanf("%d", &B[i]);
    }

    // Display the processes and memory blocks
    printf("\nProcesses and Memory Blocks:\n");
    printf("\nP[n]          B[m]\n\n");
    for(int i = 0; i < m; i++) {
        if(i < n) {
            printf("P%d = %d", i, P[i]);
            printf("          B%d = %d\n", i, B[i]);
        } else {
            printf("                  B%d = %d\n", i, B[i]);
        }
    }

    // Call Worst Fit Allocation
    worstFit(P, n, B, m);

    return 0;
}


