%% Ejercicio 1: Considere el sistema
% y[n] = 0,3y[n - 1] -0,4y[n - 2]+0,2y[n - 3]+ x[n] y genere una secuencia
% de salida a una entrada de tipo aleatoria con distribuci�n uniforme y valor
% medio cero. Utilizando esta se�al de salida implemente el m�todo 
% de predicci�n lineal y verifique el comportamiento de los criterios
% para estimaci�n del orden.
clear all; close all;

% =========================================
% Generar una se�al aleatoria x
% frecuencia de muestreo: 10 kHz
% duracion: 1 s.
fm = 10000;
t = 0:1/fm:1-1/fm;
N = length(t);
% Se�al aleatoria con distribuci�n gausiana media 0 y desvio estandar 1
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

% En las aplicaciones pr�cticas nunca podemos realizar la autocorrelaci�n en
% el intervalo (-inf, inf). Por esta raz�n deberemos limitar mediante ventanas 
% el soporte de la se�al. El ancho de las ventanas es muy dependiente de la 
% aplicaci�n. En el caso de se�ales de voz se pueden utilizar ventanas de 10
% a 30 ms. Las ventanas deben tener variaciones suaves para no malcondicionar
% el sistema de ecuaciones. Se recomienda la utilizaci�n de ventanas como las
% de Hamming, Hanning o Blackman.

y = y.*hanning(N)';

% =========================================================================

% IDENTIFICACION DEL SISTEMA LTI

% Primero debemos determinar el orden del sistema. Se calcula la 
% autocorrelaci�n de la se�al y (la se�al de salida)
rcomp = xcorr(y);
figure;
plot(rcomp);
title('Autocorrelacion');

% Nos quedamos con la mitad del vector de autocorrelacion
r = rcomp(ceil(length(rcomp)/2):length(rcomp));

% Se grafica el vector de autocorrelaci�n.
figure;
plot(r);
title('Autocorrelacion positiva');
figure;
plot(r(1:100));
title('Autocorrelacion positiva (zoom)');


% Vector de predicci�n final
Vp = zeros(1,10);
% Vector de Akaike
Ip = zeros(1,10);

for p=1:10
    % C�lculo de coeficientes LPC. LPC calcula los coeficientes ak
    % resolviendo el sistema sistema de Wiener-Hopf.
    [a,Ep2] = lpc(y,p);
    % Nos quedamos con la parte real del coeficiente en el caso de que sea
    % complejo.
    a = real(a);
    % Calculamos el error de predicci�n final. Seg�n matlab: Ep=sqrt(Ep2)
    Ep=r(1)+r(2:p+1)*a(2:p+1)';
    % Se normaliza el valor obtenido y se almacena en el vector de
    % predicci�n final.
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
% La se�al de electroencefalograma se puede modelar mediante un sistema AR 
% de orden 40 a 80. Identifique el sistema que gener� la se�al almacenada
% en el archivo eeg.txt y compare la respuesta en frecuencia de este
% sistema con el espectro de la se�al.

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
% Calculo la autocorrelaci�n
rcomp = xcorr(y);
% Nos quedamos con la mitad del vector de autocorrelacion
r = rcomp(ceil(length(rcomp)/2):length(rcomp));
% Vector de predicci�n final
Vp = zeros(1,80);
% Vector de Akaike
Ip = zeros(1,80);
for p=1:80
    % C�lculo de coeficientes LPC. LPC calcula los coeficientes ak
    % resolviendo el sistema sistema de Wiener-Hopf.
    [a,Ep2] = lpc(y,p);
    % Nos quedamos con la parte real del coeficiente en el caso de que sea
    % complejo.
    a = real(a);
    % Calculamos el error de predicci�n final. Seg�n matlab: Ep=sqrt(Ep2)
    Ep=r(1)+r(2:p+1)*a(2:p+1)';
    % Se normaliza el valor obtenido y se almacena en el vector de
    % predicci�n final.
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