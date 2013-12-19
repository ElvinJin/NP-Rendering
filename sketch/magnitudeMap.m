function C = magnitudeMap(G, gradientImg)
	[h, w] = size(G{1});

	for i = 1:h
		for j = 1:w
			valueVec = [G{1}(i,j),G{2}(i,j),G{3}(i,j),G{4}(i,j),G{5}(i,j),G{6}(i,j),G{7}(i,j),G{8}(i,j)];
			maxValue = max(valueVec);
			for x = 1:8
				C{x}(i,j) = 0;
			end
			for x = 1:8
				if G{x}(i,j) == maxValue
					C{x}(i,j) = gradientImg(i,j);
					break;
				end
			end
		end
	end

end