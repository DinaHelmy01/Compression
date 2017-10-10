function [ImageOutput]=Inverse_Wavelet(Image,SizeR,SizeC)

%This function performs the inverse of wavelet transform, the input is the
%transformed image and SizeR and SizeC; if the decomposition has been done
%on all the image, then SizeR =1, SizeC =2 , if just 2 decompositions has
%been done  then SizeR,SizeC=128 (512/4)


%first time values if the Wavelet is done till the last pixel
%SizeR =1
%SizeC =2
% if decomposition of 2, then SizeR,SizeC=128 (512/4)


%Stopping condition of the recursion
if (size(Image,1)==SizeR && size(Image,2)==SizeC)
    ImageOutput=Image;
    Result_Image = mat2gray(ImageOutput);
    imshow(Result_Image);
    return 
end

Add=[];
Sub=[];
m=[];

% Inverse Wavelet row by row
for i=1:1:SizeR
    for j=1:1:SizeC
        %Size is 1*2
        Addition1 = double(Image(i,j))+double(Image(i+SizeR,j));
        Subtraction1 = double(Image(i,j))-double(Image(i+SizeR,j));
        Add=[Add Addition1 ];
        Sub=[Sub Subtraction1];
    end
c=[Add;Sub];
m=[m;c];
Add=[];
Sub=[];
end


Image(1:SizeR*2,1:SizeC)=m;


% Inverse Wavelet coloum by coloum
temp=[];
for i=1:size(m,1)
    mm=[];
    for j=1:size(m,2)
        Addition1 = double(Image(i,j))+ double(Image(i,j+size(m,2)));
        Subtraction1 = double(Image(i,j))- double(Image(i,j+size(m,2)));
        mm=[mm Addition1 Subtraction1];
    end 
    temp=[temp ; mm];
end

Image(1:SizeR*2,1:SizeC*2)=temp;
%Calling the Inverse Wavelet for doubled image

ImageOutput=Inverse_Wavelet(Image,SizeR*2,SizeC*2);


end
