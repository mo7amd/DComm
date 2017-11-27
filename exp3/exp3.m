Bits=10000; %number of bits
SNR = 0:2:15; %snr in db

%-------- CONSTRUCTING dATA --------------
data = randint(1,Bits);%data array (OOK)
dataprk =(2.*data)-1; %data array (PRK)
%data array (FSK: for 0 send 1 ,for 1 send i)
datafsk = zeros(1,Bits);
for y = 1:Bits
    if data(y) == 0
        datafsk(y) = 1;
    else 
        datafsk(y) = j;
    end
end


%------- ADDING NOISE & DETECTION----------
for x = 1:length(SNR)
    %error counters
    error1 = 0;
    error2 = 0;
    error3 = 0;
    
    %data+noise
    data_channel_ook = awgn(data,SNR(x),'measured'); 
    data_channel_prk = awgn(dataprk,SNR(x),'measured');
    data_channel_fsk = awgn(datafsk,SNR(x),'measured');
    
    %detection
    for y = 1:Bits
        
        %detecting ook
        if data_channel_ook(y) < 0.5
            data_detect_ook(y) = 0;
        else
            data_detect_ook(y) = 1;
        end
    
        if data_detect_ook(y) ~= data(y);
           error1 = error1 + 1;
        end
        
        %detecting prk
        if data_channel_prk(y) < 0
            data_detect_prk(y) = 0;
        else
            data_detect_prk(y) = 1;
        end

        if data_detect_prk(y)~= data(y);
           error2 = error2 + 1;
        end
        
        %detecting fsk
        if (real(data_channel_fsk(y)) > imag(data_channel_fsk(y)))
            data_detect_fsk(y) = 0;
        else 
            data_detect_fsk(y) = 1;
        end
    
        if data_detect_fsk(y)~= data(y);
           error3 = error3 + 1;
        end
    end
    
    %calculating BER
    BE_Rate1 = error1/Bits;
    BER1(x) = BE_Rate1;

    BE_Rate2 = error2/Bits;
    BER2(x) = BE_Rate2;
    
    BE_Rate3 = error3/Bits;
    BER3(x) = BE_Rate3;   
end

%------- PLOTING -----------------------------
figure
semilogy(SNR,BER1);
grid on;
hold on;
semilogy(SNR,BER2,'r');
hold on;
semilogy(SNR,BER3,'g');
title(' BER vs SNR for OOK,FSK,PRK modulation');
legend('OOK','PRK','FSK');

figure
subplot(3,1,1)
semilogy(SNR,BER1);
title('ook');
subplot(3,1,2)
semilogy(SNR,BER2);
title('psk');
subplot(3,1,3)
semilogy(SNR,BER3);
title('fsk');
