function output_img = edge_detection(img,operator)
convoluted_img = conv2(img,operator,'same');
[M,N] = size(img);
maximum = max(convoluted_img(:))
minimum = min(convoluted_img(:))

img_new = uint8(zeros(M,N));
for r = 1:M
    for s = 1:N
        img_temp(r,s) = (convoluted_img(r,s)-minimum);
    end
end

maximum = maximum - minimum;

for r = 1:M
    for s = 1:N
        img_new(r,s) = round(img_temp(r,s)*255/maximum);
    end
end

output_img = img_new;
end

