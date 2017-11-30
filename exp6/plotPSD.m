function plotPSD(signal, time, i, bitStream)
    h = spectrum.welch; 
    Hpsd=psd(h,signal,'Fs',40);
    hold on;
%     set figure 2 for PSD plot
    figure(2);
    subplot(6,1,i);
    plot(Hpsd);
end