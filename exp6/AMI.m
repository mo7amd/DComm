function AMI( bitStream )
    %     add one more bit to the end of the buffer to complete the last...
    %       on the x-axis
    bitStream(length(bitStream)+1)=0;
%     ami flag
    ami=-1;
%     global var to store the produced signal and time on theme
    modSignal = [];
    time = [];
%     loop over the bitstream    
    for n=1:(length(bitStream)-1)
        %      set the time samples  
        t=n-1:0.001:n;
        %        check the value of current bit
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
    %     plot the signal and PSD
    plotSignal(modSignal, time, 4, bitStream,'AMI');
    plotPSD(modSignal, time, 4, bitStream);
end