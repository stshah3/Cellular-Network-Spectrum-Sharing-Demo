% FIND REWARDS AS A FUNCTION OF USER ARRIVAL RATES
function f = simple_multx(x)
% 2nd degree polynomial fit
f(:,1) = 1e4*(0.7939*x.^2 -2.0003*x + 2.0450);
f(:,2) = 1e4*(0.7115*x.^2 -1.3533*x + 0.9549);