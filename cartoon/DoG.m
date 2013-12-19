function d = DoG(img,sigma1,sigma2,t)
    gaussian1 = fspecial('gaussian',5,sigma1);
    gaussian2 = fspecial('gaussian',5,sigma2);
    d = imfilter(img,gaussian1) - imfilter(img,gaussian2) * t;
    end