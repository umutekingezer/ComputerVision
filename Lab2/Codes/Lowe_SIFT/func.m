%The Matlab function which takes two images and Ground Truth file ,and outputs
%Umut Ekin Gezer    u195839
%Ekaterina Erofeeva u204256


function [H,error] = func(image1, image2,GT_file)

[desc1 loca1 desc2 loca2 matchings mnb] = match(image1, image2);
[pts1 pts2]=get_matching_pts(loca1, loca2, matchings);
[H, inliers] = ransacfithomography(pts1, pts2, 0.005)


matrix=readmatrix(GT_file)


error=H-matrix
end