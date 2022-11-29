function[restored2] = interpolateAR(data_block, degraded, coeffs, model_order);
N = length(data_block);
A = zeros(N - model_order, N);
m = size(A,1);
k = find(degraded == 1);% To check if K is an empty matrix
TF = isempty(k);
if TF == 1
    restored2 = data_block;
else
    % Estimation of A matrix
    for j = 0 : model_order
        if j < model_order
            A(j*m+1:m+1:end-m*(model_order-j)) = coeffs(model_order - j);
        else
            A(j*m+1:m+1:end) = 1;
        end
    end
    % Estimation of Au matrix
    Au2 = A(:,k);
    % Estimation of Ak matrix
    A(:,k) = [];
    Ak2 = A;
    % Estimation of yk matrix
    block_new = data_block;
    block_new(:, k) = [];
    ik2 = block_new;
    % Estimation of yu matrix
    y_un = -transpose(Au2)*Au2 \ transpose(Au2)*Ak2*ik2';
    var = data_block;
    for m = 1 : length(k)
        var(1, k(m)) = y_un(m);
    end
    restored2 = var;
end
end