samp_freq=50;
m=53;
q_m=floor(0.1*m);
r_m=m-10*q_m;
B_L=4+0.7*q_m+2*r_m;
B_H=B_L+10;
S_L=B_L-2;
S_H=B_H+2;



%normalising the filter specs

N_B_L=(B_L/samp_freq)*pi;
N_B_H=(B_H/samp_freq)*pi;
N_S_L=(S_L/samp_freq)*pi;
N_S_H=(S_H/samp_freq)*pi;

%conversion into s->z domain

omega_s_l=tan(N_S_L/2);
omega_s_h=tan(N_S_H/2);
omega_p_l=tan(N_B_L/2);
omega_p_h=tan(N_B_H/2);

omega_o=sqrt(omega_p_l*omega_p_h);

band=omega_p_h-omega_p_l;
%g=(((s^2)+(omega_o^2))/(band*s))

%conversion into lowpass filter specs

omega_p_l_t=((omega_p_l)^2 - (omega_o)^2)/(band*omega_p_l);
omega_p_h_t=((omega_p_h)^2 - (omega_o)^2)/(band*omega_p_h);
omega_s_l_t=abs(((omega_s_l)^2 - (omega_o)^2)/(band*omega_s_l));
omega_s_h_t=abs(((omega_s_h)^2 - (omega_o)^2)/(band*omega_s_h));

%taking min of the stopband 

if omega_s_l_t>omega_s_h_t
    omega_low_s=omega_s_h_t;
else
    omega_low_s=omega_s_l_t;
end

d_2=(1/(0.15*0.15))-1;
d_1=(1/(0.85*0.85))-1;

num_log=d_2/d_1;
den_log=omega_low_s/omega_p_h_t;

%finding N

N=ceil(0.5*(log(num_log)/log(den_log)));

%finding omega_c

omega_c=((d_1^(-1/(2*N)))+(omega_low_s*(d_2^(-1/(2*N)))))/2;


k=0;
poles=[];
for k = 0:N-1
    angle=(((2*k)+1)/(2*N)*pi)+(pi/2);
    poles=[poles omega_c*exp(1j*angle)];
end   

Zeros=[];
%Tf=tf(num,den)
K=(omega_c^N);
[num,den]=zp2tf(Zeros,poles,K);
H=tf(num,den);
pzmap(H)
grid on