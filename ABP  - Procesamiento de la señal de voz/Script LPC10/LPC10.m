function [ai,sigma] = LPC10(audio);
%devuelve vector de coeficientes para el vector audio
audio_ventaneado = hamming(length(audio)).*audio;
[ai, sigma_square] = lpc(audio_ventaneado,10); %
sigma = sqrt(sigma_square); %
