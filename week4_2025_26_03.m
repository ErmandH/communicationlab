clc;clear;
%% frekans ve zaman tanımlamaları
fs= 10^4; % hz
ts = 1 / fs;
t = 0:ts:1-ts;


%% mesaj işaretleri
f1m = 50; % hz
A1m = 1; % genlik 1

f2m = 25; % hz
A2m = 2; % genlik 2

s1 = A1m * cos(2*pi*f1m*t);
s2 = A2m * cos(2*pi*f2m*t);

s = s1 + s2;
%% mesajların frekans bölgesi
S1 = fftshift(fft(s1)) / length(s1);
S2 = fftshift(fft(s2)) / length(s2);
S = fftshift(fft(s)) / length(s);

f = linspace(-fs/2, fs/2, length(s1) + 1); % [fs/2 fs/2]
f = f(1: end-1); % [fs/2 fs/2)

x_right = 400;
x_left = -x_right;

y_up = 1.2;
y_down = 0;

figure("Name", "Mesaj Sinyalinin Oluşturulması")
% 1. İşaret
subplot 321
plot(t,s1)
xlabel("Zaman (s)")
ylabel("Genlik")
title("1. İşaret")
grid on

subplot 322
plot(f, S1);
xlabel("Frekans (Hz)")
ylabel("Genlik")
axis([x_left x_right y_down y_up])
title("1. İşaret");grid on;

% 2. İşaret
subplot 323
plot(t,s2)
xlabel("Zaman (s)")
ylabel("Genlik")
title("2. İşaret")
grid on

subplot 324
plot(f, S2);
xlabel("Frekans (Hz)")
ylabel("Genlik")
axis([x_left x_right y_down y_up])
title("2. İşaret");grid on;


% s = s1 + s2
subplot 325
plot(t,s)
xlabel("Zaman (s)")
ylabel("Genlik")
title("Mesaj İşareti")
grid on

subplot 326
plot(f, S);
xlabel("Frekans (Hz)")
ylabel("Genlik")
axis([x_left x_right y_down y_up])
title("Mesaj İşareti");grid on;

%% Taşıyıcı sinyalin oluşturulması
fc = 150;
Ac = 1;

c = Ac * cos(2*pi*fc*t);
% frekans bölgesi
C = fftshift(fft(c)) / length(c);

% ÇYB Modülasyon İşlemi
% zaman bölgesi
cyb_signal = s .* c;

%frekans bölgesi
CYB_signal = fftshift(fft(cyb_signal)) / length(cyb_signal);


figure("Name", "ÇYB Modülasyon Analizi")
% Mesaj
subplot 321
plot(t,s)
xlabel("Zaman (s)")
ylabel("Genlik")
title("Mesaj İşareti")
grid on

subplot 322
plot(f, S);
xlabel("Frekans (Hz)")
ylabel("Genlik")
axis([x_left x_right y_down y_up])
title("Mesaj İşareti");grid on;


% Taşıyıcı
subplot 323
plot(t,c)
xlabel("Zaman (s)")
ylabel("Genlik")
title("Taşıyıcı İşareti")
grid on

subplot 324
plot(f, C);
xlabel("Frekans (Hz)")
ylabel("Genlik")
axis([x_left x_right y_down y_up])
title("Taşıyıcı İşaret");grid on;

% CYB
subplot 325
plot(t,cyb_signal)
xlabel("Zaman (s)")
ylabel("Genlik")
title("Taşıyıcı İşareti")
grid on

subplot 326
plot(f, CYB_signal);
xlabel("Frekans (Hz)")
ylabel("Genlik")
axis([x_left x_right y_down y_up])
title("Taşıyıcı İşaret");grid on;

%% Demodülasyon


d = cyb_signal .* c;

D = fftshift(fft(d)) / length(d);

figure("Name", "ÇYB Demodülasyon Analizi")
% Mesaj
subplot 321
plot(t,s)
xlabel("Zaman (s)")
ylabel("Genlik")
title("Mesaj İşareti")
grid on

subplot 322
plot(f, S);
xlabel("Frekans (Hz)")
ylabel("Genlik")
axis([x_left x_right y_down y_up])
title("Mesaj İşareti");grid on;

% CYB
subplot 323
plot(t,cyb_signal)
xlabel("Zaman (s)")
ylabel("Genlik")
title("Taşıyıcı İşareti")
grid on

subplot 324
plot(f, CYB_signal);
xlabel("Frekans (Hz)")
ylabel("Genlik")
axis([x_left x_right y_down y_up])
title("Taşıyıcı İşaret");grid on;


% d(t)
subplot 325
plot(t,d)
xlabel("Zaman (s)")
ylabel("Genlik")
title("Demodüle İşaret")
grid on

% |D(f)|
subplot 326
plot(f, D);
xlabel("Frekans (Hz)")
ylabel("Genlik")
axis([x_left x_right y_down y_up])
title("Demodüle İşaret");grid on;


%% LPF tasarımı

wp = 20 / (fs / 2);
ws = 50 / (fs / 2);

Rp = 3; % 1db zayıflatma
Rs = 30; % 80db bastırma


% transfer fonksiyonunu çıkardı
[b, a] = butter(5, wp, "low");

[H1, ~] = freqz(b, a, length(s), "whole");
figure
stem(f, D)
xlabel("Frekans(Hz)")
ylabel("Genlik")
axis([x_left x_right y_down y_up])
title("Demodüle İşaret & Filtre Tasarımı")
hold on
plot(f, fftshift(abs(H1)), "r", "LineWidth", 2)
grid;

%% sinyalin elde edilmesi
y = filter(b,a, d);
Y = fftshift(abs(fft(y))) / length(y);


figure("Name", "Mesaj İşaretinin Geri elde Edilmesi")
% Mesaj
subplot 321
plot(t,s)
xlabel("Zaman (s)")
ylabel("Genlik")
title("Mesaj İşareti")
grid on

subplot 322
plot(f, S);
xlabel("Frekans (Hz)")
ylabel("Genlik")
axis([x_left x_right y_down y_up])
title("Mesaj İşareti");grid on;

% Mesaj
subplot 323
plot(t,d)
xlabel("Zaman (s)")
ylabel("Genlik")
title("Demodülasyon İşareti")
grid on

subplot 324
plot(f, D);
xlabel("Frekans (Hz)")
ylabel("Genlik")
axis([x_left x_right y_down y_up])
title("Demodülasyon İşareti");grid on;


subplot 325
plot(t,y)
xlabel("Zaman (s)")
ylabel("Genlik")
title("Filtrelenmiş İşareti")
grid on

subplot 326
plot(f, Y);
xlabel("Frekans (Hz)")
ylabel("Genlik")
axis([x_left x_right y_down y_up])
title("Filtrelenmiş İşareti");grid on;
%%
Amp = 2;
figure("Name","Sinyallerin karşılaştırılması")
plot(t,s,t, Amp * y)
xlim([0.05 0.3])
xlabel("Zaman (s)")
ylabel("Genlik")
legend("Mesaj İşareti", "Filtrelenmiş İşaret", "NumColumns", 2)