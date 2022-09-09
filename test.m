clear;
clc;
close all;
d=20;



%检测图
file1={'max_mean','LCM','IPI','nipps','NRAM','PSTNN','ECA_STT','RIPT','ASTTV_NTLA'};
for i=1:9
I=imread(['D:\实验\seq4\' file1{i} '.bmp']);
I=double(I);
mean1=mean(I(:));
sigma=std2(I);
I_detect=I>(mean1+sigma*4);

[L,nm] = bwlabel(I_detect,8);%找到连通域
re=L(125:129,91:95);
j=max(re(:));
[r,c] = find(L == j);
left = min(c);
right = max(c);
top = min(r);
down = max(r);
 % 目标区域
I1o=I(top:down,left:right);
      %邻域
I2_1=I(top-d:top-1,left-d:right+d);
I2_2=I(down+1:down+d,left-d:right+d);
I2_3=I(top:down,left-d:left-1);
I2_4=I(top:down,right+1:right+d);
I2=[I2_1(:);I2_2(:);I2_3(:);I2_4(:)];
miu_to=mean(mean(I1o));
miu_bo=mean(I2);
        
sigma_bo=std2(I2);
SCR_out=abs(miu_to-miu_bo)/sigma_bo;
        
  %原图
  I0=imread('D:\实验\seq4\1.bmp');
   [~, ~, ch]=size(I0);
   if ch==3
       I0=rgb2gray(I0);
   end
        
  % 目标区域
  I1=I0(top:down,left:right);
  %邻域
  I20_1=I0(top-d:top-1,left-d:right+d);
  I20_2=I0(down+1:down+d,left-d:right+d);
  I20_3=I0(top:down,left-d:left-1);
  I20_4=I0(top:down,right+1:right+d);
  I20=[I20_1(:);I20_2(:);I20_3(:);I20_4(:)];
  miu_t=mean(mean(I1));
  miu_b=mean(I20);
  sigma_b=std2(I20);
  
  SCR_in=abs(miu_t-miu_b)/sigma_b;
   %SCRG
  SCRG(i)=SCR_out/SCR_in;
   %BSF
  BSF(i)=sigma_b/sigma_bo;
end

