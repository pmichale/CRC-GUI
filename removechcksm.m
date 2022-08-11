function mx_final = removechcksm(mx_result, gpb)

mx_final = mx_result;

gp_l = length(gpb);
mx_bytes = size(mx_result,2);

for i = 1:mx_bytes
    mx_l = size(mx_result{i},2);
    for y = 1:mx_l
        mx_final{i} = mx_result{i}(1:mx_l-(gp_l-1));
    end
end

end