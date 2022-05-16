clear all;
close all;
clc;
%% Acondicionamiento 

%Cargar en la computadora las señales de voz 
[audio,Fm] = audioread('aaa_Patologico_Hombre.wav');

% Paso de stereo a monocanal
audio = audio (:,1);

% Normalizo el audio
audio = audio./(max(abs(audio))); 
audio = resample(audio,8000,Fm); 
audio = audio - mean(audio); 
Fm = 8000;

%% Identificacion del sistema 

cant_ventanas=floor(length(audio)/(Fm*0.02*0.5)); %floor devuelve un entero
orden=10;
long_ventana=Fm*0.02; %Longitud de cada ventana
ai = zeros(cant_ventanas,orden+1); %Matriz de coeficientes de cant_ventanas x orden+1
sigma = zeros(cant_ventanas,1); %Vector de errores
f0 = zeros(cant_ventanas,1); %Vector de frecuencias fundamentales
Pulsos_glot = zeros(cant_ventanas,long_ventana); %Matriz de pulsos gloticos de la cantidad de ventanas x el tamaño de c/u
gain=zeros(cant_ventanas,1);

[ai(1,:),sigma(1)] = LPC10(audio(1:long_ventana)); 
f0(1)=autocorrelacion_fo(audio(1:long_ventana),Fm); 
Pulsos_glot(1,:)=pulsos_gloticos(f0(1),Fm,long_ventana);
gain(1)=((sigma(1))/sqrt(1/(Fm/f0(1))));

%Calculo coeficientes, error y frec fundamental para cada ventana de 20ms 
for j = 2:cant_ventanas-1
    [ai(j,:),sigma(j)]=LPC10(audio(long_ventana*0.5*(j-1):(long_ventana*0.5*(j-1))+long_ventana)); %Solapamiento de 10ms (tamaño de la ventana por 0.5)
    f0(j)=autocorrelacion_fo(audio(long_ventana*0.5*(j-1):(long_ventana*0.5*(j-1))+long_ventana),Fm);
    Pulsos_glot(j,:)=pulsos_gloticos(f0(j),Fm,long_ventana);
    gain(j)=((sigma(j))/sqrt(1/(Fm/f0(j))));

end

%Decodificacion AUTOCORRELACIÓN
senal_deco=0;

for j=1:floor(length(audio)/long_ventana) 
    aux= filter(gain(j),ai(j,:),Pulsos_glot(j,:)); %Utilizo filter para el suvizado de los datos
    senal_deco=[senal_deco aux]; %Concateno al final lo obtenido de cada ventana
end

senal_deco=senal_deco';


audiowrite('AudioLPC10Patologico_Hombre.wav',senal_deco,8000);

% audiowrite('AudioAutocorrPATOLOGICO.wav',senal_deco,8000);
% 
% audiowrite('AudioCepstrumPATOLOGICO.wav',senal_deco_CEPS,8000);
