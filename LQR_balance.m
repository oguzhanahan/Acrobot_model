function [K,As,Bs,Cs,Ds]  = LQR_balance(param)
m1=param.m1 ; %Mass of lover Pendulum
m2=param.m2 ;%Mass of upper Pendulum
l1=param.l1 ; %Lower Pendulum Length
l2=param.l2 ;%Upper Pendulum Length
g=param.g ;%Gravity

xd=param.xd;
%% fixed point
q=xd(1:2);
dq=xd(3:4);


%% System Dynamics

D=zeros(2,2);
dG=zeros(2,1);
B=zeros(2,1);


D(1,1)=(m1+m2)*l1^2+m2*l2^2+m2*l1*l2*cos(q(2));
D(1,2)=m2*l2^2+m2*l1*l2*cos(q(2));
D(2,1)=D(1,2);
D(2,2)=m2*l2^2;



dG(1,1)= -(m1+m2)*l1-m2*l2;
dG(1,2)= - m2*l2;
dG(2,1)= - m2*l2;
dG(2,2)= - m2*l2;

dG=g*dG;


B(1)=0;
B(2)=1;

%% Linearization

As=[zeros(size(D,1))     eye(size(D,1))
    (-D^(-1))*dG             zeros(size(D,1)) ];


Bs=[zeros(size(D,1),size(B,2))
             (D^-1)*B];
         

Cs=eye(size(As,1));

Ds=zeros(size(Cs,1),size(Bs,2));

%% LQR Design

Q=0.001*eye(size(As,1));

R=1;

K = lqr(As,Bs,Q,R);

wn=eig (As)
wnk=eig(As-Bs*K)
plot(wn,'o');
hold on
plot(wnk,'o');

