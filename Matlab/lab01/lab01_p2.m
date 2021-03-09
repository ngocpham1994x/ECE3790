close all
clear all
clc

%setup random arrays
arr_length = 20;
array = randi(20,1,arr_length)

array2 = zeros(1,arr_length);


for i = 1:arr_length
    array2(i) = array(i);
end
array2


%#1: Using built-in to merge sort
tic
array = sort(array)
elapsedTime_BuiltIn = toc  %seconds 
array_successfully_sorted = issorted(array)

%#2: Manual sorting work
%sort in-place in matlab does not need temporary array. just assign result
%of method to the original input
tic
array2 = mergeSort(array2)
elapsedTime_Method = toc %seconds 
array2_successfully_sorted = issorted(array2)

