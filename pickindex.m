% FIND MINIMA
function z = pickindex(t,k)
for i = 1:length(t)
    temp = simple_mult(t(i));
    F(i,1) = temp(1);
    F(i,2) = temp(2);
end
z = F;
z = z(k); % return objective k