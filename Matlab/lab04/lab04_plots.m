clc; clear all; close all;

%LU Decomposition theory: O(n^3)
%LU Solve/substitution: O(n^2)

load("data.mat");

figure(1);
f1 = plot(n,10^8.3 * LUDecomposition_method,n,10^10.75 * LUDecomposition_builtIn,n,LUDecomposition_theory);
f1(3).LineWidth = 2;
title('LU Decomposition');
xlabel('n'); ylabel('cost');
legend('Method, scale = 10^8^.^3','Built-in, scale = 10^1^0^.^7^5','Theory n^3');

figure(2);
f2 = plot(n,10^7.5 * LUSolve1_method,n,10^7.5 *LUSolve2_method,n, 10^7.5 *LUSolve3_method,n,10^7.5 * LUSolve4_method,n,10^7.5 *LUSolve5_method,n,LUSolve_theory);
f2(6).LineWidth = 2;
title('LU Solve/Substitution');
xlabel('n'); ylabel('cost');
legend('b1, scale = 10^7^.^5','b2, scale = 10^7^.^5','b3, scale = 10^7^.^5','b4, scale = 10^7^.^5','b5, scale = 10^7^.^5','Theory n^2');