function result_2 = matrixMultiplication(A,B,m,p,n)

% A,B are input matrices
% m,p,n are sizes of matrices A,B
% A(m x p) x B(p x n) = result_2(m x n)


for M = 1 : m
    for N = 1 : n
        sum = 0;
        for P = 1 : p
            sum = sum + A(M,P)*B(P,N);
        end
        result_2(M,N) = sum;
    end
end