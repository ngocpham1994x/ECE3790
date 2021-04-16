% Over-determined system of linear equation
% Regression, the least-square solution to over-determined system of linear equations 
% Matrix A = [1 x1;1 x2;1 x3;....;1 xN]
% Matrix x = [a0 a1]
% Matrix b = [y1; y2; y3;...; yN]
% Ax - b
% g(x) = (||Ax-b||)^2 
% find the minimum g(a0,a1) -> solving least-square solution of over-determined
% system of linear equations using Gradient Descent

% https://www.kaggle.com/andonians/random-linear-regression
clc; clear all; close all;
load("data.mat");

%==========================================================================
%  Initialize problem
%==========================================================================
%matrix A:
N = length(x_data);
A = [x_data.^0 x_data];

%matrix b:
% y_data = 44 + 11*x_data; % y = a0 + a1*x, for testing, commented out
b = y_data;

%matrix x, initialize:
x = [0;0];

%==========================================================================
% Gradient Descent technique: fixed alpha or analytical alpha
%==========================================================================
maxIteration = 1000;
alpha_fixed = 10*10^(-9);
% alpha_fixed = 1*10^(-10); % for y = 44 + 11*x

% [x, G] = gradientDescentFixedAlpha(A,x,b,alpha_fixed,maxIteration);
[x, alpha_analytical, G] = gradientDescentAnalyticalAlpha(A,x,b,maxIteration);
a0 = x(1);
a1 = x(2);


%==========================================================================
%  plotting contour
%==========================================================================
a0min = min(G(1,:)); a0max = max(G(1,:));
a1min = min(G(2,:)); a1max = max(G(2,:));

a0_array = linspace(a0min, a0max, maxIteration); 
a1_array = linspace(a1min, a1max, maxIteration);
[A0, A1] = meshgrid(a0_array,a1_array); 
% nested for-loop to calculate objective function
for i = 1: maxIteration
    for j = 1 : maxIteration
        a0_value = a0_array(i);
        a1_value = a1_array(j);
        objective_function = norm(A*[a0_value; a1_value] - b)^2;
        
        objective_function_grid(j,i) = objective_function;
        
    end
end

figure(1); hold on;
contour(A0, A1, objective_function_grid);
plot(a0,a1, 'rx', 'MarkerSize',20,'LineWidth',2); 
title('Gradient Descent of Norm(Ax-b)', 'where Ax=b Linear Systems of Equations, x = [a0;a1]');
xlabel('a0'); ylabel('a1'); hold off;

%==========================================================================
%  plotting G = a0, a1
%==========================================================================
figure(2);
plot(1:maxIteration,G(1,:),1:maxIteration,G(2,:));  % plot(1:maxIteration,G) works too
title('g(a_0,a_1)');
xlabel('Iterations'); ylabel('a_0, a_1 values');
legend('a_0','a_1');

%==========================================================================
%  plotting Regression line
%==========================================================================

%produce points to plot the regression line
xplot = linspace(min(x_data), max(x_data),2); %it's a line
yplot = a0 + a1*xplot; %equation for the line

%determine R^2
average_y_data = mean(y_data);
St = sum((y_data - average_y_data).^2);
Sr = sum((y_data - (x(1) + x(2)*x_data)).^2);
r2 = (St - Sr)./St;

figure(3);
scatter(x_data, y_data)
hold on
plot(xplot,yplot,'r');
title('Over-determined Linear Least-squared Regression','y data vs x data')
xlabel('x data')
ylabel('y data')
legend('data', ['regression fit with r-sqr = ' num2str(r2*100) '%'])
hold off


%==========================================================================
%  functions:
%  Gradient Descent for solving Over-determined Regression
%  Least-square of Over-determined System of Linear Equations
%==========================================================================
function [x, G] = gradientDescentFixedAlpha(A,x,b,alpha_fixed,maxIteration)
    
    iters = 0; 
    G = zeros(2,maxIteration); %for using contour()

    while (iters < maxIteration) 
        iters = iters + 1;
        r =  A*x-b;
        d = 2*A'*r;             %hard-coded objective function -> hard-coded direction d
    %     alpha = (r'*A*d)/((A*d)'*A*d);  
        x = x - alpha_fixed*d;  %descent as direction,  " - "
        G(:,iters)= x;
    end

end

function [x, alpha, G] = gradientDescentAnalyticalAlpha(A,x,b,maxIteration)

    iters = 0; 
    G = zeros(2,maxIteration); %for using contour()

    while (iters < maxIteration) 
        iters = iters + 1;
        r =  A*x-b;
        d = 2*A'*r;                     %hard-coded objective function -> hard-coded direction d
        alpha = (r'*A*d)/((A*d)'*A*d);  % analytical alpha
        x = x - alpha*d;                %descent as direction,  " - "
        G(:,iters)= x;
    end

end



