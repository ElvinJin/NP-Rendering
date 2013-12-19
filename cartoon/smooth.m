function img = smooth(img)
    [h,w] = size(img);
    for i = 1:h
        for j = 1:w
            if img(i,j) > 0
                img(i,j) = 1;
            else
                img(i,j) = 1 + tanh(img(i,j)*100*1.0);
            end
        end
    end
end