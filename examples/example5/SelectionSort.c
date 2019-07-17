#include <stdio.h>
#include <stdlib.h>

int noOfElements;
int* elements;

void sort() {
    for (int i = 0; i < noOfElements; i++) {
        int minIndex = i;
        for (int j= i+1; j < noOfElements; j++)
            if (elements[j] < elements[minIndex])
                minIndex = j;
        int tmp = elements[i];
        elements[i] = elements[minIndex];
        elements[minIndex] = tmp;
    }
}

int main() {
    scanf("%d", &noOfElements);
    elements = malloc(sizeof(int) * noOfElements);

    for (int i = 0; i < noOfElements; i++)
        scanf("%d", &elements[i]);
    
    sort();

    for (int i = 0; i < noOfElements; i++)
        printf("%d ", elements[i]);

    printf("\n");
    return 0;
}