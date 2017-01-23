I1 = imread('MoonLanding.png');
I2 = imread('MoonLandingNoise.png');
I1_fft_output = DFT_scaling(fft2(I1));
I2_fft_output = DFT_scaling(fft2(I2));
[m,n] = size(I1);
subplot(2,3,1)
imshow(I1)
title('original')
subplot(2,3,2)
imshow(I2)
title('nosiy image')
subplot(2,3,5)
imshow(I2_fft_output,[])
title('fft noisy image')
subplot(2,3,4)
imshow(I1_fft_output,[])
title('fft original ')
subplot(2,3,3)
imshow(I2-I1,[])
title('Spatial Domain Noise')
subplot(2,3,6)
imshow(DFT_scaling(fft2(I2-I1)),[])
title('FFT of noise')

