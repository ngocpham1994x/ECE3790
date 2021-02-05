package com.company;

import java.util.*;

public class Main {

    public static void main(String[] args) {
        //input raw array:
        System.out.println("Enter size of array: ");
        Scanner keyboard = new Scanner(System.in);

        int size = keyboard.nextInt();

        System.out.println("Please enter largest integer in the array: ");
        int max = keyboard.nextInt();

        long startTime, endTime, elapsedTime;




        //setup array
        int[] theArray1 = new int[size];
        for(int i = 0; i < size; i++)
            theArray1[i]=(int) (Math.random()*max+1);

        int[] theArray2 = new int[theArray1.length];
        System.arraycopy(theArray1, 0, theArray2,0, theArray1.length);







        System.out.println("\nStudent's method \nNon-sorted array: \n"+Arrays.toString(theArray1));

        //#1 Labor work: in-place mergesort array
        startTime = System.nanoTime();
        mergeSort(theArray1);
        endTime = System.nanoTime();
        elapsedTime = endTime-startTime;
        System.out.println("Sorted array: \n"+Arrays.toString(theArray1));
        System.out.println("Elapsed time: "+elapsedTime);






        System.out.println("\nBuilt-in method \nNon-sorted array: \n"+Arrays.toString(theArray2));

        //#2 Built-in library for sorting ascending order
        startTime = System.nanoTime();
        Arrays.sort(theArray1);
        endTime = System.nanoTime();
        elapsedTime = endTime-startTime;
        System.out.println("Sorted array: \n"+Arrays.toString(theArray1));
        System.out.println("Elapsed time: "+elapsedTime);


    } //main





    /*Merge sort Method 2:
     * calling recursive from 0 to length
     * temp array is a blank array to put the merged array in, the deep copy to original array
     */
    public static void mergeSort( int[] array ) {
        int[] temp = new int[array.length];
        mergeSort( array, 0, array.length, temp );
    }

    // end = length of the array
    // merge sort items a[start] to (& including) a[end-1]
    private static void mergeSort( int[] array, int start, int end, int[] temp) {
        int mid;
        if ((end - start) > 1) {
            // Recursive case: if > 1 item
            mid = start + (end-start)/2;
            mergeSort( array, start, mid, temp );
            mergeSort( array, mid, end, temp );
            merge( array, start, mid, end, temp );
        } // Base case: if < 2 items, do nothing
    }


    private static void merge( int[] array, int start, int mid, int end, int [] temp ) {
        int currL = start; // index of current item in left half
        int currR = mid; // index of current item in right half
        int currT; // index in temp

        for ( currT = start; currT < end; currT++ ) {
            if ( currL < mid && ( currR >= end || array[currL] < array[currR] ) ){
                // copy from left half if that value is smaller
                // or if no values remain in the right half
                temp[currT] = array[currL++];
            }
            else   // copy from the right half
                temp[currT] = array[currR++];
        } // end for


        // Copy the merged items into the original array.
        System.arraycopy(temp,start,array,start,end-start);

    } // end merge






    /*Merge sort Method 1:
    * calling recursive from 0 to length-1
    * temp array is the unsorted smaller array before merging
    */
//    public static void mergeSort(int[] arr){
//        mergeSort(arr, 0, arr.length-1); //Call the recursive version
//    }
//
//
//    //Recursive merge sort of array a from positions lo to hi (included)
//    private static void mergeSort(int[] a, int start, int end){
//        //base case: when 1 or 0 element in the array
//        if(end<=start) return;
//
//        //1. Divide: Sort two separate halves of temp, using merge sorts
//        int mid = (start+end)/2;
//        //2. Conquer:
//        mergeSort(a,start,mid);
//        mergeSort(a,mid+1,end);
//        //3. Combine: Merge the two sorted pieces together
//        merge(a, start, end);
//    }
//
//
//
//
//
//    //Merging the elements (of temp array) on the left-hand and on the right-hand, write to the original array (in-place)
//    //arr = the original array
//    //temp = unsorted array, different size as original array
//    private static void merge(int[] arr, int start, int end){
//        int[] temp = new int[end-start+1];
//        System.arraycopy(arr, start, temp, 0, end-start+1);  //copying the values of unsorted to a temp array
//
//        int currL = 0; //index that will move through the first half of temp
//        int midOfTemp = (end-start)/2;  //mid here is the middle of the temp array
//        int currR = midOfTemp + 1; //index that will move through the second half of temp
//        int currIndexInArr = 0;  //keeps track of the number of positions in original array
//
//        while (currL <= midOfTemp && currR < temp.length) {
//            if (temp[currL] <= temp[currR])
//                arr[start + currIndexInArr++] = temp[currL++]; //Overwriting the original array
//            else
//                arr[start + currIndexInArr++] = temp[currR++]; //Overwriting the original array
//        }
//        while (currL <= midOfTemp)
//            arr[start + currIndexInArr++] = temp[currL++];  // if some numbers are left in the first half, copy all of them
//    }


}
