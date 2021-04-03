function [L,U] = LUDecomposition(A)

[row,column] = size(A);

%guarantee won't enter this check, because of initial setup in main loop
%this check here is redundant, but here is for understanding
if(row ~= column)  
    disp('Error: Matrix must be square');
    return;
end

L = eye(row);
U = A;

for rowNum = 1:(row-1) 
    
%checking if the factor denominator == 0
    if U(rowNum,rowNum) == 0 %the diagonal values of matrix, for calculating factor, also == factor's denominator
        disp('Error: LU factor denominator = 0. No further calculations.');
        return;
    else
%find U, then L   
        for i = (rowNum+1):row   %access the row below
            factor = U(i,rowNum)/U(rowNum,rowNum);
            L(i,rowNum) = factor;
            for columnNum = 1:column
                U(i,columnNum) = U(i,columnNum) - U(rowNum,columnNum)*factor;
            end
        end
        
    end
end
    
end