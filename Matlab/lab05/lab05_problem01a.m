close all
clear all
clc

% y= result = 7x1 + 2x2

load('dataA.mat');

[x, r2] = linearregression(x1,x2,result);

a0 = x(1);
a1 = x(2);
a2 = x(3);

fh = @(x,y) a0 + a1*x + a2*y;

figure;

fmesh(fh, [min(x1), max(x1), min(x2), max(x2)]); 
hold on
scatter3(x1, x2, result)
title('y=7x_1+2x_2 vs x_1 vs x_2', 'FontSize', 18)
xlabel('x_1', 'FontSize', 14)
ylabel('x_2', 'FontSize', 14)
zlabel('result', 'FontSize', 14)
legend({'data', ['regression fit with r-sqr = ' num2str(r2*100) '%']}, 'FontSize', 14)



function [x, r2] = linearregression(x1,x2,result)

    n = length(result);
    assert(n == length(x1));
    assert(n == length(x2));

    %construct the over-determined system of equations
    A = [ones(n,1) x1 x2];
    b = result;

    %solve the over-determined system
    x = (A'*A)\(A'*b); %these are the coefficients for the line - better is A\b directly


    %determine R^2
    average_result = mean(result);
    St = sum((result-average_result).^2);
    Sr = sum((result-(x(1) + x(2)*x1 + x(3)*x2)).^2);
    r2 = (St - Sr)./St;


end
