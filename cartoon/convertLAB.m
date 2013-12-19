function [l,a,b] = convertLAB(rgbImage)
    colorTransform = makecform('srgb2lab');
    lab = applycform(rgbImage, colorTransform);
    l = lab(:, :, 1);  % Extract the L image.
    a = lab(:, :, 2);  % Extract the A image.
    b = lab(:, :, 3);  % Extract the B image.
end