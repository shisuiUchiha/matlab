lena=imread('Lena.jpg');
if size(lena,3)==3
    %since its rgb image, convert it to grayscale
    lena = rgb2gray(lena);
end
lena=imresize(lena,[256,256]);
imshow(lena);
baboon=imread('baboon.png');
if size(baboon,3)==3
    %since its rgb image, convert it to grayscale
    baboon = rgb2gray(baboon);
end
baboon=imresize(baboon,[256,256]);
lena=fft2(lena);
imshow(lena);
baboon=fft2(baboon);
mag_b=abs(baboon);
mag=abs(lena);
lena_m=100*log(fftshift(mag)+1);
%lena_m=mat2gray(lena_m);
imshow(lena_m);
baboon_m=100*log(fftshift(mag_b)+1);
lena_p=angle(lena);
baboon_p=angle(baboon);
real=lena_m.*cos(baboon_p);
im=lena_m.*sin(baboon_p);
final=real+1i*im;
final=(ifft2(uint8(final)));
imshow((final))