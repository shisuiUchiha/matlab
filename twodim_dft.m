    f= imread('Lena.jpg');
%f=imresize(img,[1024,1024]);
if size(f,3)==3
    %since its rgb image, convert it to grayscale
    f = rgb2gray(f);
end
f=imresize(f,[64,64]);
imshow(f);
f=im2double(f); 
tic;
g=zeros(size(f));
temp=zeros(size(f));
m=size(f,1);
n=size(f,2);

for k=1:m
    for j=1:n
        temp=0;
        for x=1:m
            for y=1:n
                ex=exp((1i*-2*pi*(k-1)*(x-1)/m));
                rex=real(ex);
                iex=imag(ex);
                ey=exp((1i*-2*pi*(j-1)*(y-1)/n));
                rey=real(ey);
                iey=imag(ey);
                mr=(rex*rey)-(iex*iey);
                mi=(rex*iey)+(rey*iex);
                temp=temp+((f(x,y)*mr)+(f(x,y)*mi*1i));
            end
        end
    g(k,j)=temp;%removed the scaling factor since fft2 function doenot use that
    end
end
t_1=toc;
display(t_1);
tic;
r=fft2(f);
t_2=toc;
display(t_2);
l=ifft2(g); %inverse of the image obatined after 2d-dft
subplot(1,3,1)
imshow(l)
%finding the magnitude and phase plots of the fft of input image

s_g=fftshift(g);
mag_g=abs(s_g);% finds the magnitude
mag_g=100*log(mag_g+1)+50;%appropriate log scaling
mag_g=mat2gray(mag_g);
subplot(1,3,2)
imshow(mag_g)
subplot(1,3,3)
imshow(angle(s_g))


                
                
                
                
        
        
