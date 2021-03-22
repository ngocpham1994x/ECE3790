package com.company;

import java.util.Arrays;

public class Main {

    private static int name;

    public static void main(String[] args) {
        // write your code here
        String X = "AGGTAB15txyz2904";
        String Y = "ATAB5y04";
        int m = X.length();
        int n = Y.length();


        long start_recursive = System.nanoTime();
        int length_recursive = recursiveLCS(X,Y,m,n);
        long end_recursive = System.nanoTime();

        long start_memoized = System.nanoTime();
        int length_memoized = memoizedLCS(X,Y,m,n);
        long end_memoized = System.nanoTime();

        long start_bottomUp = System.nanoTime();
        int length_bottomUp = bottomUpLCS(X,Y,m,n);
        long end_bottomUp = System.nanoTime();

        System.out.println();
        System.out.println("Recursive time = " + (end_recursive - start_recursive) + " nanosecs");
        System.out.println("Recursive cost = " + length_recursive);

        System.out.println("Memoized time = " + (end_memoized - start_memoized) + " nanosecs");
        System.out.println("Memoized cost = " + length_memoized);

        System.out.println("Bottom up tim = " + (end_bottomUp - start_bottomUp) + " nanosecs");
        System.out.println("Bottom up cost = " + length_bottomUp);
    }


    public static int recursiveLCS(String X, String Y, int m, int n){
        if (m == 0 || n == 0)
            return 0;
        else if (X.charAt(m-1) == Y.charAt(n-1))
            return (1 + recursiveLCS(X,Y,m-1,n-1));
        else
            return Math.max(recursiveLCS(X,Y,m-1, n), recursiveLCS(X,Y,m,n-1));
    }

    public static int memoizedLCS(String X, String Y, int m, int n) {
        int[][] memo = new int[m][n];

        for (int i = 0; i < m; i++)
            Arrays.fill(memo[i],-1);

        int commonLength = memoizedLCS(X,Y,m,n,memo);

        //printing the actual common subsequence
        printLCS(X,Y,m,n,memo);

        return commonLength;
    }


    public static int memoizedLCS(String X, String Y, int m, int n, int[][] memo){
        if (m == 0 || n == 0)
            return 0;
        else if (memo[m-1][n-1] != -1)
            return memo[m-1][n-1];
        else if (X.charAt(m-1) == Y.charAt(n-1))
            return memo[m-1][n-1] = (1 + memoizedLCS(X,Y,m-1,n-1,memo));
        else
            return memo[m-1][n-1] = Math.max(memoizedLCS(X,Y,m-1, n,memo), memoizedLCS(X,Y,m,n-1,memo));
    }

    //bottom up approach
    public static int bottomUpLCS(String X, String Y, int m, int n){
        int[][] table = new int[m+1][n+1]; //extra 1 column, 1 row for storing empty string
        for(int i = 0; i <= m; i++){
            for(int j = 0; j <= n; j++){
                if (i == 0 || j == 0)
                    table[i][j] = 0;  //common subsequence with an empty string is 0
                else if(X.charAt(i-1) == Y.charAt(j-1)) //"- 1" due to examining the Strings, not the table. So subtract the first column, first row (storing empty strings) for extracting actual two strings
                    table[i][j] = 1 + table[i-1][j-1] ;  //1 + common of past sub-problems
                else    //two chars not match
                    table[i][j] = Math.max(table[i-1][j], table[i][j-1]); //max of two sub-problems
            }
        }
        return table[m][n];
    }


    // printing result below can be shortened if printing from bottom-up approach
    // (does not have to copy "table" over for scenario which first chars of each string are common -> (j-1) = "Index out of bound" )
    public static void printLCS(String X, String Y, int m, int n,int[][] memo){
        int sequenceLength = memo[m-1][n-1];
        char[] commonSequence = new char[sequenceLength];

        //copy "table", first column - first row = 0's
        int[][] table = new int[m+1][n+1];
        for(int i = 1; i < (m+1); i++)
            System.arraycopy(memo[i-1],0,table[i],1,memo[i-1].length);

        int i = m; //for traversing in table
        int j = n; //for traversing in table

        //start from bottom right of the 2D array table
        while(i > 0 && j > 0){
            if(X.charAt(i-1) == Y.charAt(j-1)){
                commonSequence[sequenceLength-1] = X.charAt(i-1);
                i--;
                j--;
                sequenceLength--;
            }
            else if (table[i-1][j] > table[i][j-1])
                i--;
            else
                j--;
        }
        System.out.println(Arrays.toString(commonSequence)); //printing LCS
    }
}

//https://www.youtube.com/watch?v=ASoaQq66foQ


