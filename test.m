%% Encoding

bits = [1 1 0 1 1 0 1 1];
mlt = zeros(1, length(bits));

if bits(1) == 0
    mlt(1) = 0;
    sign = -1;
end
if bits(1) == 1
    mlt(1) = 1;
    sign = 1;
end



for i = 2:length(bits)
    if bits(i) == 0
        mlt(i) = mlt(i-1);
    end
    if bits(i) == 1 && mlt(i-1) == 0
        if sign == 1
            mlt(i) = -1;
            sign = -sign;
        elseif sign == -1
            mlt(i) = 1;
            sign = -sign;
        end
     elseif bits(i) == 1 && mlt(i-1) ~= 0
        mlt(i) = 0;
    end
end

bitrate = 1;
T = length(bits)/bitrate;
n = 1000;
N = n * length (bits);
dt = T / N;
t = 0:dt:T;

x = zeros(1, length(t));

%% Plotting

for i = 1:length(bits)
    x((i-1) * n + 1 : i * n) = mlt(i);
end

plot(t, x, 'Linewidth', 3);
hold on;
plot(xlim, [0 0], '-r')
hold off;
ax = gca;
ax.XGrid = 'on';
ax.YGrid = 'off';
ax.GridAlpha = 0.5;
title('MLT-3');

%% Decoding

% Decoding this is not possible