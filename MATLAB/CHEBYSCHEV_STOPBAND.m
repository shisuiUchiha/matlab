disp('CHEBYSCHEV BANDSTOP IIR FILTER :');
syms s;
samp_freq=50;
m=53;
q_m=floor(0.1*m);
r_m=m-(10*q_m);
disp('1) UNNORMALISED DISCRETE TIME FILTER SPECIFICATIONS');
S_L=4+(0.9*q_m)+(2*r_m)
S_H=S_L+10
P_L=S_L-2
P_H=S_H+2
disp('PASSBAND----->RIPPLES');

%normalising the filter specs
disp('2) NORMALISED DIGITAL FILTER SPECIFICATIONS');
nS_L=(S_L/samp_freq)*pi
nS_H=(S_H/samp_freq)*pi
nP_L=(P_L/samp_freq)*pi
nP_H=(P_H/samp_freq)*pi


%conversion from s to z domain
disp('3) ANALOG FILTER SPECIFICATIONS AFTER BILINEAR TRANSFORMATION');

omega_s_1=tan(nS_L/2)
omega_s_2=tan(nS_H/2)
omega_p_1=tan(nP_L/2)
omega_p_2=tan(nP_H/2)


disp('4) FREQUENCY TRANSFORMATION---->(band*s)/(s^2)+(omega_o^2))');


omega_o=sqrt(omega_p_1*omega_p_2)
band=omega_p_2-omega_p_1


%conversion into lowpass filter specs
disp('5) FREQUENCY TRANSFORMED LOWPASS ANALOG FILTER SPECIFICATIONS');


omega_p_l_t=((band*omega_p_1)/((omega_p_1)^2 - (omega_o)^2))
omega_p_h_t=((band*omega_p_2)/((omega_p_2)^2 - (omega_o)^2))
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
disp('6) LOWPASS FILTER TRANSFER FUNCTION');
H=tf(num,den)
disp('POLES OF THE LOWPASS FILTER TRANSFER FUNCTION');
poles

figure
pzmap(num,den)
xlabel('POLE-ZERO PLOT FOR THE LOWPASS FILTER');
g=(band*s)/((s^2)+(omega_o)^2);
disp('7) BANDSTOP FILTER TRANSFER FUNCTION');
band_stop=K/poly2sym(den,g)  %converting from lp to bs
[band_num,band_den]=numden(band_stop); %extracting the num and den coefficients
band_num1=sym2poly(band_num);
band_den1=sym2poly(band_den);
syms z;
f=(1-((z)^-1))/(1+((z)^-1));
disp('8) DISCRETE TIME FILTER TRANSFER FUNCTION');
z_tf=(poly2sym(band_num1,f))/(poly2sym(band_den1,f)) %z domain transfering 

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
