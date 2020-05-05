%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Cyclic Redundancy Check is an error detecting algorithm used in communications
%        

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
close all;
clc;
G=input('Enter Generator polynomial array : '); % Generator polynomial e.g. 101101
len_G=length(G);                                % Length of generator polynomial
frame=input('Frame length : ');                 % Length of data frame to be transmitted
checks=input('No. of ChecksumsperFrame : ');    % No. of checksums per frame
data=randi([0 1],1,frame);                      % Data frame to be transmitted
msg_bits=frame/checks;                          % Dividing the frame into blocks
y=msg_bits;
z=1;
count_noerror=0;count_error=0;
for p=1:checks
    msg_in=data(z:y);                               % Inserting msg block into another variable
    len_msg=length(msg_in);
    for k=1:len_G-1
        msg_in(len_msg+k)=0;                        % Padding zeros at the tail of msg block
    end
    %%%%%%%    Transmitter   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    msg=msg_in;
    check=zeros;
    for k=1:len_msg
        if G(1)==msg(1)
            for m=1:len_G
                msg(m)=xor(msg(m),G(m));            % Modulo-2 division using XOR
            end
        end
        msg=circshift(msg,[0 -1]);
        %check(k,(1:length(msg)))=msg(1:end);
    end
    msg_in(len_msg+1:end)=msg(1:len_G-1);           % Padding Remainder at the tail of msg block
    msg_tx=msg_in;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    msg_tx(4)=~msg_tx(4);                           % Introducing Error
    msg=msg_tx;
    %%%%%%%%% Receiver    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for k=1:len_msg
        if G(1)==msg(1)
            for m=1:len_G
                msg(m)=xor(msg(m),G(m));            % Modulo-2 division using XOR
            end
        end
        msg=circshift(msg,[0 -1]);
        %check(k,(1:length(msg)))=msg(1:end);
    end
    rem=msg;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if rem==0
        count_noerror=count_noerror+1;              % count for Errors
    else
        count_error=count_error+1;
    end
    z=z+msg_bits;
    y=y+msg_bits;
end
fprintf('\nNo Errors ==> %d , Errors ==> %d\n\n',count_noerror,count_error);