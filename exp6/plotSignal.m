function plotSignal(signal, time, i, bitStream, head)
%     set figure 1 for line coding plot
    figure(1);
    subplot(6,1,i);
    plot(time,signal,'LineWidth',2.5);
%   draw the bitstream above of the line codes(not completed feature).
%     text(bit-0.5, pulse+2, num2str(bitStream(bit)), ...
%         'FontWeight', 'bold')
    % draw grid
    grid on;
    axis([0 length(bitStream) -1 1]);
    set(gca,'YTick', [-1 0 1]);
    set(gca,'XTick', 1:length(bitStream));
    set(gca,'XTickLabel', '');
    title(head);
end