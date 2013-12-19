function mixedP = createMixedP

	% P{1} P{2} P{3}
	P{1} = zeros(1,256);
	P{2} = zeros(1,256);
	P{3} = zeros(1,256);

    for i = 1:256
    	% P{1}
    	P{1}(i) = (exp((i - 256)/9.0))/9.0;

    	% P{2}
    	if i >= 105 && i <= 225
    		P{2}(i) = 1.0/(225.0 - 105.0);
    	end

    	% P{3}
    	P{3}(i) = (1/sqrt(242*pi)) * exp((i-90)*(i-90)/-242.0);
    end

    mixedP = P{1}*52 + P{2}*37 + P{3}*11;
    mixedP = mixedP / sum(mixedP);

end