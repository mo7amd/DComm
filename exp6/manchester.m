function manchester( bitStream )
%     toggle the bit stream
    bitStream=~bitStream;
%     add one more bit to the end of the buffer to complete the last...
%       on the x-axis
    bitStream(length(bitStream)+1)=1;
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
    plotSignal(modSignal, time, 5, bitStream,'manchester');
    plotPSD(modSignal, time, 5, bitStream);
end