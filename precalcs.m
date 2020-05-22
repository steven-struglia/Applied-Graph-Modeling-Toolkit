clear
% Skip first line to get to data
f = fopen('WeightMatrixForImage2Noisy.dat.txt','r');
fgetl(f);
% Read in all data from matrix
data = fscanf(f, "%f");
fclose(f);
n = 1024;
% Take first [1:n^2] subset of data to store first matrix
weight_vector = data(1:(n*n));
% Reshape [n^2 x 1] vector into [n x n] matrix
weight_matrix = reshape(weight_vector, n, n);


D = diag(weight_matrix*ones(n,1));
L = D - weight_matrix;

%Calculate D^(-1/2)
dinv = zeros(n,1);
for i = 1:n
    if(D(i,i) > 0)
       dinv(i) = 1/sqrt(D(i,i)); 
    end
end
norm_L = diag(dinv)*L*diag(dinv);
% Spectral Algorithms

% Spectral method using weight matrix W in R [n x n]
[V, D] = eigs(weight_matrix); 
[~, ind] = sort(diag(D));
Vs = V(:,ind);
w_partition_vector = Vs(:,end-1);
weight_partition_omega_1 = [];
weight_partition_omega_2 = [];
for i = 1:n
    if w_partition_vector(i) > 0
        weight_partition_omega_1 = [weight_partition_omega_1,i];
    else if w_partition_vector(i) <= 0
            weight_partition_omega_2 = [weight_partition_omega_2,i];
    end
    end
end
disp(weight_partition_omega_1)
disp(weight_partition_omega_2)
% Spectral method using weighted laplacian matrix ? ? R [n x n]
[V,~] = eigs(L, 2, 'smallestabs');
L_partition_vector = V(:,2);
L_partition_omega_1 = [];
L_partition_omega_2 = [];
for i = 1:n
    if L_partition_vector(i) > 0
        L_partition_omega_1 = [L_partition_omega_1,i];
    else if L_partition_vector(i) <= 0
            L_partition_omega_2 = [L_partition_omega_2,i];
    end
    end
end
disp(L_partition_omega_1) 
disp(L_partition_omega_2)

% Spectral method using weighted normalized laplacian matrix ?? ? R [n x n]
[V,~] = eigs(norm_L, 2, 'smallestabs');
norm_L_partition_vector = V(:,2);
norm_L_partition_omega_1 = [];
norm_L_partition_omega_2 = [];
for i = 1:n
    if norm_L_partition_vector(i) > 0
        norm_L_partition_omega_1 = [norm_L_partition_omega_1,i];
    else if norm_L_partition_vector(i) <= 0
            norm_L_partition_omega_2 = [norm_L_partition_omega_2,i];
    end
    end
end
disp(norm_L_partition_omega_1)
disp(norm_L_partition_omega_2)

% SDP algorithms
Y_matrix_weight = sdp_W(weight_matrix, n);
Y_matrix_laplace = sdp_W_min(L, n);
Y_matrix_normal = sdp_W_min(norm_L, n);

% SDP partitions
[weight_omega_1, weight_omega_2] = partition_sdp(Y_matrix_weight, n);
disp(weight_omega_1)
disp(weight_omega_2)
[laplace_omega_1, laplace_omega_2] = partition_sdp(Y_matrix_laplace, n);
disp(laplace_omega_1)
disp(laplace_omega_2)
[normal_omega_1, normal_omega_2] = partition_sdp(Y_matrix_normal, n);
disp(normal_omega_1)
disp(normal_omega_2)
save('resultsSDP.mat')





