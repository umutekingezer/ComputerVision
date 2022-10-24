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


features_sift=detectMSERFeatures(image);
features_sift1=detectMSERFeatures(image,"ThresholdDelta",1);
features_sift2=detectMSERFeatures(image,"RegionAreaRange",[100 10000]);
features_sift3=detectMSERFeatures(image,"MaxAreaVariation",0.7);



%
%Running time of each algorithm
time_sift = @() detectMSERFeatures(image);
time_sift1 = @() detectMSERFeatures(image,"ThresholdDelta",1);
time_sift2 = @() detectMSERFeatures(image,"RegionAreaRange",[100 10000]);
time_sift3 = @() detectMSERFeatures(image,"MaxAreaVariation",0.7);

display(timeit(time_sift));
display(timeit(time_sift1));
display(timeit(time_sift2));
display(timeit(time_sift3));


%%


%--------------------------------------------------------------------------
% Visualize a qualitative comparison between feature detection methods
figure(1)
subplot(241)
imshow(image)
hold on
plot(features_sift.Location(:,1),features_sift.Location(:,2),'*r','MarkerSize',1)
hold off

title('MSERDEFAULT')
subplot(242)
imshow(image)
hold on
plot(features_sift1.Location(:,1),features_sift1.Location(:,2),'*r','MarkerSize',1)
hold off
title('"ThresholdDelta:1')

subplot(243)
imshow(image)
hold on
plot(features_sift2.Location(:,1),features_sift2.Location(:,2),'*r','MarkerSize',1)
hold off
title('RegionAreaRange:[100 10000]')

subplot(244)
imshow(image)
hold on
plot(features_sift3.Location(:,1),features_sift3.Location(:,2),'*r','MarkerSize',1)
hold off
title('MaxAreaVariation:0.7')