%% Ejercicio 1
clear all % borra las variables
close all % cierra las ventanas
clc % limpia la consola

T = 0.001; % Per?odo de muestreo
t = 0:T:3-T;
f = 8; % Frecuencia

y_sen       = sin(2*pi*t*f) + 1;
y_square    = square(t*2*f);
y_aleatoria = rand(1,length(t));

%%%-------------------------------------------------------------------- %%%
y_sen_medio = mean(y_sen);
y_sen_max   = max(y_sen);
y_sen_min   = min(y_sen);

y_sen_amp     = max(abs(y_sen));
%y_sen_energ   = norm(y_sen)*norm(y_sen);
y_sen_energ   = power(norm(y_sen),2);
y_sen_acc     = sum(abs(y_sen));
y_sen_pot     = (1/(2*length(y_sen)) )* sum(power(abs(y_sen),2));
y_sen_rms     = sqrt(y_sen_pot);

disp(['Seno:'])
disp(['  - Media:' num2str(y_sen_medio)])
disp(['  - Max:' num2str(y_sen_max)])
disp(['  - Min:' num2str(y_sen_min)])
disp(['  - Amplitud:' num2str(y_sen_amp)])
disp(['  - Accion:' num2str(y_sen_acc)])
disp(['  - Energia:' num2str(y_sen_energ)])
disp(['  - Potencia:' num2str(y_sen_pot)])
disp(['  - RMS:' num2str(y_sen_rms)])
%%%-------------------------------------------------------------------- %%%
y_square_medio = mean(y_square);
y_square_max   = max(y_square);
y_square_min   = min(y_square);

y_square_amp     = max(abs(y_square));
%y_square_energ   = norm(y_square)*norm(y_square);
y_square_energ = power(norm(y_square),2);
y_square_acc     = sum(abs(y_square));
y_square_pot     = (1/length(y_square)) * sum(power(abs(y_square),2));
y_square_rms     = sqrt(y_square_pot);

disp(['Cuadrada:'])
disp(['  - Media:' num2str(y_square_medio)])
disp(['  - Max:' num2str(y_square_max)])
disp(['  - Min:' num2str(y_square_min)])
disp(['  - Amplitud:' num2str(y_square_amp)])
disp(['  - Accion:' num2str(y_square_acc)])
disp(['  - Energia:' num2str(y_square_energ)])
disp(['  - Potencia:' num2str(y_square_pot)])
disp(['  - RMS:' num2str(y_square_rms)])
%%%-------------------------------------------------------------------- %%%
y_aleatoria_medio = mean(y_aleatoria);
y_aleatoria_max   = max(y_aleatoria);
y_aleatoria_min   = min(y_aleatoria);

y_aleatoria_amp     = max(abs(y_aleatoria));
%y_aleatoria_energ   = norm(y_aleatoria)*norm(y_aleatoria);
y_aleatoria_energ   = power(norm(y_aleatoria),2);
y_aleatoria_acc     = sum(abs(y_aleatoria));
y_aleatoria_pot     = (1/length(y_aleatoria)) * sum(power(abs(y_aleatoria),2));
y_aleatoria_rms     = sqrt(y_aleatoria_pot);

disp(['Aleatoria:'])
disp(['  - Media:' num2str(y_aleatoria_medio)])
disp(['  - Max:' num2str(y_aleatoria_max)])
disp(['  - Min:' num2str(y_aleatoria_min)])
disp(['  - Amplitud:' num2str(y_aleatoria_amp)])
disp(['  - Accion:' num2str(y_aleatoria_acc)])
disp(['  - Energia:' num2str(y_aleatoria_energ)])
disp(['  - Potencia:' num2str(y_aleatoria_pot)])
disp(['  - RMS:' num2str(y_aleatoria_rms)])

%%%-------------------------------------------------------------------- %%%
figure;

subplot(3,1,1);
plot(t,y_sen);
grid on;
grid minor;
title('sin(t)','Interpreter','latex');
xlabel('t[s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');
ylim([-1 3 ]);

subplot(3,1,2);
plot(t,y_square);
grid on;
grid minor;
title('Cuadrada','Interpreter','latex');
xlabel('t[s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');
ylim([-2 2 ]);

subplot(3,1,3);
plot(t,y_aleatoria);
grid on;
grid minor;
title('Aleatoria','Interpreter','latex');
xlabel('t[s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');
ylim([-2 2 ]);

%% Ejercicio 2

clear all % borra las variables
close all % cierra las ventanas
clc % limpia la consola
f_1 = 3; % Frecuencia
f_2 = 3; % Frecuencia
A_1 = 3;
A_2 = 1;
Phi_1 = pi;
Phi_2 = pi/4
;

T = 0.001; % Per?odo de muestreo
t = 0:T:3-T;
alpha = 0.78;


x_sen1 = A_1*sin(2*pi*t*f_1+Phi_1);
x_sen2 = A_2*sin(2*pi*t*f_2+Phi_2);

figure;
% PLOT SENO
subplot(4,2,1);
plot(t,x_sen1);
title('$x_1(t)$','Interpreter','latex');
xlabel('t[s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');

subplot(4,2,2);
plot(t,x_sen2,'r');
title('$x_2(t)$','Interpreter','latex');
xlabel('t[s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');

subplot(4,2,3);
plot(t,x_sen1+x_sen2,'m');
title('$x_1+x_2(t)$','Interpreter','latex');
xlabel('t[s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');

subplot(4,2,4);

plot(t,x_sen1);
plot(t,alpha*(x_sen1+x_sen2),'m');
title('$\alpha(x_1+x_2)$','Interpreter','latex');
xlabel('t[s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');

subplot(4,2,5);
plot(t,alpha*x_sen1+alpha*x_sen2,'m');
title('$\alpha x_1+\alpha x_2(t)$','Interpreter','latex');
xlabel('t[s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');

subplot(4,2,6);
plot(t,x_sen1+zeros(1,length(x_sen1)),'m');
title('$x_1(t) + 0$','Interpreter','latex');
xlabel('t[s]','Interpreter','latex');
ylabel('Amplitud','Interpreter','latex');
