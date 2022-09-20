%% Act 1
clear all;
clear clc;

nacimiento = 19961105;
factor = 6000;

f1 = nacimiento/factor;

fm = 8000;

t=0:1/fm:1-1/fm;

y = chirp(t,0,1,f1,'linear');

%soundsc(y,f1);

spectrogram(y,512,500,512,fm,'yaxis')

%% Act 1
clear all;
close all;
clc;

nacimiento = 19961105;
factor = 6000;

f1 = nacimiento/factor;

% Implementacion de la funcion chirp

fm = 45000;
t = 0:1/fm:1-1/fm;
f1 = 15000;
b=0;
m=f1;

x=zeros(1,length(t));
theta= zeros(1,length(t));

for k=1:length(t)
    theta(k)= 2*pi*((m*t(k)^2)/2 + t(k)*b);
    x(k) = sin(theta(k));
end

soundsc(x,fm);
spectrogram(x,512,500,512,fm,'yaxis')



