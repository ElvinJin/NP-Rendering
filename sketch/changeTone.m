function P = changeTone(grayImg)
	[h,w] = size(grayImg);

	% P{1} P{2} P{3}
	P{1} = zeros(h,w);
	P{2} = zeros(h,w);
	P{3} = zeros(h,w);

    for i=1:h
        for j=1:w

        	v = grayImg(i,j) * 255;

        	% P{1}
            if v <= 255
                P{1}(i,j) = exp((v - 255)/9.0)/9.0;
            end

            % P{2}
            ua = 105.0;
            ub = 225.0;
            if v >= ua && v <= ub
            	P{2}(i,j) = 1 /(225.0 - 105.0);
            end

            % P{3}
            P{3}(i,j) = (1/sqrt(2*pi*11*11))*exp((0 - (v - 90.0)^2)/(2*11*11));
        end
    end

    P{1} = mat2gray(P{1});
    P{2} = mat2gray(P{2}).*0.8;
    P{3} = mat2gray(P{3});


    % figure, imshow(P{2});

end