package com.company;

public class Main {

    public static void main(String[] args) {
	// write your code here
        int[] nvec = new int[]{5000,10000,15000,20000,25000,30000,35000,40000,45000,50000};
        int[] costsFunction1 = evaluateRecurrence(1,nvec);
        int[] costsFunction2 = evaluateRecurrence(nvec);
        int[] costsFunction3 = evaluateRecurrence(nvec);
    }

    public static int[] evaluateRecurrence (int num,int[] nvec){
        int[] costs = new int[nvec.length];
        if(num=1)
        for(int i = 0; i < costs.length; i++)
            costs[i] = myFunction1(nvec[i]);

        return costs;
    }

    private static int myFunction1(int n){
        int cost = 0;
        if (n>2)
            cost = (1+2*myFunction1(n/2)+n);    //T1(n) = 1 + 2T(n/2) + n (Merge Sort)
        //else, do nothing. Base case.

        return cost;
    }

    private static int myFunction2(int n){
        int cost = 0;
        if (n>1)
            cost =  (2*myFunction2(n-1)+1);    //T2(n) = 2T(n − 1) + 1 (Tower of Hanoi)
        //else, do nothing. Base case.

        return cost;
    }

    private static int myFunction3(int n){
        int cost = 0;
        if (n>3)
            cost = (5*myFunction3(n/3)+n);    //T3(n) = 5T(n/3) + n
        //else, do nothing. Base case.

        return cost;
    }

}
