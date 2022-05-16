%%Esta funcion encuentra los N mejores componentes de la señal a partir de
%%los vectores del codebook, de modo que el error residual se minimiza. 

function [gains, indices] = find_Nbest_components(signal,codebook_vectors, N)

[M, L] = size(codebook_vectors);

for j = 1:L
codebook_norms(j) = norm(codebook_vectors(:,j));
end

gains = zeros(N,1);
indices = ones(N,1);

for k = 1:N
    max_norm = 0;
    for j = 1:L
        beta = codebook_vectors(:,j)'*signal;
        if codebook_norms(j) ~= 0
            component_norm = abs(beta)/codebook_norms(j);
        else
            component_norm = 0;
        end
        
    if component_norm>max_norm
        gains(k) = beta/(codebook_norms(j)^2);
        indices(k) = j;
        max_norm = component_norm ;
    end
    end
    
    signal = signal - gains(k)*codebook_vectors(:,indices(k));

end