clc;clear; close all;

fs = 5000;
ts= 1/fs;
t = 0:ts:1-ts;

Ac = 1; Am = 1; fc = 200; fm = 10; kf = 80*2*pi;

c = Ac * cos(2*pi*fc*t);
m = Am * cos(2*pi*fm*t);

integral_xm = cumsum(m) * ts;

s_fm = Ac * cos(2*pi*fc*t + kf * integral_xm);

f = linspace(-fs/2, fs/2, length(m) + 1); % [fs/2 fs/2]
f = f(1: end-1); % [fs/2 fs/2)

