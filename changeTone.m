function changeTone(grayImg)
    [h,w] = size(grayImg);
    for i=1:h
        for j=1:w
            if(grayImg(i,j) <= 255)
                grayImg(i,j) = (2.71828 ^((grayImg(i,j) - 255)/11.0))/11;
            end
        end
    end
end