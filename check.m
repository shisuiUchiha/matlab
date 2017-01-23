f= imread('Hist4.jpg');
%f=imresize(img,[1024,1024]);
if size(f,3)==3
    %since its rgb image, convert it to grayscale
    f = rgb2gray(f);
end
f=imresize(f,[16,16]);
f=im2double(f);
tic;
g=fft2(f);
t=toc;
display(t);
                
                
                
                
                
        
        
