function MLT_3( bitStream )
    
    bitStream(length(bitStream)+1)=0;
    pulse=5;
    current_level = 0;
    last_level = -pulse;
    
    modSignal = [];
    time = [];
    for bit=1:length(bitStream)
       t=bit-1:0.1:bit;
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
       % assign last pulse point by inspecting the following bit
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
            % bitstream end, assume next bit is 1
            y(end) = -current_level;
        end
        modSignal = [modSignal y];
        time = [time t];
    end
    plotSignal(modSignal, time, 6, bitStream);
    plotPSD(modSignal, time, 6, bitStream);
end