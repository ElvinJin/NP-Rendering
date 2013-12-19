function X = sketch(filename)

	I = rgb2gray(im2double(imread(filename)));

	[h,w] = size(I);
	if h < w
		sketchSize = ceil(h/30);
	else
		sketchSize = ceil(w/30);
	end

	%% Step 1
	% Create gradient of the image
	[x, y] = gradient(I);
	gradientImg = sqrt(x.*x + y.*y);
	gradientImg = mat2gray(gradientImg,[0.02, 0.28]); % Scale the gradient img

	% Built 8 directions
	L = directions1(sketchSize);

	% Greate response map G{i} = L{i} * gradientImg
	for i = 1:8
		G{i} = conv2(gradientImg, L{i}, 'same');
		% figure, imshow(G{i});
	end

	% Create magnitude map for all the directions
	C = magnitudeMap(G, gradientImg);

	%% Step 2
	S = zeros(h,w);
	for i = 1:8
		S = S + conv2(C{i}, L{i}, 'same');
	end
	stroke = ones(h,w) - S;
	imshow(stroke);

	% imshow(I4);
	% imwrite(new,'result.jpg');
end