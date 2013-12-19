function varargout = UI(varargin)
% UI MATLAB code for UI.fig
%      UI, by itself, creates a new UI or raises the existing
%      singleton*.
%
%      H = UI returns the handle to a new UI or the handle to
%      the existing singleton*.
%
%      UI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UI.M with the given input arguments.
%
%      UI('Property','Value',...) creates a new UI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before UI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to UI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help UI

% Last Modified by GUIDE v2.5 19-Dec-2013 22:46:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @UI_OpeningFcn, ...
                   'gui_OutputFcn',  @UI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before UI is made visible.
function UI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to UI (see VARARGIN)

% Choose default command line output for UI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes UI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = UI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in openbutton.
function openbutton_Callback(hObject, eventdata, handles)
% hObject    handle to openbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile({'*.jpg';'*.bmp';'*.gif';'*.png'},'选择图片');
if isequal(filename,0)
    disp('Users Selected Canceled');
else
str=[pathname filename];
im = imread(str);
axes(handles.picture);%axes1是坐标轴的标示
imshow(im);
end;

% --- Executes on button press in cartoon.
function pencil_Callback(hObject, eventdata, handles)
% hObject    handle to cartoon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
px=getframe(handles.picture);
new = sketch(px.cdata);
imshow(new);



% --- Executes on button press in pencil.
function cartoon_Callback(hObject, eventdata, handles)
% hObject    handle to pencil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
px=getframe(handles.picture);
cartoon(px.cdata,[3,0.1],3,1.27,10,6);


% --- Executes on button press in savebutton.
function savebutton_Callback(hObject, eventdata, handles)
% hObject    handle to savebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uiputfile({'*.bmp';},'保存图片','Undefined.bmp');
if ~isequal(filename,0)
    str = [pathname filename];
    px=getframe(handles.picture);
    %saveas(gcf,str,'bmp');
    %px.cdata = getappdata(gcf,'Timg');
    imwrite(px.cdata,str,'bmp');
else
    disp('Failed to save the picture.');
end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function new = adjust(img)
grayPic = rgb2gray(img);
S1=zeros(1,256);
S2=zeros(1,256);
S3=zeros(1,256);
S4=zeros(1,256);

for i=1:256
    S2(i) = (exp((i - 256)/9.0))/9.0;
end
S2 = S2 * 52;
for i = 106:226
    S3(i) = 1.0/(225.0 - 105.0);
end
S3 = S3 * 37;
for i=1:256
    S4(i) = 1/sqrt(2*3.14*121) * exp((i-90)*(i-90)/-242.0);
end
S4 = S4 * 11;
S1 = (S2 + S3 + S4)/(sum(S2)+sum(S3)+sum(S4));

