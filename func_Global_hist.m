function output_img = func_Global_hist(img)
[counts, grayscales] = imhist(img); % no of pixels with respective intensities
list_intensity = transpose(grayscales); % creating a vector with all the grayscales
list_pixels = transpose(counts); % a vector containing count of pixels having (column-1) intensity
all_pixels = sum(list_pixels); % total number of pixels
list_pixels = list_pixels/all_pixels; %  a vector having probabilties of the intensities
hist_equ = zeros(1,256);
for k = 1:256             % transformation vector
    if k == 1
        hist_equ(k) = list_pixels(k);
    else
    hist_equ(k) = hist_equ(k-1)+ list_pixels(k);
    end
end
hist_equ = round(hist_equ*255);
[M,N] = size(img);
output_img = zeros(M,N);
for r = 1:M
    for s = 1:N
          img(r,s) = hist_equ(img(r,s)+1); 
    end
end
output_img = img;
end

