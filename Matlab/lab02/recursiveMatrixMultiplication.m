function C = recursiveMatrixMultiplication(A,B,nmin)
[m p] = size(A); %A row & column
[p n] = size(B); %B row & column

i = floor(m/2); 
k = floor(p/2);
j = floor(n/2);

A11 = A(1:i, 1:k);
A12 = A(1:i, k+1:p);
A21 = A(i+1:m, 1:k);
A22 = A(i+1:m, k+1:p);

B11 = B(1:k, 1:j);
B12 = B(1:k, j+1:n);
B21 = B(k+1:p, 1:j);
B22 = B(k+1:p, j+1:n);


%A(m,p) x B(p,n) = C(m,n)
C = zeros(m,n);
% C11 = C(1:i, 1:j);
% C12 = C(1:i, j+1:n);
% C21 = C(i+1:m, 1:j);
% C22 = C(i+1:m, j+1:n);


if(m<nmin)
    C = A*B;
else
    C(1:i, 1:j) = recursiveMatrixMultiplication(A11,B11,nmin) + recursiveMatrixMultiplication(A12,B21,nmin);
    C(1:i, j+1:n) = recursiveMatrixMultiplication(A11,B12,nmin) + recursiveMatrixMultiplication(A12,B22,nmin);
    C(i+1:m, 1:j) = recursiveMatrixMultiplication(A21,B11,nmin) + recursiveMatrixMultiplication(A22,B21,nmin);
    C(i+1:m, j+1:n) = recursiveMatrixMultiplication(A21,B12,nmin) + recursiveMatrixMultiplication(A22,B22,nmin);
end

end