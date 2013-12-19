function X = sketch(originalImg)
	I = rgb2gray(im2double(originalImg));
%%%
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
	gradientImg = mat2gray(gradientImg,[0.02 0.35]); % Scale the gradient img

	% Built 8 directions
	L = directions(sketchSize);

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
%%%
	%% Step 3
	% Create 3 tone P
	mixedP = createMixedP;

	%% Step 4
	shadeImg = histeq(I, mixedP);

	% imshow(shadeImg);

	% imshow(I4);
%%%
	% Cut pencil texture
	J = shadeImg;
	textureSource = im2double(imread('pencil.png'));
	H = textureSource(1:h, 1:w);

	% Texture Rendering
	B = 0.2:0.2:2;

	part2 = 0.2*norm(gradient(B),2)^2;

	for i = 1:h
		for j = 1:w
			for x = 1:10
				vector(x) = norm((0.2 * x * log(H(i,j)) - log(J(i,j))),2)^2;
			end
			minValue = min(vector);
			for x = 1:10
				if vector(x) == minValue
					part1 = 0.2*x;
					break;
				end
			end
			Bstar(i,j) = part1+part2;
		end
	end

	T = H .^ Bstar;
	% T = mat2gray(T);
	% figure,imshow(T);

	% Step 6
	X = stroke .* T;



end