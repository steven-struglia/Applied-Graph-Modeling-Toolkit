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
count = 1;
edge_list = zeros(n,3);
triu_weight = triu(weight_matrix);
% Create weighted edge list of graph
for i = 1:1024
   for j = 1:1024
      if triu_weight(i,j) > 0
          edge_list(count,:) = [triu_weight(i,j), i, j];
          count = count + 1;
      end
   end
end
edge_list = sortrows(edge_list, 'descend');
% Estimates the parameter p for Erdos-Renyi graphh and computes the
% expectation of the number of 4-cliques
[~, x_4] = estimate_p_4_clique(count-1,n);
m_vec = 1:(count-1);

% Modify to cut off beginning values below 0
mod_matrix = [m_vec' x_4'];
indices = find(mod_matrix(:,2) <= 1);
mod_matrix(indices,:) = [];

figure;
% Log-Log plot/fit of log(exp(X_4)) = a*log(m) + b
Const = polyfit(log(mod_matrix(:,1)), log(mod_matrix(:,2)),1);
a = Const(1);
b = Const(2);
%hold on
%fplot(f,'r')
y_hat = exp(a * log(mod_matrix(:,1)) + b);
loglog(mod_matrix(:,1), y_hat, '--or', mod_matrix(:,1), mod_matrix(:,2), '.')
legend('Least Squares Fit', 'Estimated through closed formula')
%loglog(mod_matrix(:,1),y_hat);


