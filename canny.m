a=imread('baboon.png');
a=imresize(a,[600,600]);
a=rgb2gray(a);
a=double(a);
b=double(zeros(size(a)));
%%%first step smoothing with 2d gaussian filter
%%%using a 2d 5*5 gaussian filter with variance=1.4

for i=1:size(a,1)-4
    for j=1:size(a,2)-4
        b(i,j)=(1/159)*(a(i,j)*2+a(i+1,j)*4+a(i+2,j)*5+a(i+3,j)*4+a(i+4,j)*2+a(i,j+1)*4+a(i+1,j+1)*9+a(i+2,j+1)*12+a(i+3,j+1)*9+a(i+4,j+1)*4+a(i,j+2)*5+a(i+1,j+2)*12+a(i+2,j+2)*15+a(i+3,j+2)*12+a(i+4,j+2)*5+a(i,j+3)*4+a(i+1,j+3)*9+a(i+2,j+3)*12+a(i+3,j+3)*9+a(i+4,j+3)*4+a(i,j+4)*2+a(i+1,j+4)*4+a(i+2,j+4)*5+a(i+3,j+4)*4+a(i+4,j+4)*2);
    end
end

c=b;
angle=zeros(size(c));
magn=zeros(size(c));
sum=0;
for i=1:size(c,1)-2
    for j=1:size(c,2)-2
        d_x=((-1*c(i,j)-2*c(i+1,j)-1*c(i+2,j))+(1*c(i,j+2)+2*c(i+1,j+2)+1*c(i+2,j+2))); %derivative in x-->s=[-1,-2,-1;0,0,0;1,2,1]
        d_y=((-1*c(i,j)-2*c(i,j+1)-1*c(i,j+2))+(1*c(i+2,j)+2*c(i+2,j+1)+1*c(i+2,j+2)));%derivative in y-->s=[-1,0,1;-2,0,2;-1,0,1]
        mag=sqrt((d_x*d_x)+(d_y*d_y));% taking square root mag
        ang=atan(abs(d_y)/abs(d_x));
        if (ang<45)
            angle(i,j)=0;
        elseif (ang>45)
            angle(i,j)=2;
        end
        magn(i,j)=mag;
        sum=sum+mag;
    end
end
imshow(magn)
sum=0;

k=0;
for i=2:size(c,1)-3
    for j=2:size(c,2)-3
        if angle(i,j)==0
            if (magn(i,j)>=magn(i,j+1) && magn(i,j)>=magn(i,j-1))
                magn(i,j)=magn(i,j);
                sum=(sum+magn(i,j));
                k=k+1;
            else
                magn(i,j)=0;
            end
        else
            if (magn(i,j)>=magn(i+1,j) && magn(i,j)>=magn(i-1,j))
                magn(i,j)=magn(i,j);
                sum=(sum+magn(i,j));
                k=k+1;
            else
                magn(i,j)=0;
            end
        end
    end
end
sum=sum/k;
ans=zeros(size(c));
for i=2:size(magn,1)
    for j=2:size(magn,2)
        if magn(i,j)>sum
            ans(i,j)=255;
        elseif (magn(i,j)>(sum/6) && magn(i,j)<sum)
            if (magn(i-1,j)>sum || magn(i,j-1)>sum || magn(i-1,j-1)>sum)
                ans(i,j)=255;
            else
                ans(i,j)=0;
            end
        else
            ans(i,j)=0;
        end
    end
end

imshow(ans)
                
            
%imshow(magn)
              
            
        
        
        

        