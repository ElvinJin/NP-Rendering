function B = main()
I=imread('pic/1.jpg');
I=double(I)/255;

w     = 3;       % bilateral filter half-width
sigma = [3 0.1]; % bilateral filter standard deviations

I1=bfilter2(I,w,sigma);

imshow(I1);
I2 = DoG(I1,1.0,1.27,0.98);
I3 = tanh(I2);
I4 = combine(I1,I3);

%imshow(I1);
imwrite(I4,'result.jpg');
end