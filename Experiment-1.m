% Analog signal
% x(t) = a * sin (2 * pi * f * t + phase)

a = 5;
f = 2;
fs = 50 * f;
T = 2;
ph = pi / 2;

t = 0:1/fs:T-(1/fs);

x = a * sin (2 * pi * f * t + ph);

subplot(3, 1, 1);
plot(t, x);
xlabel('T');
ylabel('x(t)');
title('Analog signal with phase 90 degree');

% digital signal
% x(n) = a * sin (2 * pi * fd * n + phase)
%      = a * sin (2 * pi * f/fs * n + phase)

N = T * fs;
n = 0: N-1;

x = a * sin (2 * pi * (f / fs) * n + ph);

subplot(3, 1, 2);
stem(n, x);
xlabel('T');
ylabel('x(n)');
title('Digital signal with phase 90 degree');

% composite signal

a = 10;
f = 1;
fs = 50 * f;
T = 2;
ph = 0;

t = 0:1/fs:T-(1/fs);

x1 = a * sin(2 * pi * f * t + ph);
a = 3; f = 3; ph = 0;
x2 = a * sin(2 * pi * f * t + ph);
a = 2; f = 5; ph = 0;
x3 = a * sin(2 * pi * f * t + ph);

x = x1 + x2 + x3;

subplot(3, 1, 3);
plot(t, x1);
hold on;
plot(t, x2);
plot(t, x3);
plot(t, x);
xlabel('T');
ylabel('x(t)');
title('Analog composite signal');
hold off;