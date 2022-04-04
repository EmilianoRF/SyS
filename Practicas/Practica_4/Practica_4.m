%% Ejercicio 1
clear all % borra las variables
close all % cierra las ventanas
clc % limpia la consola

Tm = 0.001; % Per?odo de muestreo
Fm = 1/Tm;
t = 0:Tm:1-Tm;
f1 = 10;
f2 = 20;
N = length(t);

s_t = sin(2*pi*f1*t) + 4*sin(2*pi*f2*t);
s_n = fft(s_t);
mod_sn = abs(s_n);

f = 0:Fm/N:Fm/2;

figure;
subplot(3,2,1);
stem(f,mod_sn(1:N/2 +1));
title('FFT[s(t)] con $f_1=10Hz$ y $f_2 = 20 Hz$','Interpreter','latex');
xlabel('f[Hz]','Interpreter','latex');



% 1.1 
s_t_1 = sin(2*pi*f1*t) + 4*sin(2*pi*f2*t)+4;
s_n_1 = fft(s_t_1);
mod_sn_1 = abs(s_n_1);

f = 0:Fm/N:Fm/2;

subplot(3,2,2);

stem(f,mod_sn_1(1:N/2 +1));
title('FFT[s(t)+offset] con $f_1=10Hz$ y $f_2 = 20 Hz$','Interpreter','latex');
xlabel('f[Hz]','Interpreter','latex');

%1.2
f1 = 10;
f2 = 11;

s_t_2 = sin(2*pi*f1*t) + 4*sin(2*pi*f2*t);
s_n_2 = fft(s_t_2);
mod_sn_2 = abs(s_n_2);

f = 0:Fm/N:Fm/2;

subplot(3,2,3);

stem(f,mod_sn_2(1:N/2 +1));
title('FFT[s(t)] con $f_1=10Hz$ y $f_2 = 11 Hz$','Interpreter','latex');
xlabel('f[Hz]','Interpreter','latex');

%1.3
t = 0:Tm:1-Tm;
f1 = 10;
f2 = 10.5;

s_t_3 = sin(2*pi*f1*t) + 4*sin(2*pi*f2*t);
s_n_3 = fft(s_t_3);
mod_sn_3 = abs(s_n_3);

f = 0:Fm/N:Fm/2;

subplot(3,2,4);

stem(f,mod_sn_3(1:N/2 +1));
title('FFT[s(t)] con $f_1=10Hz$ y $f_2 = 10.5 Hz$','Interpreter','latex');
xlabel('f[Hz]','Interpreter','latex');

%1.5
Tm = 0.001; % Per?odo de muestreo
Fm = 1/Tm;
t = 0:Tm:0.72-Tm;
f1 = 10;
f2 = 20;
N = length(t);

s_t = sin(2*pi*f1*t) + 4*sin(2*pi*f2*t);
s_n = fft(s_t);
mod_sn = abs(s_n);

f = 0:Fm/N:Fm/2;

subplot(3,2,5);
stem(f,mod_sn(1:N/2 +1));
title('FFT[s(t)] con $f_1=10Hz$ y $f_2 = 20 Hz$ y $t=0..72s$','Interpreter','latex');
xlabel('f[Hz]','Interpreter','latex');


%% Ejercicio 3
clear all % borra las variables
close all % cierra las ventanas
clc % limpia la consola

[Fm_ecg, Fm_eeg ,Fm_resp,Fm_pres] = deal(250,250,250,250);
Fm_emg = 1300;

s_ecg = load('ecg.txt');
s_ecg = s_ecg- mean(s_ecg);
N_ecg = length(s_ecg);
t_ecg = (0:N_ecg-1)*(1/Fm_ecg);
fft_ecg = abs(fft(s_ecg));
f_ecg = 0:Fm_ecg/N_ecg:Fm_ecg/2;

s_eeg = load('eeg.txt');
s_eeg = s_eeg - mean(s_eeg);
N_eeg = length(s_eeg);
t_eeg = (0:N_eeg-1)*(1/Fm_eeg);
fft_eeg = abs(fft(s_eeg));
f_eeg = 0:Fm_eeg/N_eeg:Fm_eeg/2;


s_emg = load('emg.txt');
s_emg = s_emg - mean(s_emg);
N_emg = length(s_emg);
t_emg = (0:N_emg-1)*(1/Fm_emg);
fft_emg = abs(fft(s_emg));
f_emg = 0:Fm_emg/N_emg:Fm_emg/2;


s_pres = load('presion.txt');
s_pres = s_pres - mean(s_pres);
N_pres = length(s_pres);
t_pres = (0:N_pres-1)*(1/Fm_pres);
fft_pres= abs(fft(s_pres));
f_pres = 0:Fm_pres/N_pres:Fm_pres/2;

s_resp = load('respiracion.txt');
s_resp = s_resp - mean(s_resp);
N_resp  = length(s_resp );
t_resp  = (0:N_resp -1)*(1/Fm_resp );
fft_resp  = abs(fft(s_resp));
f_resp = 0:Fm_resp/N_resp:Fm_resp/2;


figure;
subplot(5,2,1);
plot(t_ecg,s_ecg);
title('ECG','Interpreter','latex');
xlabel('t[s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');
subplot(5,2,2);
stem(f_ecg,fft_ecg(1:N_ecg/2+1));
title('FFT [ECG]','Interpreter','latex');
xlabel('f[hz]','Interpreter','latex');
ylabel('Modulo','Interpreter','latex');


subplot(5,2,3);
plot(t_eeg,s_eeg);
title('EEG','Interpreter','latex');
xlabel('t[s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');
subplot(5,2,4);
stem(f_eeg,fft_eeg(1:N_eeg/2+1));
title('FFT [EEG]','Interpreter','latex');
xlabel('f[hz]','Interpreter','latex');
ylabel('Modulo','Interpreter','latex');

subplot(5,2,5);
plot(t_emg,s_emg);
title('EMG','Interpreter','latex');
xlabel('t[s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');
subplot(5,2,6);
stem(f_emg,fft_emg(1:N_emg/2+1));
title('FFT [EMG]','Interpreter','latex');
xlabel('f[hz]','Interpreter','latex');
ylabel('Modulo','Interpreter','latex');


subplot(5,2,7);
plot(t_pres,s_pres);
title('Presion','Interpreter','latex');
xlabel('t[s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');
subplot(5,2,8);
stem(f_pres,fft_pres(1:N_pres/2+1));
title('FFT [Presion]','Interpreter','latex');
xlabel('f[hz]','Interpreter','latex');
ylabel('Modulo','Interpreter','latex');

subplot(5,2,9);
plot(t_resp,s_resp);
title('Respiracion','Interpreter','latex');
xlabel('t[s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');
subplot(5,2,10);
stem(f_resp,fft_resp(1:N_resp/2+1));
title('FFT [Respiracion]','Interpreter','latex');
xlabel('f[hz]','Interpreter','latex');
ylabel('Modulo','Interpreter','latex');

