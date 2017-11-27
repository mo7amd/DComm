function RZ( bitStream )
    bitStream(length(bitStream)+1)=0;
    
    modSignal=[];
    time=[];
    
    for n=1:(length(bitStream)-1)

        t=n-1:0.1:n;

        if bitStream(n) == 0
            if bitStream(n+1)==0  
                y=(t<n-0.5).*-1 + -1*(t==n);
            else
                y=(t<n-0.5).*-1 +(t==n);
            end
        else
            if bitStream(n+1)==0
                y=(t<n-0.5)+ -1*(t==n);
            else
                y=(t<n-0.5)+(t==n);
            end
        end
        modSignal = [modSignal y];
        time = [time t];
    end
    plotSignal(modSignal, time, 3, bitStream);
    plotPSD(modSignal, time, 3, bitStream);
end