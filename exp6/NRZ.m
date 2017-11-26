function NRZ( bitStream )
    bitStream(length(bitStream)+1)=0;
    modSignal=[];
    time=[];
    for n=1:(length(bitStream)-1)
    %   set time sample
    %   Ts = 0.001
        t=n-1:0.01:n;
        if bitStream(n) == 0
            if bitStream(n+1)==0  
                y=(t>n)+0;
            else
                y=(t==n)+0;
            end
            y(y==0)= -1;
        else
            if bitStream(n+1)==0
                y=(t<n)+0;
            else
                y=(t<n)+(t==n);
            end
            y(y == 0 ) = -1;
        end
        time=[time t];
        modSignal=[modSignal y];
    end
    disp(modSignal);
%     plotSignal(modSignal,time,1,bitStream);
    h = spectrum.welch; 
    Hpsd=psd(h,modSignal,'Fs',40);
    figure;
    hold on;
    handle1=plot(Hpsd);
    set(handle1,'LineWidth',2.5,'Color','r');
end