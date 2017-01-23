img= imread('Hist4.jpg');
%f=imresize(img,[1024,1024]);
if size(img,3)==3
    %since its rgb image, convert it to grayscale
    f = rgb2gray(img);
end
numofpixels=size(f,1)*size(f,2);%calculate number of pixels in the given image
%subplot(1,4,1);
imshow(f);
%subplot(1,4,2)
%imhist(f)
title('before histogram equlisation');
g=uint8(zeros(size(f,1),size(f,2)));%create a new im with all pixels 0
freq=zeros(256,1);%this array notes the frequency of each pixel value
probf=zeros(256,1);%this array notes the probability of occurence of each pixel value
probc=zeros(256,1);%this array notes the cumulative probability of each pixel value
cumf=zeros(256,1);%this array notes the cumulative frequency of each pixel value
img_resized = imresize(f ,[1024,1024]);
p=local_histeq(img_resized,128);
for i=1:size(f,1)
    for j=1:size(f,2)
        val=f(i,j);
        freq(val+1)=freq(val+1)+1;
        probf(val+1)=freq(val+1)/numofpixels;
    end
end
output=zeros(256,1);
k=0;
for i=1:size(freq,1)
    k=k+freq(i);
    cumf(i)=k;
    probc(i)=cumf(i)/numofpixels;
    output(i)=round(probc(i)*255);
end

for i=1:size(f,1)
    for j=1:size(f,2)
        g(i,j)=output(f(i,j)+1);    
    end
end

subplot(1,4,1)
imshow(g)
%title('after histogram equalisation');
subplot(1,4,2)
imhist(g)
subplot(1,4,3)
imshow(p)
subplot(1,4,4)
imhist(p)

    
    
    
    
    
    
    
    
    
    

