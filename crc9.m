% The program generates CRC code for any given input message stream &
% generator polynomial
%msg=[1 1 1 0 0 0 1 1 ]
msg=input('Input Message sequence :');
%poly=[1 1 0 0 1 1]
poly=input('Input Generator Polynomial :');
[M N]=size(poly);
mseg=[msg zeros(1,N-1)];
[q r]=deconv(mseg,poly);
r=abs(r);
for i=1:length(r)
    a=r(i);
    if ( mod(a,2)== 0 )
        r(i)=0;
    else
        r(i)=1;
    end
end

crc=r(length(msg)+1:end)
frame = bitor(mseg,r)
