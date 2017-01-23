prompt = 'Input filename\n';
Name = input(prompt,'s');
img = imread(Name);
if size(img,3) == 3
    img = rgb2gray(img);
end
% img = im2double(img);
Laplacian = [-1 -2 -1; 0 0 0; 1 2 1];
output = edge_detection_freq(img,Laplacian);
%output = image_convolution_spatial(img,Laplacian);
for r = 1:512
    for s = 1:512
        if output(r,s) <= 135
            output(r,s) = 0;
        else
            output(r,s) = 255;
        end
    end
end
imshow(output);