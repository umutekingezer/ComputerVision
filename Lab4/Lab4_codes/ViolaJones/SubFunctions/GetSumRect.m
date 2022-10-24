%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%              LABORATORY #4 
%%%              COMPUTER VISION 2021-2022
%%%              Face Detection 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function PixelSum=GetSumRect(IntegralImage,x,y,Width,Height)
%
% PixelSum=GetSumRect(IntegralImage,x,y,Width,Height)
%
IIWidth=size(IntegralImage,1);
PixelSum  =   IntegralImage((x+Width)*IIWidth + y + Height+1) +  ...
			  IntegralImage(x*IIWidth+y+1) - ...
			  IntegralImage((x+Width)*IIWidth+y+1) - ...
			  IntegralImage(x*IIWidth+y+Height+1);



            
       