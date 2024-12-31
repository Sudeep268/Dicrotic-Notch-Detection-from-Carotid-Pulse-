clc;
clear all;
%Loading the data
y = readtable('PWs_Carotid_PPG.txt'); % load your dataset file
y = table2array(y);
y = y(5,:);
y = y(2:488);

figure(1)
subplot(311)
plot(y);

%Processing the signal
N = length(y);
for n=3:N-2
     p(n) = 2*y(n-2) + y(n-1)-2*y(n)-y(n+1)+ 2*y(n+2);
end
subplot(312)
plot(p);
p = p.*p;
M =16;
s = zeros(1,N-2);
for  n = 1:length(p)-113
    for k =1:M
        w(k) = M-k+1;      
        s(n)= s(n) + p(k+n+1)*w(k);         
    end
end
subplot(313)
plot(s);
% Peak Detection
threshold1 = 210;
threshold2 = 380;
peaks = zeros(1,length(s));
for i = 2:length(s)-1
    if(s(i)> threshold1 && s(i)< threshold2 && s(i-1)<s(i) && s(i+1)<s(i))
        peaks(i) = 1;
    end
end
figure(2)
plot(peaks);
    
