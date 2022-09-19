%% Ejercicio 1: Considere el sistema
% y[n] = 0,3y[n - 1] -0,4y[n - 2]+0,2y[n - 3]+ x[n] y genere una secuencia
% de salida a una entrada de tipo aleatoria con distribución uniforme y valor
% medio cero. Utilizando esta señal de salida implemente el método 
% de predicción lineal y verifique el comportamiento de los criterios
% para estimación del orden.
clear all; close all;

% =========================================
% Generar una señal aleatoria x
% frecuencia de muestreo: 10 kHz
% duracion: 1 s.
fm = 10000;
t = 0:1/fm:1-1/fm;
N = length(t);
% Señal aleatoria con distribución gausiana media 0 y desvio estandar 1
x = randn(1,N);
% otra opcion con distribucion uniforme entre -1 y 1
%x=-1+2*rand(1,N);

% =========================================================================

% Calcular la salida usando la ecuacion en recurrencia
num = 1;
den = [1 -0.3 0.4 -0.2];
y  = filter(num,den,x);

% =========================================================================
% Ventanear con Hanning

% En las aplicaciones prácticas nunca podemos realizar la autocorrelación en
% el intervalo (-inf, inf). Por esta razón deberemos limitar mediante ventanas 
% el soporte de la señal. El ancho de las ventanas es muy dependiente de la 
% aplicación. En el caso de señales de voz se pueden utilizar ventanas de 10
% a 30 ms. Las ventanas deben tener variaciones suaves para no malcondicionar
% el sistema de ecuaciones. Se recomienda la utilización de ventanas como las
% de Hamming, Hanning o Blackman.

y = y.*hanning(N)';

% =========================================================================

% IDENTIFICACION DEL SISTEMA LTI

% Primero debemos determinar el orden del sistema. Se calcula la 
% autocorrelación de la señal y (la señal de salida)
rcomp = xcorr(y);
figure;
plot(rcomp);
title('Autocorrelacion');

% Nos quedamos con la mitad del vector de autocorrelacion
r = rcomp(ceil(length(rcomp)/2):length(rcomp));

% Se grafica el vector de autocorrelación.
figure;
plot(r);
title('Autocorrelacion positiva');
figure;
plot(r(1:100));
title('Autocorrelacion positiva (zoom)');


% Vector de predicción final
Vp = zeros(1,10);
% Vector de Akaike
Ip = zeros(1,10);

for p=1:10
    % Cálculo de coeficientes LPC. LPC calcula los coeficientes ak
    % resolviendo el sistema sistema de Wiener-Hopf.
    [a,Ep2] = lpc(y,p);
    % Nos quedamos con la parte real del coeficiente en el caso de que sea
    % complejo.
    a = real(a);
    % Calculamos el error de predicción final. Según matlab: Ep=sqrt(Ep2)
    Ep=r(1)+r(2:p+1)*a(2:p+1)';
    % Se normaliza el valor obtenido y se almacena en el vector de
    % predicción final.
    Vp(p)=Ep/r(1);
    % Calculamos el error para el caso de Akaike y almacenamos.
    Ip(p)=log(Ep)+2*p/(0.4*length(x));
end
% =========================================================================

% Se grafican las funciones de error
figure;
subplot(1,2,1);
plot(Vp);
grid on;
title('Error de prediccion Vp');
xlabel('orden');
subplot(1,2,2);
plot(Ip);
grid on;
title('Error segun criterio de Akaike');
xlabel('orden');

%% Ejercicio 2: Considere el sistema
% La señal de electroencefalograma se puede modelar mediante un sistema AR 
% de orden 40 a 80. Identifique el sistema que generó la señal almacenada
% en el archivo eeg.txt y compare la respuesta en frecuencia de este
% sistema con el espectro de la señal.

clear all;
close all;
clc
y  = load('eeg.txt');
fm = 250;
N  = length(y);
t  = (0:N-1)*1/fm;
x = randn(1,N);

% =========================================================================
% Ventanear con Hanning
y = y.*hanning(N);

% IDENTIFICACION DEL SISTEMA LTI
% Calculo la autocorrelación
rcomp = xcorr(y);
% Nos quedamos con la mitad del vector de autocorrelacion
r = rcomp(ceil(length(rcomp)/2):length(rcomp));
% Vector de predicción final
Vp = zeros(1,80);
% Vector de Akaike
Ip = zeros(1,80);
for p=1:80
    % Cálculo de coeficientes LPC. LPC calcula los coeficientes ak
    % resolviendo el sistema sistema de Wiener-Hopf.
    [a,Ep2] = lpc(y,p);
    % Nos quedamos con la parte real del coeficiente en el caso de que sea
    % complejo.
    a = real(a);
    % Calculamos el error de predicción final. Según matlab: Ep=sqrt(Ep2)
    Ep=r(1)+r(2:p+1)*a(2:p+1)';
    % Se normaliza el valor obtenido y se almacena en el vector de
    % predicción final.
    Vp(p)=Ep/r(1);
    % Calculamos el error para el caso de Akaike y almacenamos.
    Ip(p)=log(Ep)+2*p/(0.4*length(x));
end

% Se grafican las funciones de error
figure;
subplot(1,2,1);
plot(Vp);
grid on;
title('Error de prediccion Vp');
xlabel('orden');
subplot(1,2,2);
plot(Ip);
grid on;
title('Error segun criterio de Akaike');
xlabel('orden');