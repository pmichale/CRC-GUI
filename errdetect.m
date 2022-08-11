function [chyba, chybastr] = errdetect(syndrom,actual_length,expected_length)

elv = cell2mat(expected_length);
alv = cell2mat(actual_length);
chv = elv~=alv;
% pocet bytu
pocet = size(syndrom,2);

if any(chv)
    chyba = zeros(1, length(alv));
    c = 1;
    for i = 1:pocet
        if any(chv(i))
            chyba(c) = i;
            c = c+1;
        end
    end
end
%%

%prealokace
chyba = zeros(1, pocet);
c = 1;
for i = 1:pocet
    if any(syndrom{i})
        chyba(c) = i;
        c = c+1;
    end
end
%%
if any(chyba)
    chyba = chyba(1:c-1);
    chybastr = strcat(sprintf('%i',chyba(1)));

    if length(chyba) > 1
        for i = 2:length(chyba)
            if i == length(chyba)
                chybastr = strcat(chybastr,' and',{' '},sprintf('%i',chyba(i)));
            else
                chybastr = strcat(chybastr,',',{' '},sprintf('%i',chyba(i)));
            end
        end
    end
else
    chyba = 0;
    chybastr = '';
end
end