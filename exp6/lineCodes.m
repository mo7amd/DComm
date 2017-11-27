function lineCodes( size )
% generate random signal vector 
    bitStream = rand( 1,size ) >= 0.5;
%     disp( bitStream );
% modulate signal :
    % 1- Non-return to zero:
    NRZ( bitStream )
    % 2- Non-return to zero inverted: 
    NRZI( bitStream );
    % 3- return to zero:
    RZ( bitStream );
    % 4- AMI:
    AMI( bitStream )
    % 5- manchester:
    manchester( bitStream );
    % 6- multi-level Transmission:
    MLT_3( bitStream );
end