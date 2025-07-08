clc;clear; close all;

fs = 1000;
ts= 1/fs;
t = 0:ts:1-ts;

f1 = 20; f2 = 30; fc = 200;

m = 2 * cos(2*pi*f1*t) + 5 * cos(2*pi*f2*t);
c = cos(2*pi*fc*t);

m_hat = imag(hilbert(m));
c_hat = imag(hilbert(c));

x_tyb = (m .* c) + (m_hat .* c_hat);

d = x_tyb .* c;

% LPF tasarimi
Wn = 40 / (fs/2);
order = 4;

[b,a] = butter(order, Wn);
[H, ~] = freqz(b,a, fs,"whole");

% demodulasyon
m_demod = filter(b,a, d);

% Frekans bölgesi için gerekli tanımlamalar
f = linspace(-fs/2, fs/2, length(m) + 1);
f = f(1:end-1);

%% a sikki
M = abs(fftshift(fft(m))) / length(m);
C = abs(fftshift(fft(c))) / length(c);
X_TYB = abs(fftshift(fft(x_tyb))) / length(x_tyb);

figure;
subplot(3,1,1);
plot(f, C);
title("|C(f))|") ; xlabel("f (Hz)"); ylabel("Genlik");

subplot(3,1,2);
plot(f, M);
title("|M(f))|") ; xlabel("f (Hz)"); ylabel("Genlik");

subplot(3,1,3);
plot(f, X_TYB);
title("|X_TYB(f))|") ; xlabel("f (Hz)"); ylabel("Genlik");

%% b sikki
figure;
plot(t, x_tyb);
title("x_tyb(t)") ; xlabel("t (s)"); ylabel("Genlik");

%% c sikki
D = abs(fftshift(fft(d))) / length(d);
figure;
plot(f,D);
hold on;
plot(f, abs(fftshift(H)), "LineWidth", 2);

%% d sikki
M_DEMOD = abs(fftshift(fft(m_demod))) / length(m_demod);
figure;
subplot(2,1,1);
plot(f, M);
title("|M(f))|") ; xlabel("f (Hz)"); ylabel("Genlik");

subplot(2,1,2);
plot(f, M_DEMOD);
title("|M_DEMOD(f))|") ; xlabel("f (Hz)"); ylabel("Genlik");

%% e sikki
figure;
plot(t, m);
xlabel("t (sn)"); ylabel("Genlik");
hold on;
plot(t, m_demod);
legend("m(t)", "m_demod(t)")