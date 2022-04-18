%Ejercicio 1: es para hacer en papel.x[n],y[n]-->H(Z)
%% Ejercicio 2: 
%Encuentre la repuesta en frecuencia de los sistemas anteriores
%suponiendo una frecuencia demuestreo de 10KHz.
% Para encontar la respuesta en frecuencia se pueden utlizar tres metodos:
% a) Evaluar  H(Z) en el circulo unitario haciendo z=exp(j*tita). con tita
% de [0 pi) parte positiva 
% b) Utilizar la funcion freqz() que  hace lo anterior automaticamente.  
% c) Calcular la respuesta al impulso h[t] y luego la fft(h) es la Hz

% a) Evaluar  H(Z) en el circulo unitario haciendo z=exp(j*tita). con tita
% de [0 pi) parte positiva o [0 2pi) parte positiva y negativa
clear all;close all;
% y(n)-1/2*y(n-1)+1/4*y(n-2)=x(n)+x(n-1)
% H(z)=(1+z^-1)/(1-1/2*z^-1+1/4*z^-2)
fm=10000 %frecuencia de muestreo


tita=0:pi/512:pi;

z=exp(j*tita);
hz= (1 + z.^(-1))./( 1 - 1/2.*z.^(-1) + 1/4.*z.^(-2));
hz_M=abs(hz);
hz_magn=20.*log10(hz_M);
f=tita.*fm./(2*pi);
figure('name','Mapeando H(z) en el semicirulo superior')
plot(f,hz_magn)
xlabel('Frecuencia(Hz)')
ylabel('Magnitud (dB)')
grid on


% b) Utilizar la funcion freqz() que  hace lo anterior automaticamente.  
b=[1 1]; %coeficientes numerador
a=[1 -1/2 1/4];%coeficientes denominador
%freqz() evalua la H(Z) en la mitad superior del circulo unitario con N
%puntos(si no se especifica toma 512)
figure('name','Con freqz()')
freqz(b,a,512,fm)%Magnitud de H(z)
%freqz(b,a,512)%sin colocar la frecuencia de muestreo me muestra un grafico normalizado


%c) Calcular la respuesta al impulso h[t] y luego la fft(h) es la Hz
h=filter(b,a,[1 zeros(1,1023)])
Hcomp=abs(fft(h));
H=Hcomp(1:513);
Hdb=20.*log10(H);
figure('name','con fft(h)')
plot(f,Hdb);
grid on



%% Ejercicio 3:
%Considere el sistema H(z) =...(usamos el sistema del ej 1)
           %H(z)=(1+z^-1)/(1-1/2*z^-1+1/4*z^-2)
% a)Dibuje el diagrama de polos y ceros. ¿Es estable el sistema?
b=[1 1]; %coeficientes numerador
a=[1 -1/2 1/4];%coeficientes denominador

% % %---------------la misma grafica del circulo pero con zplane----------
figure('name','ceros y polos de H(z) con zplane')
zplane(b,a)

%%
%--------todo lo anterior se puede hacer con fvtool---------
clear all;close all;
b=[1 1]; %coeficientes numerador
a=[1 -1/2 1/4];%coeficientes denominador
fvtool(b,a);
%--------para el diseño de filtros se usa fdatool-----------
%%
close all
num=[0 1 ];
den=[1.25 1 6];

figure('name','Respuesta en Frecuencia del Sistema Analógico');
freqs(num,den,0:0.001:10)% Grafica de 0.1 a 10 rad/s

%sistema digital
fm=100; %frecuencia de muestreo en hz.
%bilineal
[bb aa]=bilinear(num,den,fm);
f_s=0:0.01:100;%Rango de frecuencias en hz
%La funcion freqs toma el vector de frecuencias en radianes
H_s =freqs(num,den,2*pi*f_s);% Grafica de 0.1 a 100 rad/s

figure('name','sistema digital con transformacion Bilineal');
%La funcion freqz toma el vector de frecuencias en hz.
H_z=freqz(bb,aa,f_s,fm);

k = 1.25*fm^2;
num_euler=[1 0];
den_euler=[6+k+fm -2*k-fm k];

h_euler = freqz(num_euler,den_euler,f_s,fm);

semilogx(f_s,20*log10(abs(H_z)));hold on
semilogx(f_s,20*log10(abs(H_s)),'r--');hold on
semilogx(f_s,20*log10(abs(H_s)),'r--')
semilogx(f_s,20*log10(abs(h_euler)),'g--')
legend('bilineal','analógica','euler')
grid; 





