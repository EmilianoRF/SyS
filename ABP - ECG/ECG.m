clear all;
close all;
clear clc;
a=10;

load ('signal.mat');
fs = 360;
T_muestreo = 1/fs;

N_submuestras = 100;

ECG_V2 = val(1,1:N_submuestras);
ECG_V2=(1/max(ECG_V2))*ECG_V2;
duracion_ECG_V2 = 0:T_muestreo:(length(ECG_V2)-1)*T_muestreo;

ECG_V5 = val(2,1:N_submuestras);
ECG_V5=(1/max(ECG_V5))*ECG_V5;
duracion_ECG_V5 = 0:T_muestreo:(length(ECG_V5)-1)*T_muestreo;


figure;
subplot(2,1,1);
plot(duracion_ECG_V2,ECG_V2);
title('$ECG-V2$','Interpreter','latex');
xlabel('$t[s]$','Interpreter','latex');
ylabel('$Amplitud [mV]$','Interpreter','latex');
grid;

subplot(2,1,2);
plot(duracion_ECG_V5,ECG_V5);
title('$ECG-V5$','Interpreter','latex');
xlabel('$t[s]$','Interpreter','latex');
ylabel('$Amplitud [mV]$','Interpreter','latex');
grid;

figure
plot(duracion_ECG_V5,ECG_V5);
fftECG = abs(fft(ECG_V5))
f = 0:Fs/length(duracion_ECG_V5):Fs/2;
plot(f,fftECG);
