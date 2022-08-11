function [mx_result, mx_remainder] = codeCRC(gpb, msg_bin)
%%Usage example: pouzivej pres GUI \_(-_-)_/
%%
% 101101110
% s genpol [1101]
% dava
% 101101110011
%%
gp = gpb;
gp_l = length(gp);

msg_s = size(msg_bin);
msg_bytes = msg_s(2);

%prealokace
mx_result = msg_bin;
mx_remainder = msg_bin;

% main for cyklus cele funkce
for currentchar = 1:msg_bytes
%% priprava m(x)
msg_cur = msg_bin{currentchar};
mx = [0 0];
mx_l = length(msg_cur);
%str2double
for y = 1:mx_l
    mx(y) = str2double(msg_cur(y));
end
%append zeros
mx_a = mx;
for t = 1:(gp_l-1)
    mx_a(mx_l+t) = 0;
end
%% CRC xor
%pozice kde se bude xorovat
pos = 1;
%cast zpravy o delce G(x)
% mx_part = mx_a(1:gp_l);
mx_a_l = length(mx_a);
%break pro hlavni while CRC xoru
opustit = 0;
%dokud je odkud brat casti o delce G(x)
while pos <= (mx_a_l-gp_l+1)
if (pos == (mx_a_l-gp_l+1)) == 0
%najdeme prvni jednicku
    if mx_a(pos) == 0
        while mx_a(pos) == 0
            pos = pos + 1;
            if pos == (mx_a_l-gp_l+1) && mx_a(pos) == 0
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

part = pos:(gp_l+pos-1);
mx_part = mx_a(part);
mx_a(pos:(pos+gp_l-1)) = xor(mx_part,gp);
pos = pos + 1;
if pos == (mx_a_l-gp_l+1) && mx_a(pos) == 1
    mx_part = mx_a(pos:(gp_l+pos-1));
    mx_a(pos:(pos+gp_l-1)) = xor(mx_part,gp);
    break
end
end
%% append checksum
mx_crc = mx;
for t = mx_l+1:(mx_l+gp_l-1)
    mx_crc(t) = mx_a(t);
end
mx_rem = mx_a(mx_l+1:mx_a_l);
%% vlozeni do cell arraye
mx_remainder{currentchar} = mx_rem;
mx_result{currentchar} = mx_crc;
end % konec main for cyklu
end