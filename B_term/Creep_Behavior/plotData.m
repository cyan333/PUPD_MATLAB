function [ t, res, weight ] = plotData( file )
% plotData

% Parses .csv file and converts time to minutes, voltage to
% resistance (based on the lab setup), and the weight added
% to the sensor

% resistor is the resistor value used for voltage divider
% Vcc is the voltage applied on the voltage divider
resistor = 3.3;
Vcc = 4.9;

% Parses and converts time to seconds starting at 0 seconds
t=xlsread(file,'A:A');
init = t(1,1);
len = size(t);
for n = 1:len(1,1)
    if t(n,1) >= init
        t(n,1) = t(n,1) - init;
    else
        t(n,1)= t(n,1) + 3600 - init;
    end
end
t = t ./ 60;

% Parses and converts voltage into resistance of the FSR
volt = xlsread(file,'B:B');
res = (volt .* resistor) ./ (Vcc - volt);

% Parses weight
weight = xlsread(file,'C:C');

end

