function [fo] = autocorrelacion_fo(audio,Fm)
%Determina la frecuencia fundamental mediante el metodo de autocorrelacion.
%Si la señal es periodica la autocorr muestra un pico en el periodo. 
audio_ventaneado = hamming(length(audio)).*audio;
%audio_aux = bandpass(audio_ventaneado,[60 350],Fm,6); %tomamos el rango de frecuencias de interes 
autocor = xcorr(audio_ventaneado,'unbiased'); %autocorrelacion "unbiased" calcula la autocorr sin sesgo

umbral = abs(max(autocor))*0.4; %Clipping 
for j=1:length(autocor)
    if autocor(j)< umbral
        autocor(j) = 0;
    end
end

%determinar To
[picos,valor] = findpeaks(autocor);

fo = (Fm/(valor(2)-valor(1)));

end