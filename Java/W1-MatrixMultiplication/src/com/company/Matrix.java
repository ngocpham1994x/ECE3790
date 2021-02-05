package com.company;

import java.util.Scanner;

public class Matrix {
    private int row;
    private int column;
    private int[][] theMatrix;

    //Constructor 1: initiate a new matrix by random values
    public Matrix(int row, int column){
        this.row = row;
        this.column = column;
        this.theMatrix = new int[row][column];
        Scanner keyboard = new Scanner(System.in);
        System.out.println("Enter largest integer in the matrix: ");
        int max = keyboard.nextInt();

        for(int i = 0; i < row; i++)
            for(int j = 0; j < column; j++)
                theMatrix[i][j] =(int) (Math.random()*max+1);
    }

    //Constructor 2: initiate a new matrix by given array
    public Matrix(int[][] given){
        this.row = given.length;
        this.column=given[0].length;
        this.theMatrix = given;
        for(int i = 0; i < row; i++)
            for(int j = 0; j < column; j++)
                theMatrix[i][j] = given[i][j];
    }

    //get methods for future use
    public int getRow(){
        return this.row;
    }

    public int getColumn(){
        return this.column;
    }

    public String getSize(){
        return row + " x " + column;
    }


    //print the matrix onto console
    public String toString(){
        String s = "";
        for(int i = 0; i < row; i++){
            for(int j = 0; j < column; j++){
                s += theMatrix[i][j] + " ";
            }
            s += "\n";
        }
        return s;
    }

    //multiply two matrices
    public Matrix multiply(Matrix B){
        int[][] productMatrix = new int[this.row][B.column];
        for(int m = 0; m < this.row; m++) {
            for (int n = 0; n < B.column; n++) {
                int sum = 0;
                for (int p = 0; p < B.row; p++) {
                    sum += this.theMatrix[m][p] * B.theMatrix[p][n];
                }
                productMatrix[m][n] = sum;
            }
        }
        Matrix C = new Matrix(productMatrix);
        return C;
    }
}
