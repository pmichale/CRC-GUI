function [mx_decoded, expected_length] = decodeCRC(gpb, mx_result)
%%Usage example: pouzivej pres GUI \_(-_-)_/
%%
%gen poly
gp = gpb;
%delka gen poly
gp_l = length(gp);
% velikost dodane zpravy
msg_s = size(mx_result);
% pocety bytu zpravy
msg_bytes = msg_s(2);

%prealokace cell arraye v pameti
mx_decoded = mx_result;
expected_length = cell(1,msg_bytes);

% hlavni for cyklus cele funkce - probehne pro kazdy byte
for currentbyte = 1:msg_bytes
%% priprava m(x)
% pokud je to zmena z gui tak prevod z char na double
if isa(mx_result{currentbyte},'char')
for k = 1:msg_bytes
    msg_cur = mx_result{currentbyte};
    mx_a = [0 0];
    mx_l = size(msg_cur);
    %str2double
for y = 1:mx_l(2)
    mx_a(y) = str2double(msg_cur(y));
end
end
% end
else

%vyber konkretniho bytu z cell arraye 
mx_a = mx_result{currentbyte};
end
%% CRC xor
%pozice kde se bude xorovat
pos = 1;
%cast zpravy o delce G(x)
% mx_part = mx_a(1:gp_l);
%delka bytu
mx_a_l = length(mx_a);
%break promenna pro hlavni while CRC xoru
opustit = 0;
%dokud je odkud brat casti o delce G(x)
while pos <= (mx_a_l-gp_l+1)
% pokud je na prvni pozici nula
if (pos == (mx_a_l-gp_l+1)) == 0
%najdeme prvni jednicku
    if mx_a(pos) == 0
%       dokud je na pozici nula pokracujem
        while mx_a(pos) == 0
            pos = pos + 1;
%           pokud narazime na pozici kde je 0 ale uz by neslo xorovat
            if pos == (mx_a_l-gp_l+1) && mx_a(pos) == 0
%               tak opustime while
                opustit = 1;
                break
            end
        end
    end
else
    opustit = 1;
end

if opustit == 1
    break
end
%  vyber casti zpravy na xorovani
part = pos:(gp_l+pos-1);
mx_part = mx_a(part);
% xorovani
mx_a(pos:(pos+gp_l-1)) = xor(mx_part,gp);
% rovnou dalsi pozice protoze po xoru bude vzdy na prvni 0
pos = pos + 1;
% pokud jsem na posledni xorovatelny pozici a je tam jedna, tak dame
% posledni xor a pak opustime cyklus
if pos == (mx_a_l-gp_l+1) && mx_a(pos) == 1
    mx_part = mx_a(pos:(gp_l+pos-1));
    mx_a(pos:(pos+gp_l-1)) = xor(mx_part,gp);
    break
end
end
%% vlozeni vysledku do cell arraye
mx_decoded{currentbyte} = mx_a;
expected_length{currentbyte} = mx_a_l;
end % konec main for cyklu
end