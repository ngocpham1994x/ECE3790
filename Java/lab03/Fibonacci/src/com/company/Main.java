package com.company;

import java.util.Arrays;

public class Main {
//0 1 1 2 3 5 8 13 21 34 55 89 144 233 ...
    public static void main(String[] args) {
        int result_recursive = 0;
        int result_memozied = 0;
        int result_bottomUp = 0;
        int n = 30;

        long start_recursive = System.nanoTime();
        result_recursive = recursiveFibonacci(n);
        long end_recursive = System.nanoTime();

        long start_memoized = System.nanoTime();
        result_memozied = memoizedFibonacci(n);
        long end_memoized = System.nanoTime();

        long start_bottomUp = System.nanoTime();
        result_bottomUp = bottomupFibonacci(n);
        long end_bottomUp = System.nanoTime();

        System.out.println("Recursive time = " + (end_recursive - start_recursive) + " nanosecs");
        System.out.println("Recursive result = " + result_recursive);

        System.out.println("Memozied time = " + (end_memoized - start_memoized) + " nanosecs");
        System.out.println("Top down memoized result = " + result_memozied);

        System.out.println("Bottom-up time = " + (end_bottomUp - start_bottomUp) + " nanosecs");
        System.out.println("Bottom up table result = " + result_bottomUp);
    }

    //naive recursive approach
    public static int recursiveFibonacci(int n){
        if (n <= 1)
            return n;
        else
            return recursiveFibonacci(n-1) + recursiveFibonacci(n-2);
    }
    public static int memoizedFibonacci(int n){
        int[] memo = new int[n+1];
        int result = memoizedFibonacci(memo,n);
//        System.out.println(Arrays.toString(memo));
        return result;
    }

    //top down + memoized approach
    public static int memoizedFibonacci(int[] memo,int n) {
        if (n <= 1)
            return memo[n] = n;
        else if (memo[n] != 0)
            return memo[n];
        else
            return memo[n]= memoizedFibonacci(memo, n - 1) + memoizedFibonacci(memo, n - 2);

    }

    //bottom up + table approach
    public static int bottomupFibonacci(int n) {
        int[] table = new int[n + 1];
        for (int i = 0; i <= n; i++) {
            if (i <= 1)
                table[i] = i;
            else {
                table[i] = table[i - 1] + table[i - 2];
            }
        }
//        System.out.println(Arrays.toString(table));
        return table[n];
    }
}
