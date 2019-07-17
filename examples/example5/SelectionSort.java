import java.util.*;

class SelectionSort {

    private static Scanner sc = new Scanner(System.in);
    private static int noOfElements;
    private static int elements[];

    public static void main (String [] args) {
        noOfElements=sc.nextInt();
        elements = new int[noOfElements];

        for (int i = 0; i < noOfElements; i++)
            elements[i] = sc.nextInt();

        sort();
        
        for (int i = 0; i < noOfElements; i++)
            System.out.format("%d ", elements[i]);
        System.out.println();
    }

    private static void sort() {
        for (int i = 0; i < noOfElements-1; i++) {
            int minIndex = i;
            for (int j = i+1; j < noOfElements; j++)
                if (elements[j] < elements[minIndex])
                    minIndex = j;
            int tmp = elements[i];
            elements[i] = elements[minIndex];
            elements[minIndex] = tmp;
        }
    }
}