function result = convertLAB(filename)
    rgbImage = im2double(imread(filename));
    colorTransform = makecform('srgb2lab');
    lab = applycform(rgbImage, colorTransform);
    L_Image = lab(:, :, 1);  % Extract the L image.
    A_Image = lab(:, :, 2);  % Extract the A image.
    B_Image = lab(:, :, 3);  % Extract the B image.
    result = [L_Image, A_Image, B_Image];
end