new = histeq(grayPic,S1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function cartoon(img, sigma, w, e, s, lvl)
I= im2double(img);
I1=bfilter2(I,w,sigma);
[l,a,b] = convertLAB(I1);
I2 = DoG(l,1.0,5,0.98);
I1 = quantization(I1,3,10);
I2 = smooth(I2);
new(:,:,1) = I1(:,:,1) .* I2;
new(:,:,2) = I1(:,:,2) .* I2;
new(:,:,3) = I1(:,:,3) .* I2;
imshow(new);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function B = bfilter2(A,w,sigma)

% Verify that the input image exists and is valid.
if ~exist('A','var') || isempty(A)
   error('Input image A is undefined or invalid.');
end
if ~isfloat(A) || ~sum([1,3] == size(A,3)) || ...
      min(A(:)) < 0 || max(A(:)) > 1
   error(['Input image A must be a double precision ',...
          'matrix of size NxMx1 or NxMx3 on the closed ',...
          'interval [0,1].']);      
end

% Verify bilateral filter window size.
if ~exist('w','var') || isempty(w) || ...
      numel(w) ~= 1 || w < 1
   w = 5;
end
w = ceil(w);

% Verify bilateral filter standard deviations.
if ~exist('sigma','var') || isempty(sigma) || ...
      numel(sigma) ~= 2 || sigma(1) <= 0 || sigma(2) <= 0
   sigma = [3 0.1];
end

% Apply either grayscale or color bilateral filtering.
if size(A,3) == 1
   B = bfltGray(A,w,sigma(1),sigma(2));
else
   B = bfltColor(A,w,sigma(1),sigma(2));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Implements bilateral filtering for grayscale images.
function B = bfltGray(A,w,sigma_d,sigma_r)

% Pre-compute Gaussian distance weights.
[X,Y] = meshgrid(-w:w,-w:w);
G = exp(-(X.^2+Y.^2)/(2*sigma_d^2));

% Create waitbar.
h = waitbar(0,'Applying bilateral filter...');
set(h,'Name','Bilateral Filter Progress');

% Apply bilateral filter.
dim = size(A);
B = zeros(dim);
for i = 1:dim(1)
   for j = 1:dim(2)
      
         % Extract local region.
         iMin = max(i-w,1);
         iMax = min(i+w,dim(1));
         jMin = max(j-w,1);
         jMax = min(j+w,dim(2));
         I = A(iMin:iMax,jMin:jMax);
      
         % Compute Gaussian intensity weights.
         H = exp(-(I-A(i,j)).^2/(2*sigma_r^2));
      
         % Calculate bilateral filter response.
         F = H.*G((iMin:iMax)-i+w+1,(jMin:jMax)-j+w+1);
         B(i,j) = sum(F(:).*I(:))/sum(F(:));
               
   end
   waitbar(i/dim(1));
end

% Close waitbar.
close(h);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Implements bilateral filter for color images.
function B = bfltColor(A,w,sigma_d,sigma_r)

% Convert input sRGB image to CIELab color space.
if exist('applycform','file')
   A = applycform(A,makecform('srgb2lab'));
else
   A = colorspace('Lab<-RGB',A);
end

% Pre-compute Gaussian domain weights.
[X,Y] = meshgrid(-w:w,-w:w);
G = exp(-(X.^2+Y.^2)/(2*sigma_d^2));

% Rescale range variance (using maximum luminance).
sigma_r = 100*sigma_r;

% Create waitbar.
h = waitbar(0,'Applying bilateral filter...');
set(h,'Name','Bilateral Filter Progress');

% Apply bilateral filter.
dim = size(A);
B = zeros(dim);
for i = 1:dim(1)
   for j = 1:dim(2)
      
         % Extract local region.
         iMin = max(i-w,1);
         iMax = min(i+w,dim(1));
         jMin = max(j-w,1);
         jMax = min(j+w,dim(2));
         I = A(iMin:iMax,jMin:jMax,:);
      
         % Compute Gaussian range weights.
         dL = I(:,:,1)-A(i,j,1);
         da = I(:,:,2)-A(i,j,2);
         db = I(:,:,3)-A(i,j,3);
         H = exp(-(dL.^2+da.^2+db.^2)/(2*sigma_r^2));
      
         % Calculate bilateral filter response.
         F = H.*G((iMin:iMax)-i+w+1,(jMin:jMax)-j+w+1);
         norm_F = sum(F(:));
         B(i,j,1) = sum(sum(F.*I(:,:,1)))/norm_F;
         B(i,j,2) = sum(sum(F.*I(:,:,2)))/norm_F;
         B(i,j,3) = sum(sum(F.*I(:,:,3)))/norm_F;
                
   end
   waitbar(i/dim(1));
end

% Convert filtered image back to sRGB color space.
if exist('applycform','file')
   B = applycform(B,makecform('lab2srgb'));
else  
   B = colorspace('RGB<-Lab',B);
end

% Close waitbar.
close(h);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [l,a,b] = convertLAB(rgbImage)
    colorTransform = makecform('srgb2lab');
    lab = applycform(rgbImage, colorTransform);
    l = lab(:, :, 1);  % Extract the L image.
    a = lab(:, :, 2);  % Extract the A image.
    b = lab(:, :, 3);  % Extract the B image.
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function r = quantization(img,q,n)
    [l,a,b] = convertLAB(img);
    [h,w] = size(l);
    lmax = max(max(l));
    lmin = min(min(l));
    dq = (lmax - lmin)/q;
    i = 1;
    next = lmin;
    while next <= lmax 
        level(i) = next;
        next = next + dq;
        i = i + 1;
    end
    level(i) = 100;
    for i = 1:h
        for j = 1:w
            for k = 1:q
                if(level(k) <= l(i,j) && l(i,j) <= level(k+1))
                    l(i,j) = tanh(n*(l(i,j)-(level(k)+level(k+1))/2))/dq + (level(k)+level(k+1))/2;
                    
                end
            end
        end
    end
    lab(:,:,1) = l;
    lab(:,:,2) = a;
    lab(:,:,3) = b;
    colorTransform = makecform('lab2srgb');
    r = applycform(lab, colorTransform);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function d = DoG(img,sigma1,sigma2,t)
    gaussian1 = fspecial('gaussian',5,sigma1);
    gaussian2 = fspecial('gaussian',5,sigma2);
    d = imfilter(img,gaussian1) - imfilter(img,gaussian2) * t;
   
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



