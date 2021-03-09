function sorted = mergeSort(array)

arr_length = length(array);

if arr_length == 1
    sorted = array; %Base case: do nothing
else
    mid = int32(arr_length/2);
    left_half = mergeSort(array(1 : mid));
    right_half = mergeSort(array(mid+1 : arr_length));
    sorted = merge(left_half,right_half);
end

