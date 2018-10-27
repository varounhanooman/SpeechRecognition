%KDE Kernel Density Esitimation to figure out how much gaussians are in a
%datset
%Expectation Maximization
%E-Step update variable
%M-Step update hypothesis
%Start
clear
%Initialize Values
y = [-0.39 0.12 0.94 1.67 1.76 2.44 3.72 4.28 4.92 5.53 0.06 0.48 1.01 1.68 1.80 3.25 4.12 4.60 5.28 6.22];
Mu = [5 2];
sigma = [5 5];
pi = 0.9;
g1 = zeros(length(y), 1) ;
g2 = zeros(length(y), 1) ;
gamma = zeros(length(y), 1) ;

for iteration=1:20
    %Expectation Step
    %for each of the point, wich Gaussian generated it
    for i=1:length(y)
        g1(i) = gaussmf(y(i),[sigma(1) Mu(1)]);
        g2(i) = gaussmf(y(i),[sigma(2) Mu(2)]);
        %gamma(i) = (pi*g2(i))/((1-pi)*g1(i)+pi*g2(i));
        
    end
    %Maximization Step
    %Modify the hidden value such that is maximizes the probability
    %calc new sigma(1)
    num=0;
    denum=0;
    for i=1:length(y)    
        num=(1-gamma(i))*(y(i)-Mu(1))^2+num;
        denum=(1-gamma(i))+denum;
    end
    sigma(1)=num/denum;
    %calc new sigma(2)
    num=0;
    denum=0;
    for i=1:length(y)    
        num=(gamma(i))*(y(i)-Mu(2))^2+num;
        denum=(gamma(i))+denum;
    end
    sigma(2)=num/denum;
    %calc new Mu(1)
    num=0;
    denum=0;
    for i=1:length(y)    
        num=(1-gamma(i))*y(i)+num;
        denum=(1-gamma(i))+denum;
    end
    Mu(1)=num/denum;
    %calc new Mu(2)
    num=0;
    denum=0;
    for i=1:length(y)    
        num=gamma(i)*y(i)+num;
        denum=gamma(i)+denum;
    end
    Mu(2)=num/denum;
    %calc new pi
    pi=sum(gamma)/length(y);
    %Is Converged
end
%no -> back to expecation step
hist(y);
%yes -> Stop

