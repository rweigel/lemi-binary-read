% An attempt to read LEMI binary in MATLAB.
% Only got as far as reading first time stamp. Then Pierre found a way
% of batch converting using the Windows LEMI software.

% Test of LEMI-417M_Bin_out.pdf conversion notes for BX
% hex2dec('141312') => 1315602
% hex2dec('7270ef') => 7500015
% hex2dec('ed1db7') => 15539639 (but LEMI-417M_Bin_out.pdf says -1237577)

% A file that results from the conversion of L417_001.B82 to text is
% 20120905115300.t82, which has a first line of
% 2012 09 05 11 53 00 10963.50   -10.39 -23785.05 17.00 12.64 -34.67 373.31  3.91  3.44
fid = fopen('L417_001.B82','rb','b');
bytes1_5 = fread(fid,5,'uint8=>char');
bytes1_5
%    '4'
%    '1'
%    '7'
%    'V'
%    '' % Should be 0x41 or 0x50 according to LEMI-417M_Bin_out.pdf

% Time year, monty, day, hour, minute, second should be bytes 8-13
% according to LEMI-417M_Bin_out.pdf. Here it seems to be in bytes 6-11.
bytes6_11 = fread(fid,6,'*uint8');
dec2hex(bytes6_11)
%  6×2 char array
%
%    '12' (last two digits of year)
%    '09' (month)
%    '05' (day)
%    '11' (hour)
%    '53' (minute)
%    '00' (second)

bytes12_24 = fread(fid,11,'*ubit8');
dec2hex(bytes12_24)
% BX = 10963.50 => 1096350 is BX*100. So from dec2hex(1096350) = '10BA9E',
% we expect to find 10, BA, and 9E somewhere in bytes12_24
fclose(fid);

if 0
    b = fread(fid,24,'*ubit8')
    dec2hex(b)
    b = reshape(b,3,8)'
    d = fliplr(b)
    c = dec2hex(d)
    sprintf('%02X',d	)
    fclose(fid);
end