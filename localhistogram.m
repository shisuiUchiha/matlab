i=4;
disp(i)
Name = strcat('Hist',num2str(i),'.jpg');
img = imread(Name);
if size(img,3)==3
    %since its rgb image, convert it to grayscale
    img = rgb2gray(img);
end
img_resized = imresize(img ,[1024,1024]);
g=local_histeq(img_resized,128);
imshow(g)