%En este metodo la excitacion es de prediccion lineal excitada por codigo
%(CELP), se obtiene mediante la seleccion de la mejor combinacion lineal de
%componentes de excitacion de un codebook. La seleccion de componentes se
%realiza a bucle cerrado para minimizar la diferencia entre las señales
%sintetizadas y las originales.

%El metodo consiste en pasar el codebook por el filtro de sintesis para
%cada ventana buscando la mejior descomposicion lineal de la ventana de voz
%en terminos de secuencias filtradas del codebook.

%El habla sintetizada es mas natural que en LPC10, las voces estan mejor
%representadas y los sonidos vocales ya no suenan como zumbidos.
close all;
clear all;
clc;

%Carga de audio original
[audio,Fm] = audioread('aaaPatologico_Mujer.wav');
% Normalizo el audio
audio = audio./(max(audio)); 
audio = resample(audio,8000,Fm); 
audio = audio - mean(audio); 
Fs = 8000;

%Audio sintetizado (cambiar el audio cargado y el nombre del audio de salida para cada original)
synth_speechCELP = CELP(audio);
audiowrite('CELPPatologico_Mujer_test.wav',synth_speechCELP,8000);
