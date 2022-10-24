%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%              LABORATORY #4 
%%%              COMPUTER VISION 2021-2022
%%%              Face Detection 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function IntegralImages = GetIntergralImages2(Picture,Options)
% Make integral image from a Picture
%
%
% Convert the Picture to double 
% (grey-level scaling doesn't influence the result, thus 
% double instead of im2double can also be used)
Picture=im2double(Picture);

% Resize the image to decrease the processing-time
if(Options.Resize)
    if (size(Picture,2) > size(Picture,1)),
        Ratio = size(Picture,2) / 384;
    else
        Ratio = size(Picture,1) / 384;
    end
    Picture = imresize(Picture, [size(Picture,1) size(Picture,2) ]/ Ratio);
else
    Ratio=1;
end

% Convert the picture to greyscale (this line is the same as rgb2gray, see help)
if(size(Picture,3)>1),
    Picture=0.2989*Picture(:,:,1) + 0.5870*Picture(:,:,2)+ 0.1140*Picture(:,:,3);
end

% Make the integral image for fast region sum look up

%commulative sum over rows of the picture
s = Picture(:,:);
for i = 1:size(s,1)
    for j = 2:size(s,2)
        s(i,j) = s(i,j) + s(i,j-1);
    end
end

%commulative sum over columns of the picture
IntegralImages.ii = s(:,:);
for i = 2:size(s,1)
    for j = 1:size(s,2)
        IntegralImages.ii(i,j) = IntegralImages.ii(i - 1,j) + IntegralImages.ii(i,j);
    end
end

IntegralImages.ii=padarray(IntegralImages.ii,[1 1], 0, 'pre');

% Make integral image to calculate fast a local standard deviation of the
% pixel data
p = Picture.^2;
s = p(:,:);
for i = 1:size(s,1)
    for j = 2:size(s,2)
        s(i,j) = s(i,j) + s(i,j-1);
    end
end

IntegralImages.ii2 = s(:,:);
for i = 2:size(s,1)
    for j = 1:size(s,2)
        IntegralImages.ii2(i,j) = IntegralImages.ii2(i - 1,j) + IntegralImages.ii2(i,j);
    end
end

IntegralImages.ii2=padarray(IntegralImages.ii2,[1 1], 0, 'pre');

% Store other data
IntegralImages.width = size(Picture,2);
IntegralImages.height = size(Picture,1);
IntegralImages.Ratio=Ratio;
