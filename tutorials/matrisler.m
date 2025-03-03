clc;clear;
% Random komutu
%%
% - whos komutu command windowa yazılınca programdaki değişkenlerin tipini ve boyutunu gösteren
% 
%%
% rand fonksiyonu 0-1 arasi rastgele sayi uretiyor
random_num = rand; % 0-1
random_int = randi(10); % 1-10
%% Satir Vektor (row)
r1 = [5, 1, 3] % satır vektörü
r2 = [5 1 3] % virgulsuz de oluyor
%% Sutun Vektor (column)
c1 = [5; 7; 8] % her noktali virgulde satir atliyor yani bu column vector oldu
% alternatif column vector
c2 = [5 7 8]' % tirnak isareti matrisin TRANSPOZUNU aliyor boylece yine column vector oluyor
%% Vector concat
% boyutlari ayni olmasi lazim vektorlerin
sum1 = [r1 r2] % r1 ve r2 nin degerlerini icine koyuyor output: [5 1 3 5 1 3]
sum2 = [c1 c2] % output: [ 5 5; 7 7; 8;8]
%% Matrix olusturma
M = [1 2 3; 
    16 3 7;
    5 9 123]
%% Matris oluşturma fonksiyonları
z = zeros(3, 2) % 3x2 sifirlardan olusan matris
o = ones(3, 2) % birlerden olusan matris
%% Matris element-by-element islemleri

[6, 3] + 2 % output = [8, 5]
[6, 3] - 2 % output = [4, 1]
[6, 3] + [7, 4] % output = [13, 7]
[6, 3] - [7, 4] % output = [-1, -1]

% carpmada her elementin birbiriyle carpilmasi icin .* kullanmamiz gerek
[3, 5] .* [5, 12] % output = [15, 60]
% bolme ayni sekilde
[3, 5] ./ [5, 12] % output = [3\5, 5\12]

% us alma
[3, 5] .^ [5, 12] % output = [3^5, 5^12]


%% Matriste indexler
% M(rows, cols)
M(3) % 3. satir
M(3,2) % 3. satir 2. sutun
M(2,:) % 2. satirin tum sutunlari
M(:, 3) % tum satirlarin 3. sutunu

%% Ekstra bilgiler
matrix_size = size(M) % matrisin kaca kac oldugunu verir [2, 3] gibi 
length(M) % matrisin boyu
max(M) % sutunlarin en buyuklerini veriyo
min(M) % sutunlarin en kucuklerini veriyo
sum(M) % matrisi topluyo
sort(M) % sutunlari kendi icinde siraliyo
