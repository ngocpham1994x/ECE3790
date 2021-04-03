function C = strassen(A,B,nmin)
n = length(A);
if n <= nmin
   C = A*B;
else
    k = floor(n/2); i = 1:k; j = k+1:n;
   P1 = strassen( A(i,i)+A(j,j), B(i,i)+B(j,j), nmin);
   P2 = strassen( A(j,i)+A(j,j), B(i,i), nmin);
   P3 = strassen( A(i,i), B(i,j)-B(j,j), nmin);
   P4 = strassen( A(j,j), B(j,i)-B(i,i), nmin);
   P5 = strassen( A(i,i)+A(i,j), B(j,j), nmin);
   P6 = strassen( A(j,i)-A(i,i), B(i,i)+B(i,j), nmin);
   P7 = strassen( A(i,j)-A(j,j), B(j,i)+B(j,j), nmin);
   C = [ P1+P4-P5+P7  P3+P5;  P2+P4  P1+P3-P2+P6 ];
end

end