clear all
close all
clc

addpath('../data_set/bikes');
%addpath('../bikes/');
% INPUT DATA: reading pictures
I1=imread('img1.ppm'); % <-- Introduce your picture 1
I2=imread('img2.ppm'); % <-- Introduce your picture 2
imwrite(I1,'image1.pgm');
imwrite(I2,'image2.pgm');


%[im1, des1, loc1] = sift('image1.pgm');
%showkeys(im1,loc1);
%[im2, des2, loc2] = sift('image2.pgm');
%showkeys(im2,loc2);
%matchings=match('image1.pgm','image2.pgm');
%[pts1 pts2]=get_matching_pts(loc1, loc2, matchings);
[desc1 loca1 desc2 loca2 matchings mnb] = match('image1.pgm', 'image2.pgm')
[pts1 pts2]=get_matching_pts(loca1, loca2, matchings);
[H, inliers] = ransacfithomography(pts1, pts2, 0.005)


matrix=readmatrix('H1to2p')


error=H-matrix