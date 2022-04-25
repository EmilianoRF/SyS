%% Ejercicio 1: Considere el sistema
% y[n] = 0,3y[n - 1] -0,4y[n - 2]+0,2y[n - 3]+ x[n] y genere una secuencia
% de salida a una entrada de tipo aleatoria con distribución uniforme y valor
% medio cero. Utilizando esta señal de salida implemente el método 
% de predicción lineal y verifique el comportamiento de los criterios
% para estimación del orden.
clear all; close all;

% =========================================
% Generar una seÃ±al aleatoria x
% frecuencia de muestreo: 10 kHz
% duracion: 1 s.
fm=10000;

t=0:1/fm:1-1/fm;
N=length(t);
% Señal aleatoria con distribución gausiana media 0 y desvio estandar 1
x=randn(1,N);

% otra opcion con distribucion uniforme entre -1 y 1
%x=-1+2*rand(1,N);

% =========================================
% Calcular la salida usando la ecuacion en recurrencia
y=zeros(1,N);
for k=1:N
    switch k
        case 1
            y(k)=x(k);
        case 2
            y(k)=x(k)+0.3*y(k-1);
        case 3
            y(k)=x(k)+0.3*y(k-1)-0.4*y(k-2);
        otherwise
            y(k)=x(k)+0.3*y(k-1)-0.4*y(k-2)+0.2*y(k-3);
    end
end
% Calcular la salida usando filter
num=1;
den=[1 -0.3 0.4 -0.2];
yf=filter(num,den,x);

% =========================================
% Ventanear con Hanning
% En las aplicaciones prácticas nunca podemos realizar la autocorrelación en
% el intervalo (-inf, inf). Por esta razón deberemos limitar mediante ventanas 
% el soporte de la señal. El ancho de las ventanas es muy dependiente de la 
% aplicación. En el caso de señales de voz se pueden utilizar ventanas de 10
% a 30 ms. Las ventanas deben tener variaciones suaves para no malcondicionar
% el sistema de ecuaciones. Se recomienda la utilización de ventanas como las
% de Hamming, Hanning o Blackman.
y=y.*hanning(N)';

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
subplot(1,2,2);
plot(Ip);
title('Error segun criterio de Akaike');
xlabel('orden');

%% Ejercicio 2:
% La señal de electroencefalograma se puede modelar mediante un sistema AR de
% orden 4 a 8. Identifique el sistema que generó la señal almacenada en el 
% archivo eeg.txt y compare la respuesta en frecuencia de este sistema con el
% espectro de la señal.
clear all;
close all;
clc
y=load('eeg.txt');% ver si es esta la señal del TP porque me da un orden optimo muy grande...
%y=y-mean(y); 
y=y/max(y);
fm=250;
N=length(y);
t=(0:N-1)*1/fm;
figure;
plot(t,y)
title('electroencefalograma')

ac=xcorr(y);
for orden=1:1000
    a=lpc(y,orden);
    %Ep=(ac(N)+dot(ac(N+1:N+orden),a(2:orden+1)))/norm(x,2)^2;
    Ep=(ac(N)+dot(ac(N+1:N+orden),a(2:orden+1)));   %Ep=ro+r'*a
    Vp(orden)=Ep/ac(N);                                         %Vp=Ep/ro
    Ip(orden)=log(Ep)+2*orden/(0.4*N);
end;

figure;
subplot(2,1,1);
plot(Vp);
title('FPE');
grid;
subplot(2,1,2);
plot(Ip);
title('Akaike');
grid;

p_optimo=find(Ip==min(Ip));
a=lpc(y,p_optimo);




figure;
freqz(1,a)
title('Respuesta en frecuencia del sistema aproximado normalizada ')

%----------------entrada------------------
x=randn(1,N);   
% otra opcion con distribucion uniforme entre -1 y 1
%x=-1+2*rand(1,N);
%x=[1 zeros(1,N-1)];% delta de dirac

Xzc=abs(fft(x));
Xz=Xzc(1:N/2+1);
F=0:fm/N:fm/2; %frecuencias en hz
figure
TFeegc=abs(fft(y))
TFeeg=TFeegc(1:N/2+1);
plot(F,20*log10(TFeeg));
title('Transformada de fourier del EEG')
xlabel('[Hz]')
ylabel('[dB]')

figure;
subplot(311)
plot(F,Xz)
title('Respuesta en frecuenca de la entrada x')

subplot(312)
Hzc=freqz(1,a,N,'whole',fm);
Hz=Hzc(1:N/2+1);
plot(F,20*log10(Hz))
ylabel('[dB]')
title('Respuesta en frecuenca del sistema aproximado')



subplot(313)
y=filter(1,a,x);
Yzc=abs(fft(y));
Yz=Yzc(1:N/2+1);
plot(F,20*log10(Yz));
title('Respuesta en frecuenca de la salida aproximada')
