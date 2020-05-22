function [prob_vec,cliques] = estimate_p_4_clique(m,n)
    p = zeros(1,m);
    c = zeros(1,m);
    % Iterate over number of included edges in p estimation and exp.
    % 4-cliques
    for k = 1:m
       p(k) = (2*k)/(n*(n-1));
    end
    for k = 1:m
       c(k) = nchoosek(n,4)*(2*k/(n*(n-1)))^6; 
    end
    cliques = c;
    prob_vec = p;
end

