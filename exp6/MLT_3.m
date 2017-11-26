function [modSignal] = MLT_3( bitStream )
    
    bitStream(length(bitStream)+1)=0;
    pulse=5;
    current_level = 0;
    last_level = -pulse;
    
    for bit=1:length(bitStream)
       t=bit-1:0.001:bit;
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
        % draw pulse and label
        plot(t, y, 'LineWidth', 2.5);
        text(bit-0.5, pulse+1, num2str(bitStream(bit)),'FontWeight', 'bold')
        hold on;
    end
    
    % draw grid
    grid on;
    axis([0 length(bitStream) -pulse*2 pulse*2]);
    set(gca,'YTick', [-pulse 0 pulse])
    set(gca,'XTick', 1:length(bitStream))
    set(gca,'XTickLabel', '')
end