clc; clear all; close all;

%setup random size for matrices 
problem_size = 100; %problem size, for consistent testing
m=problem_size; %random number from 1 to 5
p=problem_size;
n=problem_size;

%fill A & B matrices with random values
imax = randi(10,1);  %random number from 1 to 10
A = randi(imax,m,p);
B = randi(imax,p,n);

nmin = 20;

tic;
C_recursive = recursiveMatrixMultiplication(A,B,nmin);
elapsed_recursive = toc; %seconds

%%%%%%%%%%%%%%%%%%%%% VERIFICATIONS %%%%%%%%%%%%%%%%%%%%%%%

%verification 1: built-in
C_builtIn = A*B;


%verification 2: Manual, non-recursive calculation method
C_nonRecursive = zeros(m,n);
tic
C_nonRecursive = matrixMultiplication(A,B,m,p,n);
elapsed_nonRecursive = toc; %seconds 


%verification 3: Strassen's algorithm
C_Strassen = zeros(m,n);
tic
% C_Strassen = strassen(A,B,nmin);
elapsed_Strassen = toc;

%%%%%%%%%%%%%%%%%%%%% PLOTTING %%%%%%%%%%%%%%%%%%%%%%%

%%% plot 1 %%%

%create nvec array of different problem sizes "n"
arr_length = 1000;
nvec = zeros(arr_length,1);

for n=1:arr_length
    nvec(n)= n;
end

%numerical
costs_func5 = zeros(arr_length,1);
for n=1:arr_length
    costs_func5(n) = evaluateRecurrence(@T5, nvec(n)); % calls "evaluateRecurrence" with custom function defined below
end


%analytical
y5 = zeros(arr_length,1);
for n=1:arr_length
    y5(n) = n^3 * 1.1; 
end


figure;
plot(nvec,costs_func5,nvec, y5); 
title('Plot 1','T(n) = 8T(n/2) + n^2 (Recursive Matrix Multiplication)'); xlabel('n (problem size)'); ylabel('Cost');
legend('numerical solution T(n)','analytical solution: O(n^3),c = 1.1');


%%% plot 2 %%%

n0 = [100 200 300 400 500 600 700 800 900 1000];
Tn = [1100000 5080000 22950000 41004300 63750000 183960000 250390000 327040000 413910000 511000000];
On3 = [1100000 8668660 29700000 70400000 137500000 237600000 377300000 563200000 801900000 1100000000];
time_recursive = [0.1111 0.5613 3.8447 4.1489 24.8509 30.4019 32.4677 32.7711 40.263 198.9449];

figure;
plot(n0,Tn/(8.5^7),n0, On3/(9.5^7),n0,time_recursive); 
title('Plot 2','T(n), O(n^3) & measured time (block size = 8)'); xlabel('n (problem size)'); ylabel('Time Cost');
legend('numerical solution T(n)/8.5^7','analytical solution: O(n^3)/9.5^7','measured time');

%%% plot 3 %%%

time_recursive = [0.1111 0.5613 3.8447 4.1489 24.8509 30.4019 32.4677 32.7711 40.263 198.9449];
time_nonRecursive = [0.0321 0.0542 0.1204 0.2576 0.4702 1.0836 2.1228 3.1611 4.7309 6.6071];
figure;
plot(n0,time_recursive,n0, time_nonRecursive); 
title('Plot 3','Recursve vs Iterative Matrix Multiplication'); xlabel('n (problem size)'); ylabel('Seconds');
legend('Recursive, block size = 8','Iterative');

%%% plot 4 %%%

blockSize = [2 4 6 8 10 12 14 16 18 20];
timePerformance = [16.8367 0.9809 0.5918 0.0806 0.0777 0.0771 0.0164 0.0162 0.0148 0.0155];
figure;
plot(blockSize,timePerformance); 
title('Plot 4','Minimum Block Size vs Time Performance of  Recursive MMP, Problem size n = 100'); xlabel('Minimum Block Size'); ylabel('Seconds');
legend('Time Performance');


%%%%%%%%%%%%%%%%%%%%%% FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%

function valOut = evaluateRecurrence(funcIn, numIn)
% funcIn is a function passed to this function! you call as you would the passed function:
valOut = funcIn(numIn);
end


%'T(n) = 8T(n/2) + n^2 (Recursive Matrix Multiplication)
function valOut = T5(n)  
if(n < 2)
    valOut = 0;
else
    valOut = 8*T5(n/2) + n^2;
end
end
