samp_freq=50;
m=52;
q_m=floor(0.1*m);
r_m=m-(10*q_m);
S_L=4+(0.9*q_m)+(2*r_m);
S_H=S_L+10
P_L=S_L-2
P_H=S_H+2

%normalising the filter specs

nS_L=(S_L/samp_freq)*pi
nS_H=(S_H/samp_freq)*pi
nP_L=(P_L/samp_freq)*pi
nP_H=(P_H/samp_freq)*pi


%conversion from s to z domain

omega_s_1=tan(nS_L/2)
omega_s_2=tan(nS_H/2)
omega_p_1=tan(nP_L/2)
omega_p_2=tan(nP_H/2)

omega_o=sqrt(omega_p_1*omega_p_2);
band=omega_p_2-omega_p_1;


%conversion into lowpass filter specs

omega_p_l_t=((band*omega_p_1)/((omega_p_1)^2 - (omega_o)^2));
omega_p_h_t=((band*omega_p_2)/((omega_p_2)^2 - (omega_o)^2));
omega_s_l_t=abs((band*omega_s_1)/((omega_s_1)^2 - (omega_o)^2));
omega_s_h_t=abs((band*omega_s_2)/((omega_s_2)^2 - (omega_o)^2));

%taking min of the stopband


if omega_s_l_t>omega_s_h_t
    omega_low_s=omega_s_h_t
else
    omega_low_s=omega_s_l_t
end


%epsilon 

d_2=(1/(0.15*0.15))-1;
d_1=(1/(0.85*0.85))-1;

epsilon=sqrt(d_1);

%finding N

N=ceil(acosh(sqrt(d_2)/epsilon)/acosh(omega_low_s/omega_p_h_t));

%poles of the chebyschev filter

poles=[];
for k=4:7
    a_k=(((2*k)+1)*pi)/8;
    b_k=0.25*(asinh(1/epsilon));
    h_k=a_k+(1j*b_k);
    s_k=1j*cos(h_k);
    poles=[poles s_k];
end

Zeros=[];
K=1/(epsilon*(2^(N-1)));
[num,den]=zp2tf(Zeros,poles,K);
H=tf(num,den);
pzmap(H)
grid on

