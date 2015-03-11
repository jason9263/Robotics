%compute the H transform matrix.
function [ImgX1,ImgY1,ImgX2,ImgY2, Img1, Img2] = GetT()
    Img1 = double(imread('wdc1.jpg'));
    [Imgh1,Imgw1,Imgd1] = size(Img1);
    
    
    Img2 = double(imread('wdc2.jpg'));
    [Imgh2,Imgw2,Imgd2] = size(Img2);
    
    figure;
    subplot(1,2,1);
    image(Img1/255);
    axis image;
    hold on;
    title('The reference image');
    [ImgX1, ImgY1] = ginput2(2);
    
    subplot(1,2,2);
    image(Img2/255);
    axis image;
    hold on
    title('The input image');
    [ImgX2, ImgY2] = ginput2(2);
    

    
end