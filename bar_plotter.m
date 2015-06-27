clear all;
close all;
clc;

figure;
for kk_iter = 1:1:7
    load('Results\NN.mat')
    Data(1) = mape(kk_iter);
    load('Results\SVR.mat')
    Data(2) = mape(kk_iter);
    load('Results\GPR.mat')
    Data(3) = mape(kk_iter);
    load('Results\SVRB.mat')
    Data(4) = mape(kk_iter);
    load('Results\GPRB.mat')
    Data(5) = mape(kk_iter);
    subplot(7,1,kk_iter);
    bar(Data);
end
