%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%              LABORATORY 1
%%%              COMPUTER VISION 2021-2022
%%%              FEATURE DETECTION AND COMPARISON
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear all
clc
close all

addpath data


% Load input image
image=imread('scaled.jpg');

if (size(image,3))
    image=rgb2gray(image);
end

% Computing point features by using different detection strategies
%
% MISSING CODE: TUNE THE ARGUMENTS FOR every XXX


features_fast=detectFASTFeatures(image);
features_sift=detectSIFTFeatures(image);
features_surf=detectSURFFeatures(image);
features_kaze=detectKAZEFeatures(image);
features_brisk= detectBRISKFeatures(image)
features_orb=detectORBFeatures(image);
features_harris=detectHarrisFeatures(image);
features_mser=detectMSERFeatures(image);
%
%Running time of each algorithm
time_fast = @() detectFASTFeatures(image);
time_sift = @() detectSIFTFeatures(image);
time_surf = @() detectSURFFeatures(image);
time_kaze = @() detectKAZEFeatures(image);
time_brisk = @() detectBRISKFeatures(image)
time_orb = @() detectORBFeatures(image);
time_harris = @() detectHarrisFeatures(image);
time_mser = @() detectMSERFeatures(image);

display(timeit(time_fast));
display(timeit(time_sift));
display(timeit(time_surf));
display(timeit(time_kaze));
display(timeit(time_brisk));
display(timeit(time_orb));
display(timeit(time_harris));
display(timeit(time_mser));

%%


%--------------------------------------------------------------------------
% Visualize a qualitative comparison between feature detection methods
figure(1)
subplot(241)
imshow(image)
hold on
plot(features_fast.Location(:,1),features_fast.Location(:,2),'*r','MarkerSize',4)
hold off

title('FAST')
subplot(242)
imshow(image)
hold on
plot(features_sift.Location(:,1),features_sift.Location(:,2),'*r','MarkerSize',4)
hold off
title('SIFT')

subplot(243)
imshow(image)
hold on
plot(features_surf.Location(:,1),features_surf.Location(:,2),'*r','MarkerSize',4)
hold off
title('SURF')




subplot(244)
imshow(image)
hold on
plot(features_kaze.Location(:,1),features_kaze.Location(:,2),'*r','MarkerSize',4)
hold off
title("KAZE")






subplot(245)
imshow(image)
hold on
plot(features_brisk.Location(:,1),features_brisk.Location(:,2),'*r','MarkerSize',4)
hold off
title('BRISK')
subplot(246)
imshow(image)
hold on
plot(features_orb.Location(:,1),features_orb.Location(:,2),'*r','MarkerSize',4)
hold off
title('ORB')
subplot(247)
imshow(image)
hold on
plot(features_harris.Location(:,1),features_harris.Location(:,2),'*r','MarkerSize',4)
hold off
title('HARRIS')
subplot(248)
imshow(image)
hold on
plot(features_mser.Location(:,1),features_mser.Location(:,2),'*r','MarkerSize',4)
hold off
title('MSER')

%--------------------------------------------------------------------------

