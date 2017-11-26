function [modSignal,time] = NRZI( bitStream )
    time = [];
    modSignal = [];
    Hpsd=[];
    % pulse height
    pulse = 1;

    % assume that current pulse level is a "low" pulse; this is
    % the pulse level for the bit before given bitstream
    current_level = -pulse;

    for bit = 1:length(bitStream)
        % set bit time
        t=bit-1:0.001:bit;

        if bitStream(bit) == 0
            % binary 0 - keep previous level
            y = (t<bit) * current_level;
        else
            % binary 1 - change pulse level
            current_level = -current_level;
            y = (t<bit) * current_level;
        end

        % assign last pulse point by inspecting the following bit
        try
            if bitStream(bit+1) == 1
                y(end) = -current_level;
            else
                y(end) = current_level;
            end
        catch 
            % bitstream end, assume next bit is 1
            y(end) = -current_level;
        end
        time= [time t];
        modSignal= [modSignal y];
        h = spectrum.welch;
        Hpsd=psd(h,y,'fs',20)
    end
    plotSignal(modSignal,time,2,bitStream);
    figure;
    hold on;
    handle1=plot(Hpsd);
    set(handle1,'LineWidth',2.5,'Color','r')
end