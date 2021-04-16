close all
clear all
clc

% https://www.kaggle.com/andonians/random-linear-regression
load('dataC.mat');

%construct the over-determined system of equations
A = [x_data.^0 x_data];
b = y_data;

%solve the over-determined system
x = (A'*A)\(A'*b); %these are the coefficients for the line
a0 = x(1);
a1 = x(2);

%produce points to plot the regression line
xplot = linspace(min(x_data), max(x_data),length(x_data)); %it's a line, only need 2 points
yplot = a0 + a1*xplot; %equation for the line

%determine R^2
average_y_data = mean(y_data);
St = sum((y_data - average_y_data).^2);
Sr = sum((y_data - (x(1) + x(2)*x_data)).^2);
r2 = (St - Sr)./St;

%corrcoef(marks, (x(1) + x(2)*hours)) %another way to calculate r (not r2)
%built-in using Matlab


figure;
scatter(x_data, y_data)
hold on
plot(xplot,yplot,'r');
title('Over-determined Linear Least-squared Regression','y data vs x data')
xlabel('x data')
ylabel('y data')
legend('data', ['regression fit with r-sqr = ' num2str(r2*100) '%'])


