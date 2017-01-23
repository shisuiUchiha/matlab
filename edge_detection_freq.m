function output_img = edge_detection_freq(img,operator)
[M,N] = size(img);
fft_img = fft2(img);
padd_operator = padarray(operator,[M-3,N-3],'post');
padd_operator = fft2(padd_operator);
convoluted_img_freq = fft_img.*padd_operator;
convoluted_img = ifft2(convoluted_img_freq);
convoluted_img = real(convoluted_img);
maximum = max(convoluted_img(:))
minimum = min(convoluted_img(:))
img_new = uint8(zeros(M,N));
img_temp = zeros(M,N);
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

