clear all
clc
close all

addpath data


% Load input image
image=imread('sunflower.jpg');

if (size(image,3))
    image=rgb2gray(image);
end

% Computing point features by using different detection strategies
%
% MISSING CODE: TUNE THE ARGUMENTS FOR every XXX


features_sift=detectKAZEFeatures(image);
features_sift1=detectKAZEFeatures(image,"Diffusion","edge");
features_sift2=detectKAZEFeatures(image,"Threshold",0.001);
features_sift3=detectKAZEFeatures(image,"NumOctaves",4);
features_sift4=detectKAZEFeatures(image,"NumScaleLevels",10);



%
%Running time of each algorithm
time_sift = @() detectKAZEFeatures(image);
time_sift1 = @() detectKAZEFeatures(image,"Diffusion","edge");
time_sift2 = @() detectKAZEFeatures(image,"Threshold",0.001);
%Error using detectSIFTFeatures>parseInputs
%'NumLayersInOctaves' is not a recognized parameter. For a list of valid name-value pair
%arguments, see the documentation for this function.
time_sift3 = @() detectKAZEFeatures(image,"NumOctaves",4);
time_sift4 = @() detectKAZEFeatures(image,"NumScaleLevels",8);

display(timeit(time_sift));
display(timeit(time_sift1));
display(timeit(time_sift2));
display(timeit(time_sift3));
display(timeit(time_sift4));

%%


%--------------------------------------------------------------------------
% Visualize a qualitative comparison between feature detection methods
figure(1)
subplot(241)
imshow(image)
hold on
plot(features_sift.Location(:,1),features_sift.Location(:,2),'*r','MarkerSize',4)
hold off

title('KAZEDEFAULT')
subplot(242)
imshow(image)
hold on
plot(features_sift1.Location(:,1),features_sift1.Location(:,2),'*r','MarkerSize',4)
hold off
title('Diffusion:edge')

subplot(243)
imshow(image)
hold on
plot(features_sift2.Location(:,1),features_sift2.Location(:,2),'*r','MarkerSize',4)
hold off
title('Threshold:0.001')

subplot(244)
imshow(image)
hold on
plot(features_sift3.Location(:,1),features_sift3.Location(:,2),'*r','MarkerSize',4)
hold off
title('NumOctaves:4')

subplot(245)
imshow(image)
hold on
plot(features_sift4.Location(:,1),features_sift4.Location(:,2),'*r','MarkerSize',4)
hold off
title('"NumScaleLevels:8')