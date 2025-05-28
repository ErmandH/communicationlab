clc;clear; close all;

N = 100;
EbNo_db = 0:2:10;
max_bits = 3E8;
for k = 1:length(EbNo_db)
    % transmitter
    b = randi([0 1], 1, N);
    s = 2*b - 1;
    
    tot_err = 0;
    tot_bits = 0;
    while (tot_err < 1000) && (tot_bits < max_bits)
    % AWGN Channel
    sigma = 10^(- EbNo_db(k) / 20);
    n = sigma * (randn(1,N) + 1i * randn(1, N)) / sqrt(2);
    r = s + n;
    %scatterplot(r)
    %pause

    % receiver

    b_est = r > 0;
    num_err = sum(b ~= b_est);
    tot_err = tot_err + num_err;
    tot_bits = tot_bits + N;
    end
    ber(k) = tot_err / tot_bits;
end

figure;
semilogy(EbNo_db, ber, '-or', 'LineWidth', 1.5);
hold on

SNRdb = 0:10;
SNRs = 10.^(SNRdb / 10);
theoryBerAWGN = 0.5 * erfc(sqrt(SNRs));
semilogy(SNRdb, theoryBerAWGN, '-b', 'LineWidth', 1.5);
grid on;
legend("Simulation", "Theoretical")


