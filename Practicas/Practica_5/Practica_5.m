%% Ejercicio 1
clear all % borra las variables
close all % cierra las ventanas
clc % limpia la consola

N =30;
% La entrada es la Delta de Dirac
x      = zeros(1,N);
x(1)   = 1;

%Expresion de la salida
% y[n] - 0,5y[n-1]+ 0,25y[n - 2] = x[n]

% ======== CALCULO DE LA SALIDA A PARTIR DE LA EXPRESION      =========== %
for n = 1:N
    if n == 1
        y(n) = x(n) ; % Porque la funcion es causal
    elseif n == 2
        y(n) =x(n)+0.5*y(n-1); % Porque la funcion es causal
    else
        y(n) = 0.5*y(n-1)-0.25*y(n-2)+x(n);
    end
end

figure;
subplot(2,1,1);
stem(x);
title('Entrada $\delta[n-1]$','Interpreter','latex');
xlabel('N','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');

subplot(2,1,2);
stem(y);
title('Respuesta al impulso $h[n]$','Interpreter','latex');
xlabel('N','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');

% ===== CALCULO DE LA SALIDA A PARTIR DE LA EXPRESION Y FILTER    ======= %

a = [1];
b = [1 -0.5 0.25];
% Salida ante la delta de dirac
y_f = filter(b,a,x);


figure;
subplot(2,1,1);
stem(x);
title('Entrada $\delta[n-1]$','Interpreter','latex');
xlabel('N','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');

subplot(2,1,2);
stem(y_f);
title('Respuesta al impulso $h[n]$ utilizando $Filter$','Interpreter','latex');
xlabel('N','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');

%% Guia convolucion - Ejercicio 2



clear all % borra las variables
close all % cierra las ventanas
clc % limpia la consola


N=70;
%Entrada
x = ones(1,N);
%Expresion de la salida
% 6y[n]-4y[n-1]+5y[n-2] = x[n] - 2x[n -1] + x[n - 2]

% ======== CALCULO DE LA SALIDA A PARTIR DE LA EXPRESION      =========== %
a = [6 -4 5];
b = [1 -2 1];
y = filter(b,a,x);

figure;

subplot(2,1,1);
stem(x);
title('Entrada $x[n]$','Interpreter','latex');
xlabel('N','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');

subplot(2,1,2);
stem(y);
title('Salida $y[n]$','Interpreter','latex');
xlabel('N','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');



% ========   CALCULO DE LA SALIDA POR CONVOLUCION       ================= %

delta = zeros(1,N);
delta(1) = 1;
% Se calcula la respuesta al impulso
h = filter(b,a,delta);
% Se calcula la salida para la entrada x[n]
y_c = conv(x,h);

figure;
subplot(2,1,1);
stem(h);
title('Respuesta al impulso $h[n]$','Interpreter','latex');
xlabel('N','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');

subplot(2,1,2);
stem(y_c);
title('Salida $y[n]$ por convolucion','Interpreter','latex');
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

% ============== PLOTS DE LAS FUNCIONES EN EL TIEMPO ==================== %
figure;
subplot(3,1,1);
stem(h);
title('Respuesta al impulso $h[n]$','Interpreter','latex');
xlabel('t [s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');

subplot(3,1,2);
stem(x);
title('Entrada $x[n]$','Interpreter','latex');
xlabel('t [s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');

subplot(3,1,3);
stem(y);
title('Salida $y[n]$','Interpreter','latex');
xlabel('t [s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');



% ===================== PLOTS DE LAS FFT ================================ %
figure;
subplot(3,1,1);
fft_h = abs(fft(h,512));
stem(fft_h)
title('FFT - $h[n]$','Interpreter','latex');
xlabel('f [Hz]','Interpreter','latex');
ylabel('Modulo','Interpreter','latex');
xlim([0 256]);

subplot(3,1,2);
fft_x = abs(fft(x,512));
stem(fft_x)
title('FFT - $x[n]$','Interpreter','latex');
xlabel('f [Hz]','Interpreter','latex');
ylabel('Modulo','Interpreter','latex');
xlim([0 256]);


subplot(3,1,3);
fft_y = abs(fft(y,512));
stem(fft_y)
title('FFT - $y[n]$','Interpreter','latex');
xlabel('f [Hz]','Interpreter','latex');
ylabel('Modulo','Interpreter','latex');
xlim([0 256]);
