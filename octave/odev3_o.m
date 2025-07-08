clc;clear; close all;

fs = 1000;
ts= 1/fs;
t = 0:ts:1-ts;

f1 = 20; f2 = 30; fc = 200; mod_i = 0.9;



% mesaj
m = ((2*cos(2*pi*f1*t)) + (5*cos(2*pi*f2*t))) ./ 5; 

c = cos(2*pi*fc*t);

% Frekans bölgesi için gerekli tanımlamalar
f = linspace(-fs/2, fs/2, length(c) + 1);
f = f(1:end-1);

fam = (1 + mod_i .* m) .* c;

f_am_copy = f_am;
f_am_copy(f_am_copy < 0) = 0;

v0 = f_am_copy;


%% a sikki
M = abs(fftshift(fft(m))) / length(m);
C = abs(fftshift(fft(c))) / length(c);
FAM = abs(fftshift(fft(fam))) / length(fam);

figure;
% C(F)
subplot(3,1,1);
plot(f, C);xlabel("f (Hz)"); ylabel("Genlik");
title("|C(f)|");
xlim([-300 300]);
grid on;

% M(F)
subplot(3,1,2);
plot(f, M);xlabel("f (Hz)"); ylabel("Genlik");
title("|M(f)|");
xlim([-300 300]);
grid on;

% F_AM(F)
subplot(3,1,3);
plot(f, FAM);xlabel("f (Hz)"); ylabel("Genlik");
title("|F_AM(f)|");
xlim([-300 300]);
grid on;


%% b sikki
