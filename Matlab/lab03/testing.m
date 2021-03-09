% function main
% clc; clear all; close all;
% testCode(@sum, [1 2 3])       % calls "testCode" with builtin matlab function "sum"
% testCode(@doubleSum, [1 2 3]) % calls "testCode" with custom function defined below
% end
% function valOut = testCode(funcIn, numIn)
% % funcIn is a function passed to this function! you call as you would the passed function:
% valOut = funcIn(numIn);
% end
% function ds = doubleSum(numIn)
% ds = 2*sum(numIn);
% end

clc; clear all; close all;

% C=[1,0,0,0,0;0,1,0,0,0;2,-1,4,2,1;3,1,-1,7,5]
% 
% [m p] = size(C); %A row column
% 
% i = floor(m/2); 
% k = floor(p/2);
% % j = floor(n/2);
% 
% A11 = C(1:i, 1:k)
% A12 = C(1:i, k+1:p)
% A21 = C(i+1:m, 1:k)
% A22 = C(i+1:m, k+1:p)
% % B = C(j:n, )

n = [100 200 300 400 500 600 700 800 900 10000];
time_recursive = [0.1111 0.5613 3.8447 4.1489 24.8509 30.4019 32.4677 32.7711 40.263 198.9449];
time_nonRecursive = [0.0321 0.0542 0.1204 0.2576 0.4702 1.0836 2.1228 3.1611 4.7309 6.6071];
figure;
plot(n,time_recursive,n, time_nonRecursive); 
title('Plot 3','Recursve vs Non-recursive Matrix Multiplication.'); xlabel('n (problem size)'); ylabel('Time');
legend('Recursive','Non-Recursive');
