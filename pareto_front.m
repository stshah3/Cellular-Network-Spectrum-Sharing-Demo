% Samyak Shah
% AE 504 Final Project: Centralized Model Demo

% Run this script 

close all
clear all
clc

% PLOT REWARDS

% user arrival rates
lambda = linspace(0,1.5,2000);

for i = 1:length(lambda)
    temp = simple_mult(lambda(i));
    F(i,1) = temp(1);
    F(i,2) = temp(2);
end

tmobile = F(:,1);
att = F(:,2);

% plot curves
hold on
plot(lambda,tmobile,'m','LineWidth',2)
plot(lambda,att,'b','LineWidth',2)

% polyfit between minimums
high = 333*5+2;
low = 333*4+2;
lambda = linspace(1,1.25, high-low+1);
[p,~,mu] = polyfit(lambda, tmobile(low:high)', 5);
[p2,~,mu2] = polyfit(lambda, att(low:high)', 5);
f = polyval(p,lambda,[],mu);
f2 = polyval(p2,lambda,[],mu2);
plot(lambda,f,'g','LineWidth',2)
plot(lambda,f2,'g','LineWidth',2)

% coefficients
c = polyfit(lambda, tmobile(low:high)', 5);
c2 = polyfit(lambda, att(low:high)', 5);

% error
est = polyval(c,lambda);
error = F((low:high),1)'-est;
T = table(lambda,F((low:high),1)',est,error,'VariableNames',{'X','Y','Fit','FitError'});

% plot markers
plot([1.25, 1.25],[0,10000],'g--');
plot([1,1],[0,10000],'g--');
plot(1,3145.4,'k.','MarkerSize',15);
plot(1.25,7854.3,'k.','MarkerSize',15);
text(1.25,7500,'Minimum(T-Mobile)')
text(.75,2750,'Minimum(AT&T)')
hold off
legend('T-Mobile','AT&T','Optimization Region')
xlabel('User Arrival Rates (s^{-1})')
ylabel('Reward (USD/time unit)')

% FIND PARETO FRONT
clear all

% find minimums 
k = 1;
[min1,minfn1] = fminbnd(@(x)pickindex(x,k),0,1.5);
k = 2;
[min2,minfn2] = fminbnd(@(x)pickindex(x,k),0,1.5);
goal = [minfn1,minfn2];

nf = 2; % number of objective functions
N = 50; % number of points for plotting
onen = 1/N;
x = zeros(N+1,1);
f = zeros(N+1,nf);
fun = @simple_multx;
x0 = 0.5;
options = optimoptions('fgoalattain','Display','off');
for r = 0:N
    lambda = onen*r; % 0 through 1
    weight = [lambda,1-lambda];
    [x(r+1,:),f(r+1,:)] = fgoalattain(fun,x0,goal,weight,...
        [],[],[],[],[],[],[],options);
end

figure
hold on
plot(f(:,1),f(:,2),'k.');
xlabel('T-Mobile')
ylabel('AT&T')
plot(7926,3430,'g.','MarkerSize',30);
text(7926,2500,'Minimum rewards of (7926, 3430)')