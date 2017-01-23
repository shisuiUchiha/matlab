a=imread('baboon.png');
k=imresize(a,[600,600]);
%subplot(2,2,1);
%imshow(k)
b=rgb2gray(k);
%subplot(2,2,2);
%imshow(b)
h=edge(b,'sobel');
c=double(b);
e=double(zeros(size(c)));
d=double(zeros(size(c)));
for i=1:size(c,1)-2
    for j=1:size(c,2)-2
        d_x=((-1*c(i,j)-2*c(i+1,j)-1*c(i+2,j))+(1*c(i,j+2)+2*c(i+1,j+2)+1*c(i+2,j+2))); %derivative in x-->s=[-1,-2,-1;0,0,0;1,2,1]
        d_y=((-1*c(i,j)-2*c(i,j+1)-1*c(i,j+2))+(1*c(i+2,j)+2*c(i+2,j+1)+1*c(i+2,j+2)));%derivative in y-->s=[-1,0,1;-2,0,2;-1,0,1]
        mag_1=sqrt((d_x*d_x)+(d_y*d_y));% taking square root mag
        mag_2=abs(d_x)+abs(d_y); % taking absolute as mag
        if mag_1<100
            mag_1=0;
        end
        if mag_1>100
            mag_1=200;
        end
        if mag_2<100
            mag_2=0;
        end
        if mag_2>100
            mag_2=200;
        end
        e(i,j)=mag_1;
        d(i,j)=mag_2;
    end
end
%subplot(2,2,3);
imshow(e)
%subplot(2,2,4);
%imshow(d)


        