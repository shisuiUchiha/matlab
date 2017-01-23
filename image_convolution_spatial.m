function img_edge = image_convolution_spatial(img, operator )

img_convoluted = conv2(img,operator,'same');
[m,n] = size(img);
max = -99999;
min = 99999;
for i = 1: m 
    for j = 1: n
        if max < img_convoluted(i,j)
            max = img_convoluted(i,j);
        end
        if min > img_convoluted(i,j)
            min = img_convoluted(i,j);
        end
    end
end

img_edge = uint8(zeros(m,n));
for i = 1: m 
    for j = 1: n
        image_temp(i,j) = (img_convoluted(i,j)-min);
    end
end
max = max-min;

for i = 1: m 
    for j = 1: n
        img_edge(i,j) = round(image_temp(i,j)*255/max) ;
    end
end


end

