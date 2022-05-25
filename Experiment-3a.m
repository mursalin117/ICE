% B8ZS

% modulation
%bits = input('prompt');
bits = [1 0 0 0 0 0 0 0 0];
voltage = 5;
bitrate = 1;
n = 1000;
T = length(bits)/bitrate;
N = n*length(bits);
dt = T/N;
t = 0:dt:T;
x = zeros(1,length(t));
counter = 0;
lastbit = voltage;

for i=1:length(bits)
  if bits(i)==0
    counter = counter + 1;
    if counter==8
      x((i-1-7)*n+1:(i-7)*n) = 0;
      x((i-1-6)*n+1:(i-6)*n) = 0;
      x((i-1-5)*n+1:(i-5)*n) = 0;
      x((i-1-4)*n+1:(i-4)*n) = lastbit;
      x((i-1-3)*n+1:(i-3)*n) = -lastbit;
      lastbit = -lastbit;
      x((i-1-2)*n+1:(i-2)*n) = 0;
      x((i-1-1)*n+1:(i-1)*n) = lastbit;
      x((i-1)*n+1:i*n) = -lastbit;
      lastbit = -lastbit;
      counter = 0;
    end
  else
    counter = 0;
    x((i-1)*n+1:i*n) = -lastbit;
    lastbit = -lastbit;
  end
end
plot(t, x, 'Linewidth', 3);
ylim([-7, 7]);
xlabel('t');
ylabel('Amplitude');
title('B8ZS');

% demodulation
index = 0;
lastbit = voltage;
for i = 1:length(t)
  if t(i) > index
    index = index + 1;
    if x(i)==lastbit
      result(index:index+4) = 0;
      index = index + 4;
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
disp('B8ZS Decoding:');
disp(result);
