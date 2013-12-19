function rgbImg = recnonstructLAB(l,a,b)
    lab(:,:,1) = l;
    lab(:,:,2) = a;
    lab(:,:,3) = b;
    colorTransform = makecform('lab2srgb');
    rgbImg = applycform(lab, colorTransform);
end