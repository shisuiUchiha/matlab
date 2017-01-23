Laplacian = [-1,-1,-1;-1,8,-1;-1,-1,-1];
S_horizantal = [-1,0,1;-2,0,2;-1,0,1];
S_vertical = [1,2,1;0,0,0;-1,-2,-1];
img = imread('Lena.jpg');
if size(img,3)==3
    %since its rgb image, convert it to grayscale
    img = rgb2gray(img);
end
subplot(1,4,4)
imshow(image_convolution_spatial(img,Laplacian));
title('after laplacian');
subplot(1,4,2)
imshow(image_convolution_spatial(img,S_horizantal));
title(' after S-Horizantal');
subplot(1,4,3)
imshow(image_convolution_spatial(img,S_vertical));
title(' after S-Vertical');
subplot(1,4,1)
imshow(img);
title(' before applying operators ');


