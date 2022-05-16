function [pulsos_gloticos] = pulsos_gloticos(Fo,Fm,len)
%Pulsos gloticos es la señal de -excitacion-.
%vector de pulsos gloticos del habla sonora (vocales) en funcion de Fo Fm y la longitud de la ventana
pulsos_gloticos = zeros(len,1); %vector de tantos ceros como elementos de la ventana de 20ms 
paso   =  floor((1/Fo)/(1/Fm)); %floor redondea al entero mas cercano. La separacion de los pulsos gloticos esta dada por el periodo fundamental.

for k=1:paso:length(pulsos_gloticos) %for de 1 a la cantidad de elementos de la ventana por incrementos de paso
    pulsos_gloticos(k) = 1; %Amplitud=1
end