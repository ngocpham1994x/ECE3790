clear all
close all
clc


load("data.mat");
figure;
subplot(2,1,1);
plot(n_matrix,matrix_java_builtin,n_matrix,matrix_java_method);
title('(Matrice - Java) Problem size vs Computational time')
xlabel('n')
ylabel('t (seconds)')
legend('Built-in method','Programmed method')

subplot(2,1,2);
plot(n_matrix,matrix_matlab_builtin,n_matrix,matrix_matlab_method);
title('(Matrice - Matlab) Problem size vs Computational time')
xlabel('n')
ylabel('t (seconds)')
legend('Built-in method','Programmed method')




figure;
subplot(2,1,1);
plot(n_merge,merge_java_builtin,n_merge,merge_java_method);
title('(Merge Sort - Java) Problem size vs Computational time')
xlabel('n')
ylabel('t (seconds)')
legend('Built-in method','Programmed method')

subplot(2,1,2);
plot(n_merge,merge_matlab_builtin,n_merge,merge_matlab_method);
title('(Merge Sort - Matlab) Problem size vs Computational time')
xlabel('n')
ylabel('t (seconds)')
legend('Built-in method','Programmed method')
