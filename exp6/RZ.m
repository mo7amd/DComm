function [modSignal] = RZ( bitStream )
    bitStream(length(bitStream)+1)=0;

    for n=1:(length(bitStream)-1)

        t=n-1:0.001:n;

        if bitStream(n) == 0
            if bitStream(n+1)==0  
                y=(t<n-0.5).*-1 + -1*(t==n);
            else
                y=(t<n-0.5).*-1 +(t==n);
            end
            d=plot(t,y);
            grid on;
            set(d,'LineWidth',2.5);
            hold on;
            axis([0 length(bitStream)-1 -1 1]);
        else
            if bitStream(n+1)==0
                y=(t<n-0.5)+ -1*(t==n);
            else
                y=(t<n-0.5)+(t==n);
            end
            d=plot(t,y);
            grid on;
            set(d,'LineWidth',2.5);
            hold on;
            axis([0 length(bitStream)-1 -1 1]);
        end
    end
end