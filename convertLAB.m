function [l,a,b] = convertLAB(filename)
    rgbImage = im2double(imread(filename));
    colorTransform = makecform('srgb2lab');
    lab = applycform(rgbImage, colorTransform);
    l = lab(:, :, 1);  % Extract the L image.
    a = lab(:, :, 2);  % Extract the A image.
    b = lab(:, :, 3);  % Extract the B image.
    l = (l - min(min(l)))/(max(max(l)) - min(min(l))); %Normalize.
    a = (a - min(min(a)))/(max(max(a)) - min(min(a)));
    b = (b - min(min(b)))/(max(max(b)) - min(min(b)));
end