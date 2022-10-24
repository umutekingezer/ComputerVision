%Umut Ekin Gezer    u195839
%Ekaterina Erofeeva u204256


clear all
close all
clc

addpath('../lib/');
%addpath("../Lowe_SIFT/");

addpath('../data_set/bikes/');
error=[];
final_error_bk=read_folders(error);

addpath('../data_set/boat/');
error=[];
final_error_boat=read_folders(error);

addpath('../data_set/graf/');
error=[];
final_error_graf=read_folders(error);

addpath('../data_set/leuven/');
error=[];
final_error_leuven=read_folders(error);


%We implemented a function that to the firrst image and all other images in a certain sub-folder
function[error_new]=read_folders(error)

%We read the first image out of the loop:
T1=imread("img1.ppm");
imwrite(T1,"image1.pgm");


image_count=6 ;

for i=2:image_count
    
    %i=num2str(i)
    %Then we read whole images to calculate estimated homography
    T=imread(['img',num2str(i),'.ppm']);
    imwrite(T,['image',num2str(i),'.pgm']);
    
    %We read H1to2´,H1to3,H1to4,H1to5,H1to6
    H1to_matrix=['H1to',num2str(i),'p'];
    %We use the function that we implemented in first task which is in the
    %file func.m
    [H1to,error1to2] = func('image1.pgm',['image',num2str(i), '.pgm'],H1to_matrix);
    
    %Now we use imTrans function as input first image and H1to Matrix 
    [newim1to,newT1to] = imTrans(T1,H1to);
    
    
    %We convert into the matrix 
    matrix=readmatrix(H1to_matrix);
    %We applied to function imTrans again 
    [newimGT12,newTGT1to]=imTrans(T1,matrix) ;
    
    
    %Then we plot the figures: 
    figure
    subplot(1,2,1) ;
    imshow(newim1to)  ;
    subplot(1,2,2) ;
    imshow(newimGT12);
    
   %At the end we calculate the error between the computed homographies and the ground truth ones. 
   error=[error,newTGT1to-newT1to] ;
   
   
   error_new=error
   
end

end


    




