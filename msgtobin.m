function msg_bin = msgtobin(msg)
%string na 8-bit unsigned integer array
msg_uint8 = uint8(msg);
%prevod na binary - char array
msg_bin_array = dec2bin(msg_uint8);
%zjisteni rozmeru
msg_size = size(msg_bin_array);
%pocet znaku
msg_chars = msg_size(1,1);
%delka znaku
msg_char_l = msg_size(1,2);
% prevedeni na radek
msg_bin_line = reshape(msg_bin_array.',1,[]);

%rozhazeni znaku do cell array
%prealokace cell arraye
msg_bin = cell(1, msg_chars);
% rozhazovani
for y = 1:msg_chars
    msg_bin{y} = msg_bin_line(1+((y-1)*msg_char_l):(y*msg_char_l));
end

end