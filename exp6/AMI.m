function AMI( bitStream )
    bitStream(length(bitStream)+1)=0;
    
    ami=-1;
    modSignal = [];
    time = [];
    
    for n=1:(length(bitStream)-1)
        t=n-1:0.1:n;
        if bitStream(n) == 0
            if bitStream(n+1)==0  
                y=(t>n);
            else
                if ami==1
                    y=-(t==n);
                else
                    y=(t==n);
                end
            end
        else
            ami=ami*-1;
            if bitStream(n+1)==0
                if ami==1
                    y=(t<n);
                else
                    y=-(t<n);
                end
            else
                if ami==1
                    y=(t<n)-(t==n);
                else
                    y=-(t<n)+(t==n);
                end
            end
        end
        modSignal = [modSignal y];
        time = [time t];
    end
    plotSignal(modSignal, time, 4, bitStream);
    plotPSD(modSignal, time, 4, bitStream);
end