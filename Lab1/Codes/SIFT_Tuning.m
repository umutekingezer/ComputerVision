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


features_sift=detectSIFTFeatures(image);
features_sift1=detectSIFTFeatures(image,"ContrastThreshold",0.05);
features_sift2=detectSIFTFeatures(image,"EdgeThreshold",17);
%features_sift3=detectSIFTFeatures(image,"NumLayersInOctaves",5);
features_sift4=detectSIFTFeatures(image,"Sigma",1.9);



%
%Running time of each algorithm
time_sift = @() detectSIFTFeatures(image);
time_sift1 = @() detectSIFTFeatures(image,"ContrastThreshold",0.05);
time_sift2 = @() detectSIFTFeatures(image,"EdgeThreshold",17);
%Error using detectSIFTFeatures>parseInputs
%'NumLayersInOctaves' is not a recognized parameter. For a list of valid name-value pair
%arguments, see the documentation for this function.
%time_sift3 = @() detectSIFTFeatures(image,"NumLayersInOctaves",5);
time_sift4 = @() detectSIFTFeatures(image,"Sigma",1.9);

display(timeit(time_sift));
display(timeit(time_sift1));
display(timeit(time_sift2));
%display(timeit(time_sift3));
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

title('DEFAULT')
subplot(242)
imshow(image)
hold on
plot(features_sift1.Location(:,1),features_sift1.Location(:,2),'*r','MarkerSize',4)
hold off
title('ContrastThreshold:0.05')

subplot(243)
imshow(image)
hold on
plot(features_sift2.Location(:,1),features_sift2.Location(:,2),'*r','MarkerSize',4)
hold off
title('EdgeThreshold:17')

subplot(244)
imshow(image)
hold on
plot(features_sift4.Location(:,1),features_sift4.Location(:,2),'*r','MarkerSize',4)
hold off
title('Sigma:1.9')