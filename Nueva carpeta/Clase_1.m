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
plot(t,y_sin);
title('Sen(t)','Interpreter','latex');
xlabel('t[s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');
ylim([-2 2 ]);


% PLOT SENC
subplot(2,3,2);
plot(t,y_sinc);
title('Senc(t)','Interpreter','latex');
xlabel('t[s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');
ylim([-2 2 ]);

% PLOT CUADRADA
subplot(2,3,3);
plot(t,y_square);
title('Cuadrada','Interpreter','latex');
xlabel('t[s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');
ylim([-2 2 ]);

% PLOT DIRAC
subplot(2,3,4);
plot(t,y_dirac);
title('Dirac','Interpreter','latex');
xlabel('t[s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');
ylim([-2 2 ]);

% PLOT RUIDO
subplot(2,3,5);
plot(t,y_ruido);
title('Ruido','Interpreter','latex');
xlabel('t[s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');
ylim([-2 2 ]);

%% Ejercicio 3  
clear all
close all 
clc

f = 5; % Frecuencia

T = 0.01; % Período de muestreo función a estudiar
t = 0:T:1-T;
y_sen = sin(2*pi*f*t)


subplot(4,4,1);

plot(t,y_sen);


% PARA f = 1 kHz
T = 1/1000;
t = 0:T:1-T;
y_f1 = sin(2*pi*f*t)
subplot(4,4,2);
plot(t,y_f1);



% PARA f = 100 Hz
T = 1/100;
t = 0:T:1-T;
subplot(4,4,3);
y_f2 = sin(2*pi*f*t)

plot(t,y_f2);

% PARA f = 25 Hz
T = 1/25;
t = 0:T:1-T;
y_f3 = sin(2*pi*f*t)
subplot(4,4,4);
plot(t,y_sen);
hold on;
plot(t,y_f3);

% PARA f = 4 Hz
T = 1/4;
t = 0:T:1-T;
y_f4 = sin(2*pi*f*t)
subplot(4,4,5);
plot(t,y_f4);

% PARA f = 1 Hz
T = 1/1;
t = 0:T:1-T;
y_f5 = sin(2*pi*f*t)
subplot(4,4,6);
plot(t,y_f5);
% PARA f = 0.5 Hz
T = 1/0.5;
t = 0:T:1-T;
y_f6 = sin(2*pi*f*t)
subplot(4,4,7);
plot(t,y_f6);



%% Ejercicio 3

clear all
close all 
clc