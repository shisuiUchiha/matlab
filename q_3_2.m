img = imread('Lena.jpg');
if size(img,3)==3
    %since its rgb image, convert it to grayscale
    img = rgb2gray(img);
end
[m,n] = size(img);
Laplacian = [-1,-1,-1;-1,8,-1;-1,-1,-1];
Sobel_horizantal = [-1,0,1;-2,0,2;-1,0,1];
Sobel_vertical = [1,2,1;0,0,0;-1,-2,-1];
img_fft = fft2(img,m,n);
I_laplacian = fft2(Laplacian,m,n);
I_sobel_horizantal = fft2(Sobel_horizantal,m,n);
I_sobel_vertical = fft2(Sobel_vertical,m,n);
filterimglaplacian = img_fft .*I_laplacian;
filter_img_sobel_horizantal = img_fft .*I_sobel_horizantal;
filter_img_sobel_vertical = img_fft .*I_sobel_vertical;

img_final_laplacian = real(uint8(ifft2(filterimglaplacian)));
img_final_sobel_horizantal = real(uint8(ifft2(filter_img_sobel_horizantal)));
img_final_sobel_vertical = real(uint8(ifft2(filter_img_sobel_vertical)));
subplot(2,2,1)
imshow(img_final_laplacian);
title('laplacian');
subplot(2,2,2)
imshow(img_final_sobel_horizantal);
title('sobel horizantal')
subplot(2,2,3)
imshow(img_final_sobel_vertical);
title('sobel vertical')