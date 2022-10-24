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


features_sift=detectSURFFeatures(image);
features_sift1=detectSURFFeatures(image,"MetricThreshold",500);
features_sift2=detectSURFFeatures(image,"NumOctaves",1);
features_sift3=detectSURFFeatures(image,"NumScaleLevels",6);
%features_sift4=detectSIFTFeatures(image,"Sigma",1.9);



%
%Running time of each algorithm
time_sift = @() detectSURFFeatures(image);
time_sift1 = @() detectSURFFeatures(image,"MetricThreshold",500);
time_sift2 = @() detectSURFFeatures(image,"NumOctaves",1);
%Error using detectSIFTFeatures>parseInputs
%'NumLayersInOctaves' is not a recognized parameter. For a list of valid name-value pair
%arguments, see the documentation for this function.
time_sift3 = @() detectSURFFeatures(image,"NumScaleLevels",6);
%time_sift4 = @() detectSIFTFeatures(image,"Sigma",1.9);

display(timeit(time_sift));
display(timeit(time_sift1));
display(timeit(time_sift2));
display(timeit(time_sift3));
%display(timeit(time_sift4));

%%


%--------------------------------------------------------------------------
% Visualize a qualitative comparison between feature detection methods
figure(1)
subplot(241)
imshow(image)
hold on
plot(features_sift.Location(:,1),features_sift.Location(:,2),'*r','MarkerSize',4)
hold off

title('SURFDEFAULT')
subplot(242)
imshow(image)
hold on
plot(features_sift1.Location(:,1),features_sift1.Location(:,2),'*r','MarkerSize',4)
hold off
title('MetricThreshold:500')

subplot(243)
imshow(image)
hold on
plot(features_sift2.Location(:,1),features_sift2.Location(:,2),'*r','MarkerSize',4)
hold off
title('NumOctaves:1')

subplot(244)
imshow(image)
hold on
plot(features_sift3.Location(:,1),features_sift3.Location(:,2),'*r','MarkerSize',4)
hold off
title('NumScaleLevels:6')