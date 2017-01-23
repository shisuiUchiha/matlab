function output_img = local_histeq(img,window_size)
m = window_size;
k = 1024/m;
n = 1025-m;
% new_img = zeros(m,m);
for r=1:m:n
    for s=1:m:n
            img(r:r+m-1,s:s+m-1) = func_Global_hist(img(r:r+m-1,s:s+m-1));
    end
end
output_img = img;
end
      

