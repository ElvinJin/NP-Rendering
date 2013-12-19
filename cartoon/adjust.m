function adjust(filename)
sourcePic = imread(filename); %¶ÁÈ¡Ô­Í¼Ïó

[m,n,o]=size(sourcePic);

grayPic=rgb2gray(sourcePic);

figure,imshow(sourcePic);

figure,imshow(grayPic);

gp=zeros(1,256); %¼ÆËã¸÷»Ò¶È³öÏÖµÄ¸ÅÂÊ

for i=1:256

gp(i)=length(find(grayPic==(i-1)))/(m*n);

end

figure,bar(0:255,gp);

title('Ô­Í¼ÏñÖ±·½Í¼');

xlabel('»Ò¶ÈÖµ');

ylabel('³öÏÖ¸ÅÂÊ');
 %¼ÆËãÐÂµÄ¸÷»Ò¶È³öÏÖµÄ¸ÅÂÊ

S1=zeros(1,256);
S2=zeros(1,256);
S3=zeros(1,256);
S4=zeros(1,256);

for i=1:256
    S2(i) = (exp((i - 256)/9.0))/9.0;
end
S2 = S2 * 52;
for i = 106:226
    S3(i) = 1.0/(225.0 - 105.0);
end
S3 = S3 * 37;
for i=1:256
    S4(i) = 1/sqrt(2*3.14*121) * exp((i-90)*(i-90)/-242.0);
end
S4 = S4 * 11;
S1 = (S2 + S3 + S4)/(sum(S2)+sum(S3)+sum(S4));

new = histeq(grayPic,S1);
imwrite(new,'my.jpg');
figure,imshow(new);
gp=zeros(1,256); %¼ÆËã¸÷»Ò¶È³öÏÖµÄ¸ÅÂÊ

for i=1:256

gp(i)=length(find(new==(i-1)))/(m*n);

end

figure,bar(0:255,gp);

title('Í¼ÏñÖ±·½Í¼');

xlabel('»Ò¶ÈÖµ');

ylabel('³öÏÖ¸ÅÂÊ');

end