function plotPSD(signal, time, i, bitStream)
    h = spectrum.welch; 
    Hpsd=psd(h,signal,'Fs',40);
    hold on;
    figure(2);
    subplot(6,1,i);
    plot(Hpsd);
end