function [genpol, gpb] = guitogenpol(x)

%cell array to double
genpol = cell2mat(x);
%% odstraneni nul na zacatku g(x), pokud nejake jsou
if any(genpol)
gpn = genpol;
gpn_l = length(genpol);
%pokud zacina nulou, vyhodit ji
if gpn(gpn_l) == 0
    i = gpn_l;
    %pokracovat dokud jsou nuly
    while (gpn(i) == 0)
%         i
    gp =  gpn(1:(i-1));
    i = i - 1;
    end
else
    %jinak je to ok
    gp = gpn;
end
%obraceni nejvyssi mocninou vpred
gpb = fliplr(gp);
% pokud neni genpol nastavit gpb prazdne
else
    gpb = '';
    gpn = '';
end
end