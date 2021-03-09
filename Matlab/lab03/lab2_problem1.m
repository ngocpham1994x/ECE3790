clc; clear all; close all;

%create nvec array of different problem sizes "n"
arr_length = 2000;
nvec = zeros(arr_length,1);

for n=1:arr_length
    nvec(n)=n;
end


%determine the costs of evaluating a divide-and-conquer algorithms 
%for different input sizes without actually running the algorithm.

%Merge sort - numerical
costs_func1 = zeros(arr_length,1);
for n=1:arr_length
    costs_func1(n) = evaluateRecurrence(@T1, nvec(n)); % calls "evaluateRecurrence" with custom function defined below
end

%Merge sort - analytical 
y1 = zeros(arr_length,1);
for n=1:arr_length
    y1(n) = n*log(n)*1.5; 
end


%Tower of Hanoi - numerical
costs_func2 = zeros(arr_length,1);
for n=1:arr_length
    costs_func2(n) = evaluateRecurrence(@T2, nvec(n)); % calls "evaluateRecurrence" with custom function defined below
end

%Tower of Hanoi - analytical
y2 = zeros(arr_length,1);
for n=1:arr_length
    y2(n) = (2^n)*1.2; 
end

%a given function - numerical
costs_func3 = zeros(arr_length,1);
for n=1:arr_length
    costs_func3(n) = evaluateRecurrence(@T3, nvec(n)); % calls "evaluateRecurrence" with custom function defined below
end

%a given function - analytical
y3 = zeros(arr_length,1);
for n=1:arr_length
    y3(n) = (n^1.46497)*1.2; 
end

%factorial - numerical
costs_func4 = zeros(arr_length,1);
for n=1:arr_length
    costs_func4(n) = evaluateRecurrence(@T4, nvec(n)); % calls "evaluateRecurrence" with custom function defined below
end


%factorial - analytical
y4 = zeros(arr_length,1);
for n=1:arr_length
    y4(n) = factorial(n)*1.2; 
end

%%%%%%%%%%% PLOTTING NUMERICAL & ANALYTICAL SOLUTIONS %%%%%%%%%%%%%%%
figure;
plot(nvec,costs_func1,nvec, y1); 
title('T1(n) = 1 + 2T(n/2) + n (Merge Sort)'); xlabel('n (problem size)'); ylabel('cost');
legend('numerical solution','analytical solution: theta(nlogn),c = 1.5');

figure;
plot(nvec,costs_func2,nvec,y2); 
title('T2(n) = 2T(n − 1) + 1 (Tower of Hanoi)'); xlabel('n (problem size)'); ylabel('cost');  
legend('numerical solution','analytical solution: O(2^n),c = 1.2');

figure;
plot(nvec,costs_func3,nvec,y3); 
title('T3(n) = 5T(n/3) + n'); xlabel('n (problem size)'); ylabel('cost');  
legend('numerical solution','analytical solution: theta(n^1.46497),c = 1.2');

figure;
plot(nvec,costs_func4,nvec,y4); 
title('T4(n) = n*T(n-1) (Factorial)'); xlabel('n (problem size)'); ylabel('cost');  
legend('numerical solution','analytical solution: O(n!),c = 1.2');


%%%%%%%%%%%% evaluateRecurrence() FUNCTION %%%%%%%%%%%%%%%%%%%
%evaluateRecurrence(myFunction, nvec)
function valOut = evaluateRecurrence(funcIn, numIn)
% funcIn is a function passed to this function! you call as you would the passed function:
valOut = funcIn(numIn);
end


%%%%%%%%%%%% DIVIDE & CONQUER FUNCTIONS (RECURSION) %%%%%%%%%%%%%%%%%%%

%T1(n) = 1 + 2T(n/2) + n (Merge Sort)
function valOut = T1(n)  
if(n < 2)
    valOut = 0;
else
    valOut = 1 + 2*T1(n/2) + n;
end
end


%T2(n) = 2T(n − 1) + 1 (Tower of Hanoi)
function valOut = T2(n)
if(n < 1)
    valOut = 0;
else
    valOut = 2*T2(n-1) + 1;
end
end


%T3(n) = 5T(n/3) + n
function valOut = T3(n) 
if(n < 3)
    valOut = 0;
else
    valOut = 5*T3(n/3) + n;
end
end

%Factorial: x(x-1)(x-2)(x-3)...1.0
%T4(n) = n*T(n-1)
function valOut = T4(n) 
if(n < 1)
    valOut = 1;  % 0! = 1
else
    valOut = n*T4(n-1);
end
end