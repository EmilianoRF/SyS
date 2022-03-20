%% Ejercicio 1
clear all % borra las variables
close all % cierra las ventanas
clc % limpia la consola

T = 0.01; % Período de muestreo
t = -1:T:1-T;
f = 3; % Frecuencia

% Arreglos de valores
y_sin           = sin(2*pi*f*t);
y_sinc          = sinc(2*pi*f*t);
y_square        = square(t*2*f);
y_dirac         = zeros(1,length(t));
y_dirac(t==0)   = 1;
y_ruido         = rand(1,length(t));

figure;

% PLOT SENO
subplot(2,3,1);
plot(t,y_sin,'LineWidth', 1.5);
title('Sen(t)','Interpreter','latex');
xlabel('t[s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');
ylim([-2 2 ]);


% PLOT SENC
subplot(2,3,2);
plot(t,y_sinc,'LineWidth', 1.5);
title('Senc(t)','Interpreter','latex');
xlabel('t[s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');
ylim([-2 2 ]);

% PLOT CUADRADA
subplot(2,3,3);
plot(t,y_square,'LineWidth', 1.5);
title('Cuadrada','Interpreter','latex');
xlabel('t[s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');
ylim([-2 2 ]);

% PLOT DIRAC
subplot(2,3,4);
plot(t,y_dirac,'LineWidth', 1.5);
title('Dirac','Interpreter','latex');
xlabel('t[s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');
ylim([-2 2 ]);

% PLOT RUIDO
subplot(2,3,5);
plot(t,y_ruido,'LineWidth', 1.5);
title('Ruido','Interpreter','latex');
xlabel('t[s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');
ylim([-2 2 ]);

%% Ejercicio 3  
clear all
close all 
clc

f = 5; % Frecuencia

T = 0.001; % Período de muestreo función a estudiar
t = 0:T:1-T;
y_sen = sin(2*pi*f*t)


% PARA f = 1 kHz
t_f1 = 0:1/1000:1-1/1000;
y_f1 = sin(2*pi*f*t_f1);
% PARA f = 100 Hz
t_f2 = 0:1/100:1-1/100;
y_f2 = sin(2*pi*f*t_f2);
% PARA f = 25 Hz
t_f3 = 0:1/25:1-1/25;
y_f3 = sin(2*pi*f*t_f3);
% PARA f = 10 Hz
t_f4 = 0:0.1:1-1/10;
y_f4 = sin(2*pi*f*t_f4);
% PARA f = 4 Hz
t_f5 = 0:0.25:1-1/4;
y_f5 = sin(2*pi*f*t_f5);
% PARA f = 1 Hz
t_f6 = 0:1/1:1;
y_f6 = sin(2*pi*f*t_f6);
% PARA f = 0.5 Hz
t_f7 = 0:1/0.5:1-1/0.5;
y_f7 = sin(2*pi*f*t_f7);


% PLOT 1
subplot(4,2,1);
plot(t,y_sen);
title('Senal a muestrear: $f= 5$Hz','Interpreter','latex');
xlabel('t[s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');

% PLOT 1
subplot(4,2,2);
plot(t,y_sen);
hold on;
stem(t_f1,y_f1,'r*');
plot(t_f1,y_f1,'r');
title('Muestreo a 1 kHz','Interpreter','latex');
xlabel('t[s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');

% PLOT 2
subplot(4,2,3);
plot(t,y_sen);
hold on;
stem(t_f2,y_f2,'r*');
plot(t_f2,y_f2,'r');
title('Muestreo a 100 Hz','Interpreter','latex');
xlabel('t[s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');

% PLOT 3
subplot(4,2,4);
plot(t,y_sen);
hold on;
stem(t_f3,y_f3,'r*');
plot(t_f3,y_f3,'r');
title('Muestreo a 25 Hz','Interpreter','latex');
xlabel('t[s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');

% PLOT 4
subplot(4,2,5);
plot(t,y_sen);
hold on;
stem(t_f4,y_f4,'r*');
title('Muestreo a 10 Hz','Interpreter','latex');
xlabel('t[s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');

% PLOT 5
subplot(4,2,6);
plot(t,y_sen);
hold on;
stem(t_f5,y_f5,'r*');
plot(t_f5,y_f5,'r');
title('Muestreo a 4 Hz','Interpreter','latex');
xlabel('t[s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');


% PLOT 6
subplot(4,2,7);
plot(t,y_sen);
hold on;
stem(t_f6,y_f6,'r*');
plot(t_f6,y_f6,'r');
title('Muestreo a 1 Hz','Interpreter','latex');
xlabel('t[s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');

% PLOT 7
subplot(4,2,8);
plot(t,y_sen);
hold on;
stem(t_f7,y_f7,'r*');
plot(t_f7,y_f7,'r');
title('Muestreo a 0.5 Hz','Interpreter','latex');
xlabel('t[s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');


%% Ejercicio 4

clear all
close all 
clc
figure;

T = 0.000001;
t = 0:T:2;
f_s = 4000;

t_m = 0:1/129:2;


y_s = sin(2*pi*f_s*t);
y_m = sin(2*pi*f_s*t_m);

subplot(211);
plot(t,y_s,'LineWidth', 1.5);
xlim([0 1/4000]);
title('Senal a muestrear: $f= 4$kHz','Interpreter','latex');
xlabel('t[s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');

subplot(212);
plot(t_m,y_m,'LineWidth', 1.5);
xlim([0 1]);
title('Senal muestreada a $f=129$Hz','Interpreter','latex');
xlabel('t[s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');


%% Ejercicio 6

clear all
close all 
clc
figure;

T = 0.001;
t = 0:T:6*pi;
f_z = exp(1i*t);
real_fz = real(f_z);
img_fz = imag(f_z);

plot3(real_fz,img_fz,t);
axis equal;
grid;
xlabel('Re[$f(z(t))$]','Interpreter','latex');
ylabel('Im[$f(z(t))$]','Interpreter','latex');
zlabel('$t$','Interpreter','latex');

%% Ejercicio 7
clear all
close all 
clc
figure;

f = 5; % Frecuencia

T = 0.001; % Período de muestreo función a estudiar
t = -1:T:1-T;
y_aleatoria = randn(1,length(t));

subplot(211);
plot(t,y_aleatoria,'r');
title('Ruido','Interpreter','latex');
xlabel('t[s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');

subplot(212);
histogram(y_aleatoria);
title('Distribucion de probabilidad','Interpreter','latex');

