%% Ejercicio 1
clear all % borra las variables
close all % cierra las ventanas
clc % limpia la consola

% y[n] ?1/2 y[n ? 1] + 1/4 y[n ? 2] = x[n]
fm = 10000;
N = 1024;

b = [1 0];
a = [1 -1/2 1/4];

tita = 0:pi/512:pi-pi/512;
z = exp(1i*tita);
f = tita*fm/(2*pi);

% CÀLCULO A PARTIR DE LA FFT DE LA H

delta      = zeros(1,N);
delta(1)   = 1;

h_n = filter(b,a,delta);
fft_h_n = abs(fft(h_n));
fft_h_n = fft_h_n(1:512);

fft_h_n_db = 20*log10(fft_h_n);

figure;
subplot(2,1,1);

plot(f,fft_h_n_db);

title('FFT $H[n]$','Interpreter','latex');
xlabel('$f[Hz]$','Interpreter','latex');
ylabel('Amplitud [db]','Interpreter','latex');

% CÀLCULO A PARTIR EXPRESION DE LA H
h_z = 1./( 1-(1/2)*z.^(-1)+(1/4)*z.^(-2));

H_z_db = 20*log10(abs(h_z));

subplot(2,1,2);
plot(f,H_z_db);
title('$H(z)$','Interpreter','latex');
xlabel('$f[Hz]$','Interpreter','latex');
ylabel('Amplitud [db]','Interpreter','latex');

% Con la funcion de Matlab
% freqz(b,a,'whole',fm)


%% Ejercicio 2
clear all % borra las variables
close all % cierra las ventanas
clc % limpia la consola
