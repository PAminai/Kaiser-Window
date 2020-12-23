% Digital Signal Processing Course
% Computer HW
% Name: Pouya Aminaie, St Number: 9532545
% Date: 28.09.1399


clear; close all; clc
%============= Initialization =====================
Wp=0.4*pi;
Ws=0.25*pi;
Wc=(Wp+Ws)/2;
dW=Wp-Ws;
d=0.002;
A=-20*log10(d);
beta= 0.1102*(A-8.7);
M=(A-8)/(2.258*dW);
M=ceil(M);
alpha=M/2;

%============ Kaiser Window Design ================
W=[];
for n=0:M
    W=[W, (besseli(0,beta*sqrt(1-((n-alpha)/alpha)^2)))/(besseli(0,beta))];
end

%============ Highpass Filter Design ==============
h_hp=[];
for n=0:M
    h_hp=[h_hp, (sin(pi*(n-22)))/(pi*(n-22))-(sin(Wc*(n-22)))/(Wc*(n-22))];
end
h=W.*h_hp;
h(23)=1;

%============ Frequency Responce Calculation =======
syms w
H=0;
for n=1:M
H = H+ h(n)*exp(-i*n*w);

end
func=H;
H(w)=func;

%==================== Estimation Error =============
Ae(w)=(exp(22*w*i))*H(w);


%========================= Plot ===================
figure
stem(W,'filled')
title('Kiser Window');
ylabel('w[n]');
xlabel('n  (sample)');
grid on

figure
stem(h,'filled')
title('Impulse Response');
ylabel('h[n]');
xlabel('n  (sample)');
grid on

figure
ezplot(10*log10(abs(H(w)))); % Freq response in dB
title('Frequency Response');
ylabel('| H(exp(jw)) |        dB');
xlabel('w  (rad/sec)');
grid on

figure
subplot(2,1,1);
ezplot(1-abs(Ae(w)), [0.4*pi , pi] ) % pass band
title('E(w) in pass band');
xlabel('w  (rad/sec)');
grid on

subplot(2,1,2);
ezplot(-abs(Ae(w)), [0 , 0.25*pi] ) % stop band
title('E(w) in stop band');
xlabel('w  (rad/sec)');
grid on




