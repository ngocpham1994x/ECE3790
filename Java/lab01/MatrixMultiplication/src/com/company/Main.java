package com.company;

//Library EJML for Matrix multiplication:
//http://ejml.org/wiki/index.php?title=Main_Page
//https://www.baeldung.com/java-matrix-multiplication
import org.ejml.simple.SimpleMatrix;

import java.util.*;
import java.util.concurrent.TimeUnit;

public class Main {

    public static void main(String[] args) {
        //random integer value
        System.out.println("Matrix A (m-rows,p-columns) x Matrix B (p-rows, n-columns) = Matrix C (m-rows, n-columns). \nEnter size of matrices (m,p,n values): ");
        Scanner keyboard = new Scanner(System.in);
//        int size = keyboard.nextInt();  //for consistent testing

        int m = keyboard.nextInt(); //matrix A rows
        int p = keyboard.nextInt(); //matrix A columns = matrix B rows
        int n = keyboard.nextInt(); //matrix B columns

        double startTime, endTime, elapsedTimeBuiltIn, elapsedTimeMethod;

        System.out.println("Enter largest integer value in the matrix: ");
        int max = keyboard.nextInt();

        System.out.println("Matrix A: ");
        double[][] matrixA = initiateMatrix(m,p,max);
        System.out.println(toString(matrixA));

        System.out.println("Matrix B: ");
        double[][] matrixB = initiateMatrix(p,n,max);
        System.out.println(toString(matrixB));


        System.out.println("Result matrix from built-in EJML library:");

        //#1 Using Matrix Library:
        SimpleMatrix firstMatrix = new SimpleMatrix(matrixA);
        SimpleMatrix secondMatrix = new SimpleMatrix(matrixB);
        startTime = System.nanoTime();
        SimpleMatrix productMatrix = firstMatrix.mult(secondMatrix);
        endTime = System.nanoTime();
        elapsedTimeBuiltIn =  (endTime - startTime) / (Math.pow(10,9));  // nanoseconds to seconds

        System.out.println(productMatrix.toString());




        System.out.println("Result matrix from programed method:");

        //#2 Manual work: Matrix Multiplication
        startTime = System.nanoTime();
        double[][] matrixC = multiply(matrixA,matrixB);
        endTime = System.nanoTime();
        elapsedTimeMethod =  (endTime - startTime) / (Math.pow(10,9));  // nanoseconds to seconds
        System.out.println(toString(matrixC));





        System.out.println("Elapsed time using Built-in: " + elapsedTimeBuiltIn + " seconds");
        System.out.println("Elapsed time using Method: "+ elapsedTimeMethod + " seconds");

    } //main






    //Supplemental Methods:

    //multiply two matrices
    public static double[][] multiply(double[][] A, double[][] B){
        int i = A.length;  //m
        int j = B.length;  //p
        int k = B[0].length; //n
        double[][] productMatrix = new double[i][k];

        for(int m = 0; m < i; m++) {
            for (int n = 0; n < k; n++) {
                int sum = 0;
                for (int p = 0; p < j; p++)
                    sum += A[m][p] * B[p][n];
                productMatrix[m][n] = sum;
            }
        }
        return productMatrix;
    }

    //initiate double[][] matrix
    public static double[][] initiateMatrix(int rows, int columns, int maxValue){
        double[][] matrix = new double[rows][columns];
        for(int i = 0; i < rows; i++){
            for(int j = 0; j < columns; j++)
                matrix[i][j] = Math.round((Math.random()*maxValue+1));
//                matrix[i][j] = 1;  //for consistent testing
        }

        return matrix;
    }

    //for printing matrix to console
    public static String toString(double[][] matrix){
        String s="";
        for(int i = 0; i < matrix.length; i++){
            for(int j = 0; j < matrix[0].length; j++){
                s += matrix[i][j] + " ";
            }
            s += "\n";
        }
        return s;
    }
}
