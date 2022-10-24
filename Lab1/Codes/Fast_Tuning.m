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


features_fast=detectFASTFeatures(image);
features_fast1=detectFASTFeatures(image,"MinContrast",0.25);
features_fast2=detectFASTFeatures(image,"MinQuality",0.5);



%
%Running time of each algorithm
time_fast = @() detectFASTFeatures(image);
time_sift = @() detectFASTFeatures(image,"MinContrast",0.25);
time_surf = @() detectFASTFeatures(image,"MinQuality",0.5);

display(timeit(time_fast));
display(timeit(time_sift));
display(timeit(time_surf));

%%


%--------------------------------------------------------------------------
% Visualize a qualitative comparison between feature detection methods
figure(1)
subplot(241)
imshow(image)
hold on
plot(features_fast.Location(:,1),features_fast.Location(:,2),'*r','MarkerSize',4)
hold off

title('DEFAULT')
subplot(242)
imshow(image)
hold on
plot(features_fast1.Location(:,1),features_fast1.Location(:,2),'*r','MarkerSize',4)
hold off
title('MinContrast:0.25')

subplot(243)
imshow(image)
hold on
plot(features_fast2.Location(:,1),features_fast2.Location(:,2),'*r','MarkerSize',4)
hold off
title('MinQuality:0.3')


