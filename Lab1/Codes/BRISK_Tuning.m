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


features_sift=detectBRISKFeatures(image);
features_sift1=detectBRISKFeatures(image,"MinContrast",0.5);
features_sift2=detectBRISKFeatures(image,"NumOctaves",8);
features_sift3=detectBRISKFeatures(image,"MinQuality",0.5);
%features_sift4=detectSIFTFeatures(image,"Sigma",1.9);



%
%Running time of each algorithm
time_sift = @() detectBRISKFeatures(image);
time_sift1 = @() detectBRISKFeatures(image,"MinContrast",0.5);
time_sift2 = @() detectBRISKFeatures(image,"NumOctaves",8);
time_sift3 = @() detectBRISKFeatures(image,"MinQuality",0.5);
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

title('BRISKDEFAULT')
subplot(242)
imshow(image)
hold on
plot(features_sift1.Location(:,1),features_sift1.Location(:,2),'*r','MarkerSize',4)
hold off
title("MinContrast:0.5")

subplot(243)
imshow(image)
hold on
plot(features_sift2.Location(:,1),features_sift2.Location(:,2),'*r','MarkerSize',4)
hold off
title('NumOctaves:8')

subplot(244)
imshow(image)
hold on
plot(features_sift3.Location(:,1),features_sift3.Location(:,2),'*r','MarkerSize',4)
hold off
title('MinQuality:0.5')