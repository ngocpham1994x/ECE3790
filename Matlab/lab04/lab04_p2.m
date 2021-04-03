clc; clear all; close all;

%setup random size for matrices 
n = 100; %problem size: n x n square matrix

%fill A matrix with random values
imax = randi(10,1);  %random number from 1 to 10
A = randi(imax,n,n);
%generate 5-right-hand-size vectors
b1 = randi(imax,n,1);
b2 = randi(imax,n,1);
b3 = randi(imax,n,1);
b4 = randi(imax,n,1);
b5 = randi(imax,n,1);


%%%%%%%%%%%%%%%%%%%%%% LU DECOMPOSITION %%%%%%%%%%%%%%%%%%%%%%%%
tic;
[L,U] = LUDecomposition(A);
elapsed_LUDecomposition = toc;
LU = uint8(L*U);

%verify L & U
LUtest = eq(LU,A);  %verify LU = A, should be the same


%L is not same as L1, U is not same as U1, 
%due to matlab internal algorithms for dealing with factor denominator == 0
%and L * factor is practically = L (example: L.*2 for rounding to int values)
tic;
[L_matlab,U_matlab] = lu(A);
elapsed_LUDecomposition_matlab = toc;

LU_matlab = uint8(L_matlab*U_matlab);
Ltest = eq(L_matlab,L); %will  not be the same
Utest = eq(U_matlab,U); %will  not be the same   


%%%%%%%%%%%%%%%%%%%%%%%%% LU SOLVE %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%solving 5 vectors b
tic;
[d1,x1] = LUSolve(L,U,b1);
elapsed_LUSolve1 = toc;

tic;
[d2,x2] = LUSolve(L,U,b2);
elapsed_LUSolve2 = toc;

tic;
[d3,x3] = LUSolve(L,U,b3);
elapsed_LUSolve3 = toc;

tic;
[d4,x4] = LUSolve(L,U,b4);
elapsed_LUSolve4 = toc;

tic;
[d5,x5] = LUSolve(L,U,b5);
elapsed_LUSolve5 = toc;

%verify d & x with matlab functions
tic;
d1_matlab = L_matlab\b1;
x1_matlab = U_matlab\d1;
elapsed_LUSolve1_matlab = toc;

tic;
d2_matlab = L_matlab\b2;
x2_matlab = U_matlab\d2;
elapsed_LUSolve2_matlab = toc;

tic;
d3_matlab = L_matlab\b3;
x3_matlab = U_matlab\d3;
elapsed_LUSolve3_matlab = toc;

tic;
d4_matlab = L_matlab\b4;
x4_matlab = U_matlab\d4;
elapsed_LUSolve4_matlab = toc;

tic;
d5_matlab = L_matlab\b5;
x5_matlab = U_matlab\d5;
elapsed_LUSolve5_matlab = toc;
