Bits=100; %number of bits
SNR = 0:2:30; %snr in db
data = randint(1,Bits);%data array
data_detect = zeros(1,Bits);
BER = zeros(1,length(SNR));
BER_th = zeros(1,length(SNR));


for x=1:length(SNR)
    error = 0;
    data_channel = awgn(data,SNR(x),'measured'); % data+noise
    
    for y = 1:Bits
        
        if data_channel(y) < 0.5
            data_detect(y) = 0;
        else
            data_detect(y) = 1;
        end
    
        if data_detect(y)~= data(y);
           error = error + 1;
        end
    end

    BE_Rate = error/Bits;
    BER(x) = BE_Rate;
    BER_th(x) = (1/2)*erfc(sqrt(SNR(x)));
    
end

subplot(2,1,1)
semilogy(SNR,BER);
subplot(2,1,2)
semilogy(SNR,BER_th,'r');
 
