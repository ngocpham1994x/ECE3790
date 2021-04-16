close all
clear all
clc

marks = [45 53 58 60 60 61 63 65 65, 67, 68 68 69 70 72 72 73 74 74 74 74 75 75 75 76 79 79 ...
80, 82, 82, 83, 84 85, 86, 88, 89, 92, 95, 95, 98].'; 

hours = 0.5*[1 1 3 0.5 1 1 2 2 1 2 3 3 3 4 3 4 6 3 4 4 4 3 5 5 5 4 5 6 6 5 6 7 8 5 4 8 4 9 9 6].';

%construct the over-determined system of equations
A = [hours.^0 hours];
b = marks;

%solve the over-determined system
x = (A'*A)\(A'*b); %these are the coefficients for the line
a0 = x(1);
a1 = x(2);

%produce points to plot the regression line
xplot = linspace(min(hours), max(hours),2); %it's a line, only need 2 points
yplot = a0 + a1*xplot; %equation for the line

%determine R^2
average_mark = mean(marks);
St = sum((marks-average_mark).^2);
Sr = sum((marks-(x(1) + x(2)*hours)).^2);
r2 = (St - Sr)./St;

%corrcoef(marks, (x(1) + x(2)*hours)) %another way to calculate r (not r2)
%built-in using Matlab


figure;
scatter(hours, marks)
hold on
plot(xplot,yplot,'r');
title('Marks vs Study Hours')
xlabel('Average Hours Per Week')
ylabel('Midterm Mark')
legend('data', ['regression fit with r-sqr = ' num2str(r2*100) '%'])


