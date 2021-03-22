package com.company;

import java.util.Arrays;

public class Main {
//0 1 1 2 3 5 8 13 21 34 55 89 144 233 ...
    public static void main(String[] args) {
        long result_recursive = 0;
        long result_memozied = 0;
        long result_bottomUp = 0;
        int n = 15;

        long start_recursive = System.nanoTime();
        result_recursive = recursiveFibonacci(n);
        long end_recursive = System.nanoTime();

        long start_memoized = System.nanoTime();
        result_memozied = memoizedFibonacci(n);
        long end_memoized = System.nanoTime();

        long start_bottomUp = System.nanoTime();
        result_bottomUp = bottomupFibonacci(n);
        long end_bottomUp = System.nanoTime();

        System.out.println("Recursive time = " + (end_recursive - start_recursive)/(Math.pow(10,9)) + " secs");
        System.out.println("Recursive result = " + result_recursive);

        System.out.println("Memozied time = " + (end_memoized - start_memoized)/(Math.pow(10,9)) + " secs");
        System.out.println("Top down memoized result = " + result_memozied);

        System.out.println("Bottom-up time = " + (end_bottomUp - start_bottomUp)/(Math.pow(10,9)) + " secs");
        System.out.println("Bottom up table result = " + result_bottomUp);
    }

    //naive recursive approach
    public static long recursiveFibonacci(int n){
        if (n <= 1)
            return n;
        else
            return recursiveFibonacci(n-1) + recursiveFibonacci(n-2);
    }
    public static long memoizedFibonacci(int n){
        long[] memo = new long[n+1];
        long result = memoizedFibonacci(memo,n);
//        System.out.println(Arrays.toString(memo));
        return result;
    }

    //top down + memoized approach
    public static long memoizedFibonacci(long[] memo,int n) {
        if (n <= 1)
            return memo[n] = n;
        else if (memo[n] != 0)
            return memo[n];
        else
            return memo[n]= memoizedFibonacci(memo, n - 1) + memoizedFibonacci(memo, n - 2);

    }

    //bottom up + table approach
    public static long bottomupFibonacci(int n) {
        long[] table = new long[n + 1];
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

//