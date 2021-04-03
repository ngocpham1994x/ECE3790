function [d,x] = LUSolve(L,U,b)

[row,column] = size(L);

%Ld = b, find d, using Forward substidution
d = zeros(row,1);

for k = 1:row
    for j = 1:k-1
        d(k) = d(k) + L(k,j)*d(j);
    end
    d(k) = (b(k) - d(k))/L(k,k);
end

%Ux = d, find x, using Back substitution
x = zeros(row,1);

for k = row:-1:1
    for j = k+1:row
        x(k) = x(k) + U(k,j)*x(j);
    end
    x(k) = (d(k) - x(k))/U(k,k);
end

end