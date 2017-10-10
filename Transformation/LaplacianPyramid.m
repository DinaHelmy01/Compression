 function [A] = LaplacianPyramid(Image,level)

 %This function performs the laplacian Pyramid for the incoming Image with
 %the number of levels, as the number of levels increase, the image will
 %get more blurred. Example of input:
 %LaplacianPyramid(I,1),LaplacianPyramid(I,10)
 
 
 %Stopping condition
 if(level ==0)
     size(Image);
     A=Image;
     return 
 end
 
 %I=imread('lena.jpg');
 %Using Gaussian filter with sigma = 0.5 and kernel size :3*3
GaussianFilter = fspecial('gaussian',3,0.5);
    
%Apply the filter on the image
BluredImage = imfilter(Image,GaussianFilter);
%Creating the odd matrix ; Downsampling by 2
Gaussian_Pyramid = BluredImage(1:2:end,1:2:end);  % odd matrix
[row, col]=size(BluredImage);

%Getting the high frequecies
Laplacian_Pyramid=BluredImage -imresize(imfilter(Gaussian_Pyramid,GaussianFilter),[row,col]);


A=imresize(LaplacianPyramid(Gaussian_Pyramid,level-1),[row,col])+Laplacian_Pyramid;

imshow(A);

%Synthesis



end
