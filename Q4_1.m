I1 = imread('MoonLanding.png');
I2 = imread('MoonLandingNoise.png');
I1_fft_output = DFT_scaling(fft2(I1));
I2_fft_output = DFT_scaling(fft2(I2));
[m,n] = size(I1);
subplot(2,2,1)
imshow(I1)
title('original')
subplot(2,2,2)
imshow(I2)
title('nosie image')
subplot(2,2,3)
imshow(I1_fft_output,[])
title('fft original')
subplot(2,2,4)
imshow(I2_fft_output,[])
title('fft noise image')
low = fspecial('gaussian',[m,n], 2);
high = fspecial('log',[m,n],8);
BRF = high+low;
filtered_img = imfilter(I2,BRF);
%subplot(2,3,5)
%title('fft noise image')
%imshow(filtered_img)
