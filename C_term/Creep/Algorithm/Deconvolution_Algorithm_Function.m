function [h,F1_predi,F2_predi,F3_predi,F4_predi,F5_predi] = ...
    Deconvolution_Algorithm_Function(F1_corr,F2_corr,F3_corr,F4_corr,F5_corr,...
    F1_meas,F2_meas,F3_meas,F4_meas,F5_meas,F1_appl,F2_appl,F3_appl,F4_appl,F5_appl)

% Create Array for Pseudoinverse
for i = 1:length(F1_corr)
    F1_array(i,:) = F1_meas( i+1 : length(F1_corr)+i );
end

for i = 1:length(F2_corr)
    F2_array(i,:) = F2_meas( i+1 : length(F2_corr)+i );
end

for i = 1:length(F3_corr)
    F3_array(i,:) = F3_meas( i+1 : length(F3_corr)+i );
end

for i = 1:length(F3_corr)
    F4_array(i,:) = F4_meas( i+1 : length(F4_corr)+i );
end

for i = 1:length(F3_corr)
    F5_array(i,:) = F5_meas( i+1 : length(F5_corr)+i );
end

% Extract force array for inverse calculation
F1_ideal = F1_appl(length(F1_corr)+1 : length(F1_appl));
F2_ideal = F2_appl(length(F2_corr)+1 : length(F2_appl));
F3_ideal = F3_appl(length(F3_corr)+1 : length(F3_appl));
F4_ideal = F4_appl(length(F4_corr)+1 : length(F4_appl));
F5_ideal = F5_appl(length(F5_corr)+1 : length(F5_appl));

% Combine F1 array, F2 array and F3 array F4 array and F5 array
F1F2F3F4F5_array = [F1_array ; F2_array ; F3_array; F4_array; F5_array];
F1F2F3F4F5_ideal = [F1_ideal F2_ideal F3_ideal F4_ideal F5_ideal];
F1F2F3F4F5_ideal = F1F2F3F4F5_ideal';

% Calculate magic vector h
h = pinv(F1F2F3F4F5_array)*F1F2F3F4F5_ideal;

% Get predicted force by multiplying h back
predi_array = F1F2F3F4F5_array*h;

% 1N force
F1_predi = F1F2F3F4F5_array*h;
F1_predi_fonly = F1_predi(1:length(F1_corr));
F1_predi = [zeros(length(F1_corr), 1); F1_predi_fonly];

% 2N force
F2_predi = F1F2F3F4F5_array*h;
F2_predi = F2_predi((length(F1_corr)+1) : (length(F1_corr)+length(F2_corr)));
F2_predi = [zeros(length(F2_corr), 1); F2_predi];

% 3N force
F3_predi = F1F2F3F4F5_array*h;
F3_predi = F3_predi((length(F1_corr)+length(F2_corr)+1) : (length(F1_corr)+length(F2_corr)+length(F3_corr)));
F3_predi = [zeros(length(F3_corr), 1) ; F3_predi];

% 4N force
F4_predi = F1F2F3F4F5_array*h;
F4_predi = F4_predi((length(F1_corr)+length(F2_corr)+length(F3_corr)+1) : (length(F1_corr)+length(F2_corr)+length(F3_corr)+length(F4_corr)));
F4_predi = [zeros(length(F4_corr), 1) ; F4_predi];

% 5N force
F5_predi = F1F2F3F4F5_array*h;
F5_predi = F5_predi((length(F1_corr)+length(F2_corr)+length(F3_corr)+length(F3_corr)+1) : end);
F5_predi = [zeros(length(F4_corr), 1) ; F5_predi];




end

