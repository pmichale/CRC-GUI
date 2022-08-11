function string = cell2gui(cellarray,format)
% pocet bytu
pocet = size(cellarray,2);
% prvni a mozna posledni string
string = strcat(sprintf(format,cellarray{1}));
% pokud ne posledni tak cyklus
if pocet > 1
    for i = 2:pocet
% udelam z double cell arraye string ktery oddeli kazdy radek \n
        string = sprintf(strcat(string,'\n',sprintf(format,cellarray{i}))); %newline
    end 
end

end