function d = DoG(img,sigma1,sigma2,t)
    gaussian1 = fspecial('gaussian',5,sigma1);
    gaussian2 = fspecial('gaussian',5,sigma2);
    d = imfilter(img,gaussian1) - imfilter(img,gaussian2) * t;
    [h,w,c] = size(d);
    for i=1:h
        for j=1:w
            for k=1:c
                if d(i,j,k) > 0
                    d(i,j,k) = 1;
                end
            end
        end
    end
    
end