function [IM1]= Wavelet(Image)
% This function performs the Haar wavelet transform for a grayscale image
% A recursion is done to the image, till its size is just 2 pixels (which is
% the stopping condition, 1 row and 2 coloums)



%Image=imread('lena.jpg');
if (size(Image,1) )~=1 
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
    Image1= Image(1:size(Image,1)/2 , 1:size(Image,2)/2); % LL Image
    Image2= Image(1:size(Image,1)/2 , size(Image,2)/2 +1:size(Image,2)); %HL Image
    Image3= Image(size(Image,1)/2 +1:size(Image,1) , 1:size(Image,2)/2); %LH Image
    Image4= Image(size(Image,1)/2 +1:size(Image,1) , size(Image,2)/2 +1:size(Image,2));% HH Image
   
    %Calling the Wavelet function again for image1 (LL image)
    IMM=Wavelet(Image1);
    
    %Appending the the output of the Wavelet to the original image
    IM1 =[IMM Image2;Image3 Image4 ];
    Result_Image = mat2gray(IM1);
    Imshow (Result_Image);
    
%Base condition to stop the recursion, when the size of image == 1
else
 IM1 =Image;

end    
end



