function [modSignal] = AMI( bitStream )
    bitStream(length(bitStream)+1)=0;
    ami=-1;

    for n=1:(length(bitStream)-1)
        t=n-1:0.001:n;
    
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
            d=plot(t,y);
            grid on;
            set(d,'LineWidth',2.5);
            hold on;
            axis([0 length(bitStream)-1 -1 1]);
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
            d=plot(t,y);
            grid on;
            set(d,'LineWidth',2.5);
            hold on;
            axis([0 length(bitStream)-1 -1 1]);
        end
    end
end