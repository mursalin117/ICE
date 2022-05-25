% HDB3

% modulation
% bits = input('prompt');
bits = [1 1 0 0 0 0 1 0 0 0 0 0 0 0 0 0];
voltage = 5;
bitrate = 1;
n = 1000;
T = length(bits)/bitrate;
N = n*length(bits);
dt = T/N;
t = 0:dt:T;
x = zeros(1,length(t));
counter = 0;
lastbit = -voltage;
pulse = 0;

for i=1:length(bits)
  if bits(i)==0
    counter = counter + 1;
    if counter==4
      if(mod(pulse, 2)==0)
        x((i-1-3)*n+1:(i-3)*n) = -lastbit;
        lastbit = -lastbit;
        x((i-1-2)*n+1:(i-2)*n) = 0;
        x((i-1-1)*n+1:(i-1)*n) = 0;
        x((i-1)*n+1:i*n) = lastbit;
        counter = 0;
        pulse = 0;
      else
        x((i-1-3)*n+1:(i-3)*n) = 0;
        x((i-1-2)*n+1:(i-2)*n) = 0;
        x((i-1-1)*n+1:(i-1)*n) = 0;
        x((i-1)*n+1:i*n) = lastbit;
        counter = 0;
        pulse = 0;
      end
    end
  else
    counter = 0;
    x((i-1)*n+1:i*n) = -lastbit;
    lastbit = -lastbit;
    pulse = pulse + 1;
  end
end
plot(t, x, 'Linewidth', 3);
ylim([-7, 7]);
xlabel('t');
ylabel('Amplitude');
title('HDB3');

% demodulation
index = 0;
lastbit = -voltage;
for i = 1:length(t)
  if t(i) > index
    index = index + 1;
    if x(i)==lastbit
      result(index-3:index) = 0;
    else
      if(x(i)==0)
        result(index) = 0;
      else
        result(index) = 1;
        lastbit = -lastbit;
      end
    end
  end
end
disp('HDB3 Decoding:');
disp(result);
