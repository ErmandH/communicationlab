Bu soruyu çözmek için filtre tasarımı ile ilgili mevcut dosyalarınızı inceleyerek `buttord` fonksiyonunun nasıl kullanıldığını öğreneyim.
Search files...
Read file: dokumanlar/IIR_filtreTasarimi/iir_filterDesign_bwLP.m
Read file: dokumanlar/Filtreleme/filtre_kullanimi.m

Mevcut dosyalarınızı inceledikten sonra, bu genlik modülasyonu probleminde `buttord` fonksiyonunun nasıl tanımlanması gerektiğini size açıklayabilirim.

## Bu Problem İçin `buttord` Fonksiyonu Tanımlaması:

Problemdeki bilgiler:
- **Mesaj frekansları**: f₁ = 20 Hz, f₂ = 30 Hz  
- **Taşıyıcı frekans**: fc = 200 Hz
- **Örnekleme frekansı**: fs = 1000 Hz
- **Modülasyon indisi**: m = 0.9

Demodülasyon için alçak geçiren filtre parametreleri şöyle tanımlanmalı:

```matlab
% Filtre parametreleri
fs = 1000;  % Örnekleme frekansı

% Geçiş bandı frekansı (wp): Mesaj sinyalinin en yüksek frekansından biraz fazla
wp = 40 / (fs/2);  % 40 Hz normalize edilmiş frekans

% Durdurulan bant frekansı (ws): Taşıyıcı frekansından önce
ws = 100 / (fs/2); % 100 Hz normalize edilmiş frekans

% Geçiş bandındaki dalgalanma (Rp): dB cinsinden
Rp = 3;  % 3 dB geçiş bandı dalgalanması

% Durdurulan banttaki zayıflatma (Rs): dB cinsinden  
Rs = 40; % 40 dB durdurulan bant zayıflatması

% buttord fonksiyonu ile filtre derecesi ve kesim frekansını hesaplama
[n, Wn] = buttord(wp, ws, Rp, Rs);

% Butterworth alçak geçiren filtre katsayılarını hesaplama
[b, a] = butter(n, Wn, 'low');
```

## Neden Bu Değerler?

1. **wp = 40 Hz**: Mesaj sinyalinin en yüksek bileşeni 30 Hz olduğu için, biraz marj bırakarak 40 Hz seçilmiştir.

2. **ws = 100 Hz**: Taşıyıcı frekans 200 Hz ve demodülasyon sonrası 2×fc = 400 Hz'lik bileşenler oluşur. Bu bileşenleri bastırmak için 100 Hz seçilmiştir.

3. **Rp = 3 dB**: Geçiş bandında kabul edilebilir dalgalanma seviyesi.

4. **Rs = 40 dB**: Yüksek frekanslı bileşenleri yeterince bastırmak için.

Mevcut dosyalarınızda (`filtre_kullanimi.m`, `week5_2025_09_04.m`) benzer yaklaşımlar kullanılmış ve bu genlik modülasyonu demodülasyonu için standart bir yöntemdir.