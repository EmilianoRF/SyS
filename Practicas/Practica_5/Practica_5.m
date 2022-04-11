%% Ejercicio 1
clear all % borra las variables
close all % cierra las ventanas
clc % limpia la consola

N =30;
x      = zeros(1,N);
y      = zeros(1,N);
x(1)   = 1;
% y[n]?0,5y[n?1]+ 0,25y[n ? 2] = x[n]
for n = 1:N
    if n == 1
        y(n) =x(n) ;
    elseif n == 2
        y(n) =x(n)+0.5*y(n-1);
    else
        y(n) = 0.5*y(n-1)-0.25*y(n-2)+x(n);
    end
end
figure;
subplot(2,1,1);
stem(x);
title('Entrada','Interpreter','latex');
xlabel('N','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');

subplot(2,1,2);
stem(y);
title('Salida','Interpreter','latex');
xlabel('N','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');


a = [1];
b = [1 -0.5 0.25];
y_f = filter(b,a,x);
figure;
subplot(2,1,1);
stem(x);
title('Entrada','Interpreter','latex');
xlabel('N','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');

subplot(2,1,2);
stem(y_f);
title('Salida con Filter','Interpreter','latex');
xlabel('N','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');
%% Guia convolucion - Ejercicio 2

% 6y[n]?4y[n?1]+5y[n?2] = x[n] ? 2x[n ? 1] + x[n ? 2]

clear all % borra las variables
close all % cierra las ventanas
clc % limpia la consola

N=70;
x = ones(1,N);

a = [6 -4 5];
b = [1 -2 1];

y = filter(b,a,x);

figure;

subplot(2,1,1);
stem(x);
title('Entrada','Interpreter','latex');
xlabel('N','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');

subplot(2,1,2);
stem(y);
title('Salida','Interpreter','latex');
xlabel('N','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');

delta = zeros(1,N);
delta(1) = 1;

h = filter(b,a,delta);
y_c = conv(x,h);

figure;
subplot(2,1,1);
stem(h);
title('Respuesta al impulso','Interpreter','latex');
xlabel('N','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');

subplot(2,1,2);
stem(y_c);
title('Salida por convolucion','Interpreter','latex');
xlabel('N','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');


%% Guia convolucion - Ejercicio 8
clear all % borra las variables
close all % cierra las ventanas
clc % limpia la consola

h = load('pb100.txt');
fm = 1000;

N = length(h);
t = (0:N)*(1/fm);

x = sin(2*pi*10*t)+ sin(2*pi*50*t)+ sin(2*pi*100*t) + sin(2*pi*150*t);
y = conv(x,h);

figure;
subplot(3,1,1);
stem(h);
title('Respuesta al impulso','Interpreter','latex');
xlabel('t','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');

subplot(3,1,2);
stem(x);
title('Entrada','Interpreter','latex');
xlabel('t','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');

subplot(3,1,3);
stem(y);
title('Salida','Interpreter','latex');
xlabel('t','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');


figure;
subplot(3,1,1);
fft_h = abs(fft(h,512));
stem(fft_h)

title('FFT - Respuesta al impulso','Interpreter','latex');
xlabel('f','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');
xlim([0 256]);

subplot(3,1,2);
fft_x = abs(fft(x,512));
stem(fft_x)
title('FFT - Entrada','Interpreter','latex');
xlabel('f','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');
subplot(3,1,3);
xlim([0 256]);


fft_y = abs(fft(y,512));
stem(fft_y)
title('FFT - Salida','Interpreter','latex');
xlabel('f','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');
xlim([0 256]);
