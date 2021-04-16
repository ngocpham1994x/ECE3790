clc; clear all; close all;

xmin = -1;
xmax = 1;
ymin = -2;
ymax = 2;
Nx = 4;
Ny = 4;

x = linspace(xmin,xmax,Nx);
y = linspace(ymin,ymax,Ny);

[X Y] = meshgrid(x,y);

F = X.^2 + Y.^2;

% for i = 1:Nx
%     for j = 1:Ny
%         xval = x(i);
%         yval = y(j);
%         
%         f = xval^2 + yval^2;
%         
%         F(j,i) = f;
%         
%     end
% end


contour(X, Y, F);
