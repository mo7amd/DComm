function [modSignal] = manchester( bitStream )
    
    bitStream=~bitStream;
    bitStream(length(bitStream)+1)=1;
    modSignal = [];
    time = [];
    
    for n=1:(length(bitStream)-1)
        t=n-1:0.001:n;
        if bitStream(n) == 0
            if bitStream(n+1)==0  
                y=-(t<n)+2*(t<n-0.5)+1*(t==n);
            else
                y=-(t<n)+2*(t<n-0.5)-1*(t==n);
            end
        else
            if bitStream(n+1)==0
                y=(t<n)-2*(t<n-0.5)+1*(t==n);
            else
                y=(t<n)-2*(t<n-0.5)-1*(t==n);
            end
        end
        modSignal = [modSignal y];
        time = [time t];
    end
%     plotSignal(modSignal,time,5,bitStream);
    h = spectrum.welch; 
    Hpsd=psd(h,modSignal,'Fs',40);
    figure;
    hold on;
    handle1=plot(Hpsd);
    set(handle1,'LineWidth',2.5,'Color','r');
end