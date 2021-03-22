package com.company;

import java.util.Arrays;

public class Main {

    private static int name;

    public static void main(String[] args) {
	// write your code here
        int[] matrixSize = new int[]{10, 20, 30, 40, 30};//,10, 20, 30, 40, 30,10,20,30};


        long start_recursive = System.nanoTime();
        int cost_recursive = recursiveMCM(matrixSize,1,matrixSize.length-1);
        long end_recursive = System.nanoTime();

        long start_memoized = System.nanoTime();
        int cost_memoized = memoizedMCM(matrixSize,1,matrixSize.length-1);
        long end_memoized = System.nanoTime();

        long start_bottomUp = System.nanoTime();
        int cost_bottomUp = bottomUpMCM(matrixSize);
        long end_bottomUp = System.nanoTime();

        System.out.println();
        System.out.println("Recursive time = " + (end_recursive - start_recursive) + " nanosecs");
        System.out.println("Recursive cost = " + cost_recursive);

        System.out.println("Memoized time = " + (end_memoized - start_memoized) + " nanosecs");
        System.out.println("Memoized cost = " + cost_memoized);

        System.out.println("Bottom up tim = " + (end_bottomUp - start_bottomUp) + " nanosecs");
        System.out.println("Bottom up cost = " + cost_bottomUp);
    }


    public static int recursiveMCM(int[] matrixSize, int start, int end){
        int cost = 0;
        int min = Integer.MAX_VALUE;
        if (start == end)
            return 0;
        else {
            for(int k = start; k < end; k++){
                cost = recursiveMCM(matrixSize, start, k) + recursiveMCM(matrixSize, k+1, end) + matrixSize[start-1]*matrixSize[k]*matrixSize[end];
                if(cost < min)
                    min = cost;
            }
        }
        return min;
    }

    public static int memoizedMCM(int[] matrixSize, int start, int end) {
        int[][] memo = new int[matrixSize.length][matrixSize.length];
        for(int i = 0; i < matrixSize.length; i++)
            Arrays.fill(memo[i],-1);

        int cost = memoizedMCM(matrixSize, start, end, memo);


//        System.out.println(Arrays.toString(memo));
        name = 1;
        parenthesizeMCM(start, end, matrixSize.length, memo);
        return cost;
    }

    //(A1) x (A2 x A3 x A4 x A5 x ... x An)
    //(A1 x A2) x (A3 x A4 x A5 x ... x An)
    //(A1 x A2 x A3) x (A4 x A5 x ... x An)
    //top down approach
    public static int memoizedMCM(int[] matrixSize, int start, int end, int[][] memo){
        int cost, costLeft, costRight;
        if(start == end)
            return memo[start][end] = 0;
        else if (memo[start][end] != -1)
            return memo[start][end];
        else {
            memo[start][end] = Integer.MAX_VALUE;
            for (int k = start; k < end; k++) {
                costLeft = memoizedMCM(matrixSize, start, k, memo);
                costRight = memoizedMCM(matrixSize, k + 1, end, memo);
                cost = costLeft + costRight + matrixSize[start - 1] * matrixSize[k] * matrixSize[end];

                //find the best split (least cost)
                if(cost < memo[start][end]){
                    memo[start][end] = cost;
                    memo[end][start] = k;
                }
                memo[start][end] = Math.min(cost, memo[start][end]);
            }
            return memo[start][end];
        }
    }

    //bottom up approach
    public static int bottomUpMCM(int[] matrixSize){
        int cost;
        int[][] table = new int[matrixSize.length][matrixSize.length];

//        for(int i = 0; i < matrixSize.length; i++){
//            Arrays.fill(table[i], 0);  //fill in the table with cost of 0, cost of multiply one matrix
//        }

        for(int length = 2; length < matrixSize.length; length++){
            for(int i = 1; i < matrixSize.length - length + 1; i++){
                int j = i + length - 1;
                table[i][j] = Integer.MAX_VALUE;
                for (int k = i; k <= j - 1; k++){
                    cost = table[i][k] + table[k+1][j] + matrixSize[i-1] * matrixSize[k] * matrixSize[j];
                    if(cost < table[i][j]){
                        table[i][j] = cost;
                        table[j][i] = k;
                    }
                }
            }
        }


//        System.out.println(Arrays.toString(table));
//        name = 'A';
//        parenthesizeMCM(1, matrixSize.length - 1 , matrixSize.length, table);
        return table[1][matrixSize.length-1];
    }


    //printing result from either top-down approach (memo) or bottom-up approach (table)
    //by uncomment the codes for printing in specific approach
    //results are the same for both approaches
    public static void parenthesizeMCM(int start, int end, int n, int[][] memo){
        if (start == end) {
            System.out.print("A" + name++);
            return;
        }

            System.out.print("(");
            parenthesizeMCM(start, memo[end][start], n, memo);
            parenthesizeMCM(memo[end][start] +1 , end, n, memo);
            System.out.print(")");

    }
}


//https://www.youtube.com/watch?v=JMql7zF87aE