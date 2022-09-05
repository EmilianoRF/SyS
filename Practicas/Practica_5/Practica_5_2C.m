%% SISTEMAS LTI
clear all % borra las variables
close all % cierra las ventanas
clc % limpia la consola


% y[n] = y[n-2] + x[n]
% y[n-2] = y[n-1] = 0
delta    = zeros(1,100);
delta(1) = 1;
a = [1,0,-1];
b = [1,0];
% Se encuentra la salida a partir de la entrada
% x[n]
for n = 1:100
    if n == 1
        y(n) = delta(n) ;
    elseif n == 2
        y(n) = delta(n) ;
    else
        y(n) = y(n-2) + delta(n);
    end
end
% Se hace lo mismo pero con la función filter
% y = filter =(coeficientes de x, coeficientes de y, vector x)
y_ = filter(b,a,delta);

figure
subplot(3,1,1)
stem(delta)
title('$\delta$[n]','Interpreter','latex');
xlabel('N','Interpreter','latex');
ylim([-0.5 2 ]);
subplot(3,1,2)
stem(y)
title('y[n]','Interpreter','latex');
xlabel('N','Interpreter','latex');
ylim([-0.5 2 ]);
subplot(3,1,3)
stem(y_)
title('y[n] filter','Interpreter','latex');
xlabel('N','Interpreter','latex');
ylim([-0.5 2 ]);


%% CONVOLUCIÓN
clear all % borra las variables
close all % cierra las ventanas
clc % limpia la consola

% 6y[n]?4y[n?1]+5y[n?2] = x[n] ? 2x[n ? 1] + x[n ? 2]

escalon    = ones(1,100);
delta      = zeros(1,100);
delta(1)   = 1;

b = [1,-2,1];
a = [6,-4,5];
% Se hace lo mismo pero con la función filter
% y = filter =(coeficientes de x, coeficientes de y, vector x)
y_filter          = filter(b,a,escalon);
respuesta_impulso = filter(b,a,delta);
y_conv            = conv(escalon,respuesta_impulso);

figure
subplot(4,1,1)
stem(escalon)
title('Escalon $H[n]$','Interpreter','latex');
xlabel('N','Interpreter','latex');
ylim([-2 2 ]);
subplot(4,1,2)
stem(respuesta_impulso)
title('Respuesta al impulso $h[n]$','Interpreter','latex');
xlabel('N','Interpreter','latex');
ylim([-0.3 0.3 ]);

subplot(4,1,3)
stem(y_filter)
title('$y[n]$ Filter','Interpreter','latex');
xlabel('N','Interpreter','latex');
ylim([-0.3 0.3 ]);

subplot(4,1,4)
stem(y_conv)
title('$y[n]$ Convolucion','Interpreter','latex');
xlabel('N','Interpreter','latex');
ylim([-0.3 0.3 ]);


        
    
    