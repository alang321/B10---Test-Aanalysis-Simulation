function [R, T] = SVDRotation(d, m)
% This function takes in two point sets, d and m, and calculates the
% rotation and transformation matrices, R and T, between the sets as per
% Eggert et al. (1997): "Estimating 3-D rigid body transformations: a 
% comparison of four major algorithms"

% Check the paper for the derivation of these equations
% When actually implementing this, check the size of d and m, maybe can't
% use length()?
dbar = 1/length(d) * sum(d);
mbar = 1/length(m) * sum(m);

dc = d - dbar;
mc = m - mbar;
H = mc .* transpose(dc);

[U, ~, V] = svd(H);

R = V .* transpose(U);
T = dbar - R .* mbar;

% If the det(R) is -1 the method breaks down (should not happen in our case
% afaik)
if det(R) == -1
    error('Determinant of R is -1')
end

end