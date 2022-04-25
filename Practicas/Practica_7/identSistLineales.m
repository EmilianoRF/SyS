%% Ejercicio 2
clear all; close all;

% =========================================
% Generar una seÃ±al aleatoria x
% frecuencia de muestreo: 10 kHz
% duracion: 1 s.


fm = 10000;
t  = 0:1/fm:1-1/fm;
N  = length(t);


% =========================================
% Calcular la salida usando la ecuacion en recurrencia

x = randn(1,N);
figure;
subplot(3,1,1);
plot(t,x);
title('$x[n]$','Interpreter','latex');
xlabel('$t[s]$','Interpreter','latex');
ylabel('$Amplitud$','Interpreter','latex');

%y[n] = 0,3y[n - 1] -0,4y[n - 2]+0,2y[n - 3]+ x[n] 
b = [1];
a = [1 -0.3 -0.4 0.2];
% Salida ante la delta de dirac
y = filter(b,a,x);
subplot(3,1,2);

plot(t,y);
title('$y[n]$','Interpreter','latex');
xlabel('$t[s]$','Interpreter','latex');
ylabel('$Amplitud$','Interpreter','latex');
% =========================================
% Ventanear con Hanning

y = y.*hanning(N)';
subplot(3,1,3);

plot(t,y);
title('$y[n]$ ventaneada con Hanning','Interpreter','latex');
xlabel('$t[s]$','Interpreter','latex');
ylabel('$Amplitud$','Interpreter','latex');
% =========================================
% =========================================
% IDENTIFICACION DEL SISTEMA LTI

rcomp=xcorr(y);
figure;
plot(rcomp);
title('Autocorrelacion');
%pause;

r=rcomp(ceil(length(rcomp)/2):length(rcomp));
figure;
plot(r);
title('Autocorrelacion positiva');
%pause;

figure;
plot(r(1:100));
title('Autocorrelacion positiva (zoom)');
%pause;

Vp=zeros(1,10);
Ip=zeros(1,10);
for p=1:10
    % calculo de coeficientes LPC
    [a,Ep2]=lpc(y,p);
    a=real(a);

    % error de prediccion final
    % segun matlab: Ep=sqrt(Ep2);
    Ep=r(1)+r(2:p+1)*a(2:p+1)';
    Vp(p)=Ep/r(1);

    % criterio de Akaike
    Ip(p)=log(Ep)+2*p/(0.4*length(x));
end

figure;
subplot(1,2,1);
plot(Vp);
title('Error de prediccion Vp');
xlabel('orden');
grid;

subplot(1,2,2);
plot(Ip);
title('Error segun criterio de Akaike');
xlabel('orden');
grid;

%% Ejercicio 3

clear all; close all;
clear clc;
fm = 250;

y = load('eeg.txt');
y = y/max(y);
N = length(y);
t = (0:N-1)*(1/fm);

x = randn(1,N);

%subplot(2,1,1);
%plot(t,y);
%title('EEG','Interpreter','latex');
%xlabel('t[s]','Interpreter','latex');
%ylabel('Amplitud','Interpreter','latex');

% Se calcula la autocorrelaciòn
R=xcorr(y');
R=R(ceil(length(R)/2):length(R));

% Se determina el orden òptimo del sistema

Vp=zeros(1,10);
Ip=zeros(1,10);

for p=1:1000
    % calculo de coeficientes LPC
    [a,Ep2]=lpc(y,p);
    a=real(a);

    % error de prediccion final
    % segun matlab: Ep=sqrt(Ep2);
    Ep=R(1)+R(2:p+1)*a(2:p+1)';
    Vp(p)=Ep/R(1);

    % criterio de Akaike
    Ip(p)=log(Ep)+2*p/(0.4*length(x));
end

figure;
subplot(1,2,1);
plot(Vp);
title('Error de prediccion Vp');
xlabel('orden');
grid;

subplot(1,2,2);
plot(Ip);
title('Error segun criterio de Akaike');
xlabel('orden');
grid;

