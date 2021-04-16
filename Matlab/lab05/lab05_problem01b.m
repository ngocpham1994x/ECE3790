close all; clear all; clc
% https://www.kaggle.com/abhisheikreddy646/house-prediction-for-zipcode?select=80111.csv

load('dataB.mat');
 
[x, r2] = linearregression(bedrooms,bathrooms,price);

a0 = x(1);
a1 = x(2);
a2 = x(3);
fh = @(x,y) a0 + a1*x + a2*y;

figure;

fmesh(fh, [min(bedrooms), max(bedrooms), min(bathrooms), max(bathrooms)]); %new matlab way
hold on
scatter3(bedrooms, bathrooms, price)
title('House price vs Bedrooms vs Bathrooms', 'FontSize', 18)
xlabel('Bedrooms', 'FontSize', 14)
ylabel('Bathrooms', 'FontSize', 14)
zlabel('Price', 'FontSize', 14)
legend({'data', ['regression fit with r-sqr = ' num2str(r2*100) '%']}, 'FontSize', 14)

function [x, r2] = linearregression(bedrooms,bathrooms,price)
    n = length(price);
    assert(n == length(bedrooms));
    assert(n == length(bathrooms));

    %construct the over-determined system of equations
    A = [ones(n,1) bedrooms bathrooms];
    b = price;

    %solve the over-determined system
    x = (A'*A)\(A'*b); %these are the coefficients for the line - better is A\b directly

    %determine R^2
    average_price = mean(price);
    St = sum((price-average_price).^2);
    Sr = sum((price-(x(1) + x(2)*bedrooms + x(3)*bathrooms)).^2);
    r2 = (St - Sr)./St;
end