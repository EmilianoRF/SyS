
function [ synt_speech_CELP ] = CELP( new_speech )
frame_length=240; % Largo de la ventana LPC
frame_shift=80; % Se obtiene de multiplicar (Fs*solapamiento) 8000*0.01
codebook_size = 512; % Número de vectores del codebook
N_components= 10; % Número de componentes del codebook por ventana
filt_synt=zeros(10,1); % Filtro de sintesis 1/A(z)
synt_speech_CELP=[]; % Arreglo para almacenar las ventanas sintetizadas
codebook = randn(frame_shift,codebook_size); % Generación del codebook 

for i=1:(length(new_speech)-frame_length+frame_shift)/frame_shift;

 input_frame=new_speech((i-1)*frame_shift+1:(i-1)*frame_shift+frame_length);
 % Análisis LPC orden 10
 ai = lpc(input_frame.*hamming(frame_length), 10);
 % Se extraen las muestras 'frame_shift' desde el análisis de la ventana LPC
 speech_frame = input_frame((frame_length-frame_shift)/2+1:...
     (frame_length-frame_shift)/2+frame_shift);
 % Se filtra el codebook
 codebook_filt = filter(1, ai, codebook);
 % Se busca fragmentos del habla en el codebook y se los guarda
 ringing = filter(1, ai, zeros(frame_shift,1), filt_synt);
 % El ringin es una señal que se obtiene de considerar las condiciones 
 % iniciales del frame anterior, por eso a cada frame se le resta
 % esta señal. Es decir s_n = speech_frame - ringing
 signal = speech_frame - ringing;
 [gains, indices] = find_Nbest_components(signal, ...
 codebook_filt, N_components);
 % Se genera la excitación como una suma ponderada de los vectores del
 % codebook
 excitation = codebook(:,indices)*gains;
 % Se sintetiza el habla CELP, manteniendo el registro de las variables
 % de sintesis internas
 [synt_frame, filt_synt] = filter(1, ai, excitation, filt_synt);
 synt_speech_CELP=[synt_speech_CELP;synt_frame];

end 


end