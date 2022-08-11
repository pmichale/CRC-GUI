function GP_str = genpoltostr(genpol)
%otocit nejvyssi mocninou vpred
GP = fliplr(genpol);
%delka
GP_l = length(genpol);
GPn_str = '';
for j = 1:GP_l
    if (GP(j) == 1)
        if isempty(GPn_str) == 1
            GPn_str = strcat('x^',num2str(33-j));
        else
            GPn_str = strcat(GPn_str,{' + '},'x^',num2str(33-j));
        end
    end
end
GPn_str = strcat(GPn_str, {' '});
if contains(GPn_str,'x^0') == 1 
    GPn_str = strrep(GPn_str,'x^0','1');
end
if contains(GPn_str,'x^1') == 1 
    GPn_str = strrep(GPn_str,'x^1 ','x ');
end
% GPn_str = strrep(GPn_str,'+',' + ');
GP_str = GPn_str;
end