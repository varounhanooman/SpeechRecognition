%KDE Kernel Density Esitimation to figure out how much gaussians are in a
%datset
%Expectation Maximization
%E-Step update variable
%M-Step update hypothesis
%Start
close all
clear
%Initialize Values

%y = [-0.39 0.12 0.94 1.67 1.76 2.44 3.72 4.28 4.92 5.53 0.06 0.48 1.01 1.68 1.80 3.25 4.12 4.60 5.28 6.22];
y_1 = normrnd(22,2,[1,50]);
y_2 = normrnd(12,2,[1,50]);
y = [y_1,y_2];
x = -1:30;
Mu = [5 15];
sigma = [5 5];
pi = 0.1;
wp1 = zeros(1, length(y)) ;
wp2 = zeros(1, length(y)) ;

for iteration=1:100
    %Expectation Step
    %for each of the point, wich Gaussian generated it

    wp1 = gaussmf(y,[sigma(1) Mu(1)])*pi;
    wp2 = gaussmf(y,[sigma(2) Mu(2)])*(1-pi);
    dem = wp1+wp2;
    wp1 = wp1./dem;
    wp2 = wp2./dem;
        
    %Maximization Step
    %Modify the hidden value such that is maximizes the probability
    %calc new Mu(1) 
    Mu(1)=sum(wp1.*y)/sum(wp1);
    %calc new Mu(2)
    Mu(2)=sum(wp2.*y)/sum(wp2);
    %calc new sigma(1)
    sigma(1)=sqrt(sum(wp1.*(y-Mu(1)).^2)/sum(wp1));
    %calc new sigma(2)
    sigma(2)=sqrt(sum(wp2.*(y-Mu(2)).^2)/sum(wp2));
    %calc new pi:
    pi=sum(wp2)/length(y);
    %Is Converged

end
%no -> back to expecation step
 figure(1)
 hist(y,0:1:30);
 hold on
 plot(x, gaussmf(x,[5 5]), '--r', 'LineWidth',2)
 plot(x, gaussmf(x,[5 15]), '--g', 'LineWidth',2) 
 plot(x, gaussmf(x,[sigma(1) Mu(1)]), '-r', 'LineWidth',2)
 plot(x, gaussmf(x,[sigma(2) Mu(2)]), '-g', 'LineWidth',2) 
 hold off


%yes -> Stop

