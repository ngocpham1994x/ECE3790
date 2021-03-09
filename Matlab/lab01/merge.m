function sort_result = merge(left_half,right_half)

%sort_result is the temporary blank array for inputting sorted array as we
%go, its size depends on left_half size and right_half size.

left_half;
right_half;

left_half_length = length(left_half);
right_half_length = length(right_half);

sort_result_length = right_half_length + left_half_length;
sort_result = zeros(1,sort_result_length);

currIndex = 1;
currL = 1;
currR = 1;


for currIndex = 1:sort_result_length
    if (currL > left_half_length) %for when left_half index exceeds its size
        sort_result(currIndex) = right_half(currR);
        currR = currR + 1;        
    elseif (currR > right_half_length) || (left_half(currL) <= right_half(currR))   %for when right_half exceeds its size or left is smaller than right
        sort_result(currIndex) = left_half(currL);
        currL = currL + 1;
    else %for when (left_half(currL) >= right_half(currR))   
        sort_result(currIndex) = right_half(currR);
        currR = currR + 1;  
    end
end