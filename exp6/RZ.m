function RZ( bitStream )
%     add one more bit to the end of the buffer to complete the last...
%       on the x-axis
    bitStream(length(bitStream)+1)=0;
%     global var to store the produced signal and time on theme    
    modSignal=[];
    time=[];
%     loop over the bitstream        
    for n=1:(length(bitStream)-1)
        %      set the time samples  
        t=n-1:0.001:n;
        %  check the next bit value    
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
    %     plot the signal and PSD
    plotSignal(modSignal, time, 3, bitStream,'RZ');
    plotPSD(modSignal, time, 3, bitStream);
end