i=7;
disp(i)
Name = strcat('Hist',num2str(i),'.jpg');
img = imread(Name);
if size(img,3)==3
    %since its rgb image, convert it to grayscale
    img = rgb2gray(img);
end
img_resized = imresize(img ,[1024,1024]);
tic;
Wm = 256;
Wn = 256;
[m,n] = size(img_resized)
img_lhe = uint8(zeros(m,n));
m_index = m/Wm
n_index = n/Wn
Window = uint8(zeros(Wm,Wn));
for i = 1: m_index
    for j = 1:n_index
    
            Window = img_resized (((i-1)*Wm)+1:(i)*Wm,((j-1)*Wn)+1:(j)*Wn);
            img_lhe(((i-1)*Wm)+1:(i)*Wm,((j-1)*Wm)+1:(j)*Wn) = Histogram_equilization(Window);
    
    end    
end
subplot(1,2,1)
imshow(Histogram_equilization(img_resized))
subplot(1,2,2)
imshow(img_lhe)

t = toc;
disp(t);