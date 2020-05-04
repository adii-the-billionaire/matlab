
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%calculating syndrome for received code

function syndrome= synd(receive,poly)
  
%calculating the dimensions of the polynomial
[M N]=size(poly);

%calculating the quotient and remainder of the received codeword
[q r]=deconv(receive,poly);
r=abs(r);
for i=1:length(r)
    a=r(i);
    if ( mod(a,2)== 0 )
        r(i)=0;
    else
        r(i)=1;
    end
end

%finding the binary syndrome 
syndrome=r;