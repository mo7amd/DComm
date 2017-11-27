clear all;
close all;
%Nb is the number of bits to be transmitted
Nb=10000;
% Generate Nb bits randomly
b=rand(1,Nb)>0.5;
%Rb is the bit rate in bits/second
Rb=4;
%Since each waveform is represented by 10 samples so sampling
%frequency is 10 times the bit rate
fs=10*Rb;
NRZ_out=[];
RZ_out=[];
Manchester_out=[];
 
%Vp is the peak voltage +v of the waveform
Vp=5;
%Here we encode input bitstream as Bipolar NRZ-L waveform
for index=1:size(b,2)
 if b(index)==1
 NRZ_out=[NRZ_out [1 1 1 1 1 1 1 1 1 1]*Vp];
 elseif b(index)==0
 NRZ_out=[NRZ_out [1 1 1 1 1 1 1 1 1 1]*(-Vp)];
 end
end
disp(length(NRZ_out));
%Now we draw the PSD spectrum of Bipolar NRZ-L using Welch PSD
%estimation method
h = spectrum.welch;
Hpsd=psd(h,NRZ_out,'Fs',fs);
figure;
hold on;
handle1=plot(Hpsd)
set(handle1,'LineWidth',2.5,'Color','r')