function [residual] = getResidual(data, coeffs)
% Adding a0 = 1 
coeffs = [1 coeffs];
data = data - mean(data);
residual = filter(coeffs, 1, data);
end