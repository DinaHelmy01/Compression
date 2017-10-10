function [IM1]= WaveletDecomposition(Image, iterations)

%Image=imread('lena.jpg');
% This function performs the Haar wavelet transform for a grayscale image
% A recursion is done to the image, till the number of iterations mentioned
% in the argument. Example: WaveletDecomposition(Image,iterations)
  
    
if (iterations == 0)
    IM1=Image
     
else
   
    NewImage=[];
    %Looping row by row
    for row=1:size(Image,1)
        TempAverage =[];
        TempDifference =[];
       for i=1:2:size(Image,2)
           Average= double(( double(Image(row,i)) + double(Image(row,i+1)))/2);
           Difference = double( ( double(Image(row,i)) -double(Image(row,i+1)))/2);
           TempAverage=[TempAverage Average];
           TempDifference = [TempDifference Difference];
       end
       NewImage=[NewImage;TempAverage TempDifference];
    end
    Image =NewImage;

    NewImage=[];
    %Looping coloum by coloum
    for coloum=1:size(Image,2)/2
        TempAverage =[];
        TempDifference =[];
       for i=1:2:size(Image,1) 
           Average= double((double(Image(i,coloum)) +double(Image(i+1,coloum)))/2) ;
           Difference = double((double(Image(i,coloum)) -double(Image(i+1,coloum)))/2) ;
           TempAverage=[TempAverage Average] ;
           TempDifference = [TempDifference Difference];
       end
       NewImage=[NewImage;TempAverage TempDifference] ; 
    end
    NewImage = NewImage';
    
    Image(:,1:size(Image,2)/2)=NewImage ;

    %Creating the 4 images
    Image1= Image(1:size(Image,1)/2 , 1:size(Image,2)/2);
    Image2= Image(1:size(Image,1)/2 , size(Image,2)/2 +1:size(Image,2));
    Image3= Image(size(Image,1)/2 +1:size(Image,1) , 1:size(Image,2)/2);
    Image4= Image(size(Image,1)/2 +1:size(Image,1) , size(Image,2)/2 +1:size(Image,2));
   
    IMM=WaveletDecomposition(Image1, iterations -1);
    IM1 =[IMM Image2;Image3 Image4 ];
    Result_Image = mat2gray(IM1);
    Imshow (Result_Image);
    
%Base condition to stop the recursion
    
    
    
end

 
   
end
   




