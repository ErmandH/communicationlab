% MATLAB'de grafik çizme ile ilgili temel fonksiyonlar

% Temel 2D çizim
x = linspace(0, 10, 100); % 0 ile 10 arasında 100 nokta oluştur
y = sin(x); % x'in sinüsünü hesapla
figure; % Yeni bir figür penceresi aç
plot(x, y, 'b-', 'LineWidth', 2); % x-y verilerini mavi çizgiyle çiz
xlabel('X ekseni'); % X ekseni etiketi
ylabel('Y ekseni'); % Y ekseni etiketi
title('Sinüs Grafiği'); % Başlık ekle
grid on; % Izgarayı aç

% Birden fazla grafiği aynı eksende çizme
hold on; % Mevcut grafiğe yeni grafik eklemeye izin ver
y2 = cos(x); % Kosinüs fonksiyonunu hesapla
plot(x, y2, 'r--', 'LineWidth', 2); % x-y2 verilerini kırmızı kesikli çizgiyle çiz
legend('sin(x)', 'cos(x)'); % Grafiğe açıklama ekle
hold off; % Yeni çizimlerin eski çizimi bozmaması için kapat

% Scatter (dağılım) grafiği
figure; % Yeni bir figür penceresi aç
scatter(x, y, 50, 'filled'); % x-y noktalarını daire şeklinde doldurulmuş olarak göster
xlabel('X ekseni'); ylabel('Y ekseni'); title('Scatter Grafiği'); grid on;

% Çubuk grafiği (bar chart)
figure;
bar(x(1:10), y(1:10)); % İlk 10 değeri çubuk grafiği olarak çiz
xlabel('X ekseni'); ylabel('Y ekseni'); title('Çubuk Grafiği');

% Histogram
figure;
data = randn(1, 1000); % Normal dağılıma sahip rastgele 1000 veri üret
histogram(data, 20); % 20 aralıklı histogram çiz
xlabel('Değerler'); ylabel('Frekans'); title('Histogram Grafiği');

% 3D grafik çizimi
[X, Y] = meshgrid(-5:0.5:5, -5:0.5:5); % 3D grid oluştur
Z = sin(sqrt(X.^2 + Y.^2)); % Z değerlerini hesapla
figure;
surf(X, Y, Z); % 3D yüzey grafiği çiz
xlabel('X ekseni'); ylabel('Y ekseni'); zlabel('Z ekseni');
title('3D Yüzey Grafiği');
colorbar; % Renk skalası ekle
shading interp; % Daha düzgün bir yüzey gösterimi sağlar
