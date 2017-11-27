function NRZ( bitStream )
    
    bitStream(length(bitStream)+1)=0;
    
    modSignal=[];
    time=[];
    for n=1:(length(bitStream)-1)
    %   set time sample
    %   Ts = 0.001
        t=n-1:0.1:n;
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
    plotSignal(modSignal, time, 1, bitStream);
    plotPSD(modSignal, time, 1, bitStream);
end