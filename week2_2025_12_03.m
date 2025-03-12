clc ,clear;

%% sürekli ve ayrık plot
% örnekleme frekansı en az fs >= 2.fm olacak
% Ts = 1/fs

fm = 10;
fs = 100 * fm;
ts = 1 / fs;
t = 0:ts: 1 - ts;

faz = 0;

s = cos(2*pi*fm*t + faz);

% surekli
figure;
subplot 211 % subplot(2,1,1)
plot(t,s)
hold on;
axis([0 0.1 -1.5 1.5])
xlabel("t")
ylabel("s(t)")
title("Sinyalin sürekli gösterimi")

% ayrik
subplot 212
stem(0: length(s) -1, s) % ayrık noktaları çizdirme
axis([0 fs/fm-1 -1.5 1.5]) % axis limitleri
xlabel("n")
ylabel("s(n)")
title("Sinyalin ayrık gösterimi")

%% s1,s2 çizdirme
faz = - pi / 2;
s1 = cos(2*pi*fm*t);
s2 = cos(2*pi*fm*t + faz);

% s1
figure;
subplot 211 % subplot(2,1,1)
plot(t,s1)
hold on;
axis([0 0.1-ts -1.5 1.5]) 
xlabel("t")
ylabel("s1(t)")
title("faz = 0")
grid on % ızgara görüntüsünü aktif et
% s2
subplot 212 % subplot(2,1,1)
plot(t,s2)
hold on;
axis([0 0.1-ts -1.5 1.5])
xlabel("t")
ylabel("s2(t)")
title("faz = -\pi / 2")
grid on

%% s1,s2 üst üste çizdirme
figure
plot(t, s1)
axis([0 0.1-ts -1.5 1.5])
hold on
plot(t, s2, "r", "LineWidth",2)
axis([0 0.1-ts -1.5 1.5])

%% frekans spektrumu
% fft = Discrete Fourier transform
S1 = fft(s1); 
S2 = fft(s2);

f = linspace(-fs/2,fs/2, length(S1) + 1 );
f(end) = []; 

figure;
subplot 211
plot(f,abs(fftshift(S1)) / fs)

subplot 212
plot(f,angle(fftshift(S1)))
grid on;

figure;
subplot 211
plot(f,abs(fftshift(S1)) / fs)

subplot 212
plot(f,faz_temizleme_v2(fftshift(S1), 10000))
grid on;

figure;
subplot 211
plot(f,abs(fftshift(S2)) / fs)

subplot 212
plot(f,faz_temizleme_v2(fftshift(S2), 10000))
grid on;

function [faz_temiz] = faz_temizleme_v2(IZGE, hassasiyet)
faz_temiz = angle(IZGE);
% şartı sağlayan tüm değerler 0 olucak
faz_temiz(abs(IZGE) < max(abs(IZGE)) / hassasiyet) = 0;
end

