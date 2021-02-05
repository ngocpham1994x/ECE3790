package com.company;

//import org.ejml.simple.SimpleMatrix;

import java.util.Scanner;

public class Main {

    public static void main(String[] args) {
        //random integer value
        System.out.println("Matrix A (m-rows,p-columns) x Matrix B (p-rows, n-columns) = Matrix C (m-rows, n-columns). \nPlease type in size of matrices (m,p,n values): ");
        Scanner keyboard = new Scanner(System.in);

        int m = keyboard.nextInt();
        int p = keyboard.nextInt();
        int n = keyboard.nextInt();
        long startTime, endTime, elapsedTime;

        System.out.println("Matrix A: ");
        Matrix A = new Matrix(m,p);
        System.out.println("Matrix B: ");
        Matrix B = new Matrix(p,n);

        //testing zone:
//        System.out.p11rintln(A.getRow());
//        System.out.println(A.getColumn());
//        System.out.println(A.getSize());



        //print matrices
        System.out.println();
        System.out.println(A);
        System.out.println(B);

        //product of two matrices
        System.out.println("Matrix Multiplication Result: ");
        startTime = System.nanoTime();
        System.out.println(A.multiply(B));
        endTime = System.nanoTime();
        elapsedTime = endTime - startTime;
        System.out.println("Elapsed time: "+elapsedTime+ " nanoseconds");


    }
}
