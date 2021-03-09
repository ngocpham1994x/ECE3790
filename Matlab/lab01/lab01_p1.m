close all
clear all
clc

%setup random size for matrices 
% problem_size = 1000; %for consistent testing
m=5; %random number from 1 to 5
n=5;
p=5;
%setup random values for matrices
imax = randi(10,1);  %random number from 1 to 10
A = randi(imax,m,p)
B = randi(imax,p,n)


%#1: Using built-in to multiply matrices
tic
result_1 = A*B
elapsedTime_BuiltIn = toc %seconds


%#2: Manual calculation method
result_2 = zeros(m,n);
tic
result_2 = matrixMultiplication(A,B,m,p,n)
elapsedTime_Method = toc %seconds 
