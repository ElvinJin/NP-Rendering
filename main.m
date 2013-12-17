function B = main()
I=imread('pic/1.jpg');
I=double(I)/255;

w     = 5;       % bilateral filter half-width
sigma = [7 0.0425]; % bilateral filter standard deviations

I1=bfilter2(I,w,sigma);
I1=bfilter2(I1,w,sigma);

imshow(I1);
I2 = DoG(I1,1.0,1.27,0.98);
I3 = tanh(I2);
I4 = combine(I1,I3);
imshow(I4);
imwrite(I1,'result.jpg');
end