function r = quantization(img,q,n)
    [l,a,b] = convertLAB(img);
    [h,w] = size(l);
    lmax = max(max(l));
    lmin = min(min(l));
    dq = (lmax - lmin)/q;
    i = 1;
    next = lmin;
    while next <= lmax 
        level(i) = next;
        next = next + dq;
        i = i + 1;
    end
    level(i) = 100;
    for i = 1:h
        for j = 1:w
            for k = 1:q
                if(level(k) <= l(i,j) && l(i,j) <= level(k+1))
                    l(i,j) = tanh(n*(l(i,j)-(level(k)+level(k+1))/2))/dq + (level(k)+level(k+1))/2;
                    
                end
            end
        end
    end
    %r = imquantize(img,level);
    lab(:,:,1) = l;
    lab(:,:,2) = a;
    lab(:,:,3) = b;
    colorTransform = makecform('lab2srgb');
    r = applycform(lab, colorTransform);
    %imshow(r);
end