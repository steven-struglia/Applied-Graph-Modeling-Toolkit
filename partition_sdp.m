function [o_1, o_2] = partition_sdp(Y,n)
    [V, D] = eigs(Y); 
    [~, ind] = sort(diag(D));
    Vs = V(:,ind);
    evec = Vs(:,end);
    omega_1 = [];
    omega_2 = [];
    for i = 1:n
       if evec(i) > 0
          omega_1 = [omega_1,i]; 
       else
           omega_2 = [omega_2,i];
       end
    end
    o_1 = omega_1;
    o_2 = omega_2;
end

