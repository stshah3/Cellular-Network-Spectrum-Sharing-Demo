% GENERATE REWARDS ACCORDING TO CENTRALIZED MODEL
function f = simple_mult(lambda)
m_com = 1;
% total spectrum size
m_max = 25;
% 2 Mbits
X_ON = 2;
% max users per cell
n_max = 8;
n = linspace(1,n_max,n_max);
% Average cell data rate
D = 7.93;
% pricing
Ku = 500;
Kb = 200;
Kbk = 40;
pi_th = .20; 
% assume constant activity
pi_ni = .80;
delta = 0.9;
mu_com = 0.25;

% 8 MHz, T-Mobile --------------------
m = 8; 
mu = m*D/X_ON;
Pi_sp = Kb*m*exp(-(m_max-8-16)/m_com);

% percent active
a = .8; 

for i=1:n_max
    pi_bk(i) = (lambda*a)^(n(i))*exp(-lambda*a)/(factorial(n(i)));
    Pi_bk(i) = exp((pi_bk(i)-delta*pi_th)*Kbk);
    phi(i) = Ku*(1-exp(-mu/(n(i)*mu_com)));
    u(i) = n(i)*pi_ni*phi(i) - Pi_sp - Pi_bk(i);
end

f(:,1) = sum(u);

% 16 MHz, AT&T -----------------------
m = 16;
mu = m*D/X_ON;
Pi_sp = Kb*m*exp(-(m_max-8-16)/m_com);

for i=1:n_max
    pi_bk(i) = lambda^(n(i))*exp(-lambda)/(factorial(n(i)));
    Pi_bk(i) = exp((pi_bk(i)-delta*pi_th)*Kbk);
    phi(i) = Ku*(1-exp(-mu/(n(i)*mu_com)));
    u(i) = n(i)*pi_ni*phi(i) - Pi_sp - Pi_bk(i);
end

f(:,2) = sum(u);


