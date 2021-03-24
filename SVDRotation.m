function [R, T] = SVDRotation(d, m)
% This function takes in two point sets, d and m, and calculates the
% rotation and transformation matrices, R and T, between the sets

dbar = 1/length(d) * sum(d);
mbar = 1/length(m) * sum(m);

dc = d - dbar;
mc = m - mbar;
H = mc .* trans(dc);

[U, ~, V] = svd(H);

R = V * trans(U);
T = dbar - R * mbar;

if det(R) == -1
    error('Determinant of R is -1')
end

end