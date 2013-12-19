function L = directions(sketchSize)

	%% Create ds for 8 directions
	center = ceil(sketchSize/2);

	% 0 degree
	L{1} = zeros(sketchSize, sketchSize);
	L{1}(center,:) = 0.5/sketchSize;
	L{1}(center-1,:) = 0.5/sketchSize;

	% 22.5 degrees
	L{2} = zeros(sketchSize, sketchSize);
	for y = center:sketchSize
		x = ceil(center - (y - center)*tan(pi/8));
		L{2}(x, y) = 0.5/sketchSize;
		L{2}(x-1, y) = 0.5/sketchSize;
	end
	for y = center-1:-1:1
		x = ceil(center + (center - y)*tan(pi/8));
		L{2}(x, y) = 0.5/sketchSize;
		L{2}(x-1, y) = 0.5/sketchSize;
	end

	% 45 degrees
	L{3} = zeros(sketchSize, sketchSize);
	L{3}(sub2ind(size(L{3}), 2:sketchSize, sketchSize:-1:2)) = 0.5/sketchSize;
	L{3}(sub2ind(size(L{3}), 1:sketchSize, sketchSize:-1:1)) = 0.5/sketchSize;

	% 67.5 degrees
	count = 0;
	L{4} = zeros(sketchSize, sketchSize);
	for y = center:sketchSize
		x = ceil(center - (y - center)*tan(pi*3/8));
		if x > 0
			L{4}(x, y) = 1;
			L{4}(x, y-1) = 1;
			count = count + 1;
		else
			break;
		end
	end
	for y = center-1:-1:1
		x = ceil(center + (center - y)*tan(pi*3/8));
		if x <= sketchSize
			L{4}(x, y) = 1;
			L{4}(x, y-1) = 1;
			count = count + 1;
		else
			break;
		end
	end
	L{4} = L{4}./(2*count);

	% 90 degrees
	L{5} = zeros(sketchSize, sketchSize);
	L{5}(:,center-1) = 0.5/sketchSize;
	L{5}(:,center) = 0.5/sketchSize;

	% 112.5 degrees
	count = 0;
	L{6} = zeros(sketchSize, sketchSize);
	for y = center:sketchSize
		x = ceil(center + (y - center)*tan(pi*3/8));
		if x <= sketchSize
			L{6}(x, y) = 1;
			L{6}(x, y-1) = 1;
			count = count + 1;
		else
			break;
		end
	end
	for y = center-1:-1:1
		x = ceil(center - (center - y)*tan(pi*3/8));
		if x > 0
			L{6}(x, y) = 1;
			L{6}(x, y-1) = 1;
			count = count + 1;
		else
			break;
		end
	end
	L{6} = L{6}./(2*count);

	% 135 degrees
	L{7} = zeros(sketchSize, sketchSize);
	L{7}(sub2ind(size(L{7}), 1:sketchSize, 1:sketchSize)) = 0.5/sketchSize;
	L{7}(sub2ind(size(L{7}), 2:sketchSize, 1:sketchSize-1)) = 0.5/sketchSize;

	% 157.5 degrees
	L{8} = zeros(sketchSize, sketchSize);
	for y = center:sketchSize
		x = ceil(center + (y - center)*tan(pi/8));
		L{8}(x, y) = 0.5/sketchSize;
		L{8}(x-1, y) = 0.5/sketchSize;
	end
	for y = center-1:-1:1
		x = ceil(center - (center - y)*tan(pi/8));
		L{8}(x, y) = 0.5/sketchSize;
		L{8}(x-1, y) = 0.5/sketchSize;
	end
end