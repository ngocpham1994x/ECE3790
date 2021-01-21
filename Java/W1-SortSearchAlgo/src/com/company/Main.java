package com.company;

public class Main {

    public static void main(String[] args) {
        Matrix A = new Matrix(2,3);
        Matrix B = new Matrix(3,2);

        //testing zone:
//        System.out.p11rintln(A.getRow());
//        System.out.println(A.getColumn());
//        System.out.println(A.getSize());



        //print matrices
        System.out.println(A);
        System.out.println(B);

        //product of two matrices
        System.out.println(A.multiply(B));
    }
}
