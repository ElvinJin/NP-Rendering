function L = directions(sketchSize)

	%% Create ds for 8 directions
	center = ceil(sketchSize/2);

	% 0 degree
	L{1} = zeros(sketchSize, sketchSize);
	L{1}(center,:) = 1/sketchSize;

	for i = 2:8
		L{i} = imrotate(L{1}, 22.5);
		[h, w] = size(L{i});
		if h ~= sketchSize
			startIndex = (h-sketchSize)/2 + 1;
			startIndex = floor(startIndex);
			L{i} = L{i}(startIndex : startIndex+sketchSize - 1, startIndex : startIndex+sketchSize - 1);
		end
	end
end