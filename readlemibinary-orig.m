fid = fopen('L417_001.B82','rb','b');
a = fread(fid,32,'uint8=>char')
b = fread(fid,24,'*ubit8')
dec2hex(b)
b = reshape(b,3,8)'
d = fliplr(b)
c = dec2hex(d)
sprintf('%02X',d	)
fclose(fid);