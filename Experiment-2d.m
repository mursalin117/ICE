% Bipolar AMI

% modulation
% bits = input('prompt');
bits = [0 1 0 0 1 0];
voltage = 5;
bitrate = 1;
n = 1000; % sampling frequency 
T = length(bits)/bitrate; % total time
N = n*length(bits); % total sampling no.
dt = T/N; % time for each sample
t = 0:dt:T;
x = zeros(1, length(t));
lastbit = -voltage;

for i = 1:length(bits)
  if bits(i) == 1
    x((i-1)*n+1:i*n) = -lastbit;
    lastbit = -lastbit;
  endif
endfor

plot(t, x);
ylim([-7, 7]);
xlabel('T');
ylabel('Amplitude');
title('Bipolar AMI');

% demodulation
index = 0;

for i = 1:length(t)
  if t(i) > index
    index = index + 1;
    result(index) = abs(x(i)/voltage);
  endif
endfor

disp('Bipolar AMI decoding');
disp(result);