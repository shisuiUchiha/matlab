disp('BUTTERWORTH BANDPASS IIR FILTER :');
syms s;
samp_freq=50;
m=53;
q_m=floor(0.1*m);
r_m=m-10*q_m;
disp('1) UNNORMALISED DISCRETE TIME FILTER SPECIFICATIONS');
B_L=4+0.7*q_m+2*r_m
B_H=B_L+10
S_L=B_L-2
S_H=B_H+2
disp('PASSBAND----->MONOTONIC');



%normalising the filter specs
disp('2) NORMALISED DIGITAL FILTER SPECIFICATIONS');
N_B_L=(B_L/samp_freq)*pi
N_B_H=(B_H/samp_freq)*pi
N_S_L=(S_L/samp_freq)*pi
N_S_H=(S_H/samp_freq)*pi

%conversion into s->z domain
disp('3) ANALOG FILTER SPECIFICATIONS AFTER BILINEAR TRANSFORMATION');

omega_s_l=tan(N_S_L/2)
omega_s_h=tan(N_S_H/2)
omega_p_l=tan(N_B_L/2)
omega_p_h=tan(N_B_H/2)

disp('4) FREQUENCY TRANSFORMATION---->(s^2)+(omega_o^2))/(band*s)');

omega_o=sqrt(omega_p_l*omega_p_h)

band=omega_p_h-omega_p_l


%conversion into lowpass filter specs
disp('5) FREQUENCY TRANSFORMED LOWPASS ANALOG FILTER SPECIFICATIONS');

omega_p_l_t=((omega_p_l)^2 - (omega_o)^2)/(band*omega_p_l)
omega_p_h_t=((omega_p_h)^2 - (omega_o)^2)/(band*omega_p_h)
omega_s_l_t=abs(((omega_s_l)^2 - (omega_o)^2)/(band*omega_s_l));
omega_s_h_t=abs(((omega_s_h)^2 - (omega_o)^2)/(band*omega_s_h));

%taking min of the stopband 

if omega_s_l_t>omega_s_h_t
    omega_low_s=omega_s_h_t
else
    omega_low_s=omega_s_l_t
end

d_2=(1/(0.15*0.15))-1;
d_1=(1/(0.85*0.85))-1;

num_log=d_2/d_1;
den_log=omega_low_s/omega_p_h_t;

%finding N


N=ceil(0.5*(log(num_log)/log(den_log)))

%finding omega_c

omega_c=((d_1^(-1/(2*N)))+(omega_low_s*(d_2^(-1/(2*N)))))/2


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

disp('6) LOWPASS FILTER TRANSFER FUNCTION');

H=tf(num,den)
disp('POLES OF THE LOWPASS FILTER TRANSFER FUNCTION');
poles

figure
pzmap(num,den)
xlabel('POLE-ZERO PLOT FOR THE LOWPASS FILTER');

g=((s^2)+(omega_o)^2)/(band*s);
disp('7) BANDPASS FILTER TRANSFER FUNCTION');
band_pass=K/poly2sym(den,g)  %converting from lp to bp
[band_num,band_den]=numden(band_pass); %extracting the num and den coefficients
band_num1=sym2poly(band_num);
band_den1=sym2poly(band_den);
syms z;
f=(1-((z)^-1))/(1+((z)^-1));
disp('8) DISCRETE TIME FILTER TRANSFER FUNCTION');
z_tf=(poly2sym(band_num1,f))/(poly2sym(band_den1,f))%z domain transfering

[z_tf_num,z_tf_den]=numden(z_tf); %extracting the num and den arrays

z_tf_num1=sym2poly(z_tf_num)
z_tf_den1=sym2poly(z_tf_den)
figure
pzmap(z_tf_num1,z_tf_den1)
xlabel('POLE-ZERO PLOT FOR DIGITAL FILTER');

[h,w] = freqz(z_tf_num1,z_tf_den1,10000);
figure
plot(w,(abs(h)))

xlabel('Frequency')
ylabel('Magnitude')






