function B = main(filename, w, sigma)
I=imread(filename);
I= im2double(I);
I1=bfilter2(I,w,sigma);
[l,a,b] = convertLAB(I1);
I1 = quantization(I1,4);
%imshow(I1);
I2 = DoG(l,1.0,1.7,0.98);
I2 = smmoth(I2);
new(:,:,1) = I1(:,:,1) .* I2;
new(:,:,2) = I1(:,:,2) .* I2;
new(:,:,3) = I1(:,:,3) .* I2;
imshow(new);
%I4 = combine(I1,I2);

%imshow(I4);
imwrite(new,'result.jpg');
end