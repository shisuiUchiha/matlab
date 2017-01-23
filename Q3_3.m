Laplacian = [-1,-1,-1;-1,8,-1;-1,-1,-1];
S_horizantal = [-1,0,1;-2,0,2;-1,0,1];
S_vertical = [1,2,1;0,0,0;-1,-2,-1];
img = imread('Lena.jpg');
if size(img,3)==3
    %since its rgb image, convert it to grayscale
    img = rgb2gray(img);
end
%
I_1 = image_convolution_spatial(img,Laplacian);
I_2 = image_convolution_spatial(img,S_horizantal);
I_3 = image_convolution_spatial(img,S_vertical);
BW_1 = im2bw(I_1,.5);
BW_2 = im2bw(I_2,.5);
BW_3 = im2bw(I_3,.51);

subplot(1,3,1)
imshow(BW_1);
title('Laplacian');
subplot(1,3,2)
imshow(BW_2);
title('S-Horizantal');
subplot(1,3,3)
imshow(BW_3);
title('S-Vertical');

