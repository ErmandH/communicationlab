% clear console and workspace
clc;
clear;

%% continuous and discrete plot
% sampling frequency should satisfy fs >= 2*fm
% Ts = 1/fs

fm = 10;
fs = 100 * fm;
ts = 1 / fs;
t = 0:ts:1-ts;

phase = 0;
s = cos(2*pi*fm*t + phase);

% continuous
figure;
subplot(2,1,1);
plot(t, s);
hold on;
axis([0 0.1 -1.5 1.5]);
xlabel('t (s)');
ylabel('s(t)');
title('Continuous Signal');

% discrete
subplot(2,1,2);
stem(0:length(s)-1, s);
axis([0 fs/fm-1 -1.5 1.5]);
xlabel('n');
ylabel('s[n]');
title('Discrete Signal');

%% plot s1 and s2
phase = -pi/2;
s1 = cos(2*pi*fm*t);
s2 = cos(2*pi*fm*t + phase);

figure;
subplot(2,1,1);
plot(t, s1);
hold on;
axis([0 0.1-ts -1.5 1.5]);
xlabel('t (s)');
ylabel('s1(t)');
title('phase = 0');
grid on;

subplot(2,1,2);
plot(t, s2);
hold on;
axis([0 0.1-ts -1.5 1.5]);
xlabel('t (s)');
ylabel('s2(t)');
title('phase = -\pi/2');
grid on;

%% overlay s1 and s2
figure;
plot(t, s1);
axis([0 0.1-ts -1.5 1.5]);
hold on;
plot(t, s2, 'r', 'LineWidth', 2);
axis([0 0.1-ts -1.5 1.5]);
xlabel('t (s)');
ylabel('Amplitude');
title('Overlay of s1 and s2');
legend('s1','s2');

%% frequency spectrum
S1 = fft(s1);
S2 = fft(s2);

f = linspace(-fs/2, fs/2, length(S1)+1);
f(end) = [];

figure;
subplot(2,1,1);
plot(f, abs(fftshift(S1)) / fs);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Magnitude Spectrum of s1');

subplot(2,1,2);
plot(f, angle(fftshift(S1)));
xlabel('Frequency (Hz)');
ylabel('Phase (rad)');
title('Phase Spectrum of s1');
grid on;

figure;
subplot(2,1,1);
plot(f, abs(fftshift(S1)) / fs);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Magnitude Spectrum of s1');

subplot(2,1,2);
plot(f, clean_phase(fftshift(S1), 1e4));
xlabel('Frequency (Hz)');
ylabel('Phase (rad)');
title('Cleaned Phase Spectrum of s1');
grid on;

figure;
subplot(2,1,1);
plot(f, abs(fftshift(S2)) / fs);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Magnitude Spectrum of s2');

subplot(2,1,2);
plot(f, clean_phase(fftshift(S2), 1e4));
xlabel('Frequency (Hz)');
ylabel('Phase (rad)');
title('Cleaned Phase Spectrum of s2');
grid on;

%%%%%% helper function %%%%%%
function phase_out = clean_phase(X, sensitivity)
  phase_out = angle(X);
  % zero out phases of components below threshold
  threshold = max(abs(X)) / sensitivity;
  phase_out(abs(X) < threshold) = 0;
endfunction

