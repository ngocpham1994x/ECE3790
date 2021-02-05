package com.company;

//Library EJML for Matrix multiplication:
//http://ejml.org/wiki/index.php?title=Main_Page
//https://www.baeldung.com/java-matrix-multiplication
import org.ejml.simple.SimpleMatrix;

import java.util.*;

public class Main {

    public static void main(String[] args) {
        //random integer value
        System.out.println("Matrix A (m-rows,p-columns) x Matrix B (p-rows, n-columns) = Matrix C (m-rows, n-columns). \nEnter size of matrices (m,p,n values): ");
        Scanner keyboard = new Scanner(System.in);

        int m = keyboard.nextInt(); //matrix A rows
        int p = keyboard.nextInt(); //matrix A columns = matrix B rows
        int n = keyboard.nextInt(); //matrix B columns

        long startTime, endTime, elapsedTime;

        System.out.println("Enter largest integer value in the matrix: ");
        int max = keyboard.nextInt();

        System.out.println("Matrix A: ");
        double[][] matrixA = initiateMatrix(m,p,max);
        System.out.println(toString(matrixA));

        System.out.println("Matrix B: ");
        double[][] matrixB = initiateMatrix(p,n,max);
        System.out.println(toString(matrixB));




        //#1 Labor work: Matrix Multiplication
        startTime = System.nanoTime();
        double[][] matrixC = multiply(matrixA,matrixB);
        endTime = System.nanoTime();
        elapsedTime = endTime - startTime;
        System.out.println(toString(matrixC));
        System.out.println("Elapsed time: "+ elapsedTime + " nanoseconds");





        //#2 Using Matrix Library:
        SimpleMatrix firstMatrix = new SimpleMatrix(matrixA);
        SimpleMatrix secondMatrix = new SimpleMatrix(matrixB);
        startTime = System.nanoTime();
        SimpleMatrix productMatrix = firstMatrix.mult(secondMatrix);
        endTime = System.nanoTime();
        elapsedTime = endTime - startTime;

        System.out.println(productMatrix.toString());
        System.out.println("Elapsed time: "+ elapsedTime + " nanoseconds");

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
