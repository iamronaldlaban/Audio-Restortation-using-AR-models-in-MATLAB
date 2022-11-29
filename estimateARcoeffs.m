function [coeffs, avg] = estimateARcoeffs(data, model_order)
    N_original = length(data);% Length of Original Block
    data_in_block = data(model_order + 1 : N_original); % Inner Block
    N = length(data_in_block); % Length of the Inner Block
    % Normalization of the Inner Block
    norm_data = (data_in_block - mean(data_in_block)) ./ std(data_in_block);
    % Compute the regression matrix R
    for i = 1 : model_order
     for j = 1 : model_order
        R(i, j) = sum(norm_data(model_order + 1 - i : N - i) .* ...
        norm_data(model_order + 1 - j : N - j));
     end
    end
        % Evaluate r
    for i = 1 : model_order
        r(i) = sum(norm_data(model_order + 1 : N) .* ...
        norm_data(model_order + 1 - i : N - i));
    end
    coeffs = - (inv(R) * transpose(r));
    coeffs = -R \ transpose(r);
    avg = mean(data_in_block);
end