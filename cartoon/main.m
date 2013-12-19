function B = main(filename, sigma, w, e, s, lvl)
I=imread(filename);
I= im2double(I);
I1=bfilter2(I,w,sigma);
[l,a,b] = convertLAB(I1);
I1 = quantization(I1,5,s);
%imshow(I1);
I2 = DoG(lvl,1.0,e,0.98);
I2 = smooth(I2);
new(:,:,1) = I1(:,:,1) .* I2;
new(:,:,2) = I1(:,:,2) .* I2;
new(:,:,3) = I1(:,:,3) .* I2;
imshow(new);
%I4 = combine(I1,I2);

%imshow(I4);
imwrite(new,'result.jpg');
end