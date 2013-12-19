function r = combine(img1,img2)
    [h,w,c] = size(img1);
    for i=1:h
        for j=1:w
            for k=1:c
                if img2(i,j,k) < 0
                    r(i,j,1:end) = 0;
                else
                    r(i,j,k) = img1(i,j,k);
                end
            end
        end
    end
end