function MLT_3( bitStream )
%     add one more bit to the end of the buffer to complete the last...
%       on the x-axis
    bitStream(length(bitStream)+1)=0;
    
%     set plus level fot the y-axis
    pulse=1;
    current_level = 0;
    last_level = -pulse;
%     global var to store the produced signal and time on theme
    modSignal = [];
    time = [];
%     loop over the bitstream
    for bit=1:length(bitStream)
%      set the time samples  
       t=bit-1:0.001:bit;
%        check the value of current bit
       if bitStream( bit ) == 0
           y = (t<bit) * current_level;
       else
           if current_level == 0
               current_level = -last_level;
               last_level = current_level;
               y = (t<bit) * current_level;
           else
               last_level = current_level;
               current_level = 0;
               y = (t<bit) * current_level;
           end
       end
       % assign last pulse point by inspecting the following bit.
        try
            if bitStream(bit+1) == 1
                if current_level == 0
                    y(end) = -last_level;
                else
                    y(end) = 0; 
                end
            else
                y(end) = current_level;
            end
        catch e
            y(end) = -current_level;
        end
        modSignal = [modSignal y];
        time = [time t];
    end
%     plot the signal and PSD
    plotSignal(modSignal, time, 6, bitStream,'MLT 3');
    plotPSD(modSignal, time, 6, bitStream);
end