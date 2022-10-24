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

features_sift=detectORBFeatures(image);
features_sift1=detectORBFeatures(image,"ScaleFactor",2);
features_sift2=detectORBFeatures(image,"NumLevels",1);





%
%Running time of each algorithm
time_sift = @() detectORBFeatures(image);
time_sift1 = @() detectORBFeatures(image,"ScaleFactor",2);
time_sift2 = @() detectORBFeatures(image,"NumLevels",1);


display(timeit(time_sift));
display(timeit(time_sift1));
display(timeit(time_sift2));


%%


%--------------------------------------------------------------------------
% Visualize a qualitative comparison between feature detection methods
figure(1)
subplot(241)
imshow(image)
hold on
plot(features_sift.Location(:,1),features_sift.Location(:,2),'*r','MarkerSize',4)
hold off

title('ORBDEFAULT')
subplot(242)
imshow(image)
hold on
plot(features_sift1.Location(:,1),features_sift1.Location(:,2),'*r','MarkerSize',4)
hold off
title("ScaleFactor:2")

subplot(243)
imshow(image)
hold on
plot(features_sift2.Location(:,1),features_sift2.Location(:,2),'*r','MarkerSize',4)
hold off
title("NumLevels:1")

