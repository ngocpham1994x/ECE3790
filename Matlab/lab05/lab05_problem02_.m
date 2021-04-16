clc; clear all; close all;
%Reference: https://www.mathworks.com/matlabcentral/fileexchange/25919-golden-section-method-algorithm

lowerBound = 0;
upperBound = 360;
tolerance = 0.000001;
maxIteration = 100;


[minimum, iters, error] = goldenSearch(@spaceshipSimulation,lowerBound,upperBound,tolerance,maxIteration);

% In spaceshipSimulation.m, set plot_on = 0 for stopping plots to fast
% process


function [minimum, iters, error] = goldenSearch(f,lowerBound,upperBound,tolerance,maxIteration)
figure(1); hold on;

R = (sqrt(5)-1)/2;
d = R*(upperBound-lowerBound);

x1=upperBound-d;	% computing initial guesses of x values
x2=lowerBound+d;

f_x1=f(x1);         % computing values in x points
f_x2=f(x2);

plot(x1,f_x1,'rx'); % plotting x
plot(x2,f_x2,'rx');

iters = 0;
error = abs(upperBound-lowerBound);
errorTable = zeros(maxIteration);

while ( (error > tolerance) && (iters < maxIteration) )
    iters = iters + 1;
    if(f_x1<f_x2)
        upperBound=x2;
        x2=x1;
        x1=lowerBound+(1-R)*(upperBound-lowerBound);
        
        f_x1=f(x1);
        plot(x1,f_x1,'rx');
        
        error = abs(upperBound-lowerBound);
        errorTable(iters) = error;
    else
        lowerBound=x1;
        x1=x2;
        x2=lowerBound+R*(upperBound-lowerBound);
        
        f_x2=f(x2);
        plot(x2,f_x2,'rx');
        
        error = abs(upperBound-lowerBound);
        errorTable(iters) = error;        
    end

end

% chooses minimum point
if(f_x1<f_x2)
    minimum = f_x1;
    sprintf('x_min=%f', x1);
    sprintf('f(x_min)=%f ', f_x1);
    plot(x1,f_x1,'ro');
else
    minimum = f_x2;
    sprintf('x_min=%f', x2);
    sprintf('f(x_min)=%f ', f_x2);
    plot(x2,f_x2,'ro');
end

title("Minimum value Convergence");
xlabel("angle"); ylabel("minimum distance");
hold off;

%plotting error level
figure(2);
plot(1:maxIteration,errorTable);
title("Error level");
xlabel("Iteration"); ylabel("error");

end
