%compute the H transform matrix.
function [ImgX1,ImgY1,ImgX2,ImgY2] = MosGetCor()
    Img1 = double(imread('wdc1.jpg'));
    [Imgh1,Imgw1,Imgd1] = size(Img1);
    
    
    Img2 = double(imread('wdc2.jpg'));
    [Imgh2,Imgw2,Imgd2] = size(Img2);
    
    figure;
    subplot(1,2,1);
    image(Img1/255);
    axis image;
    hold on;
    title('The first component');
    
    subplot(1,2,2);
    image(Img2/255);
    title('The second component');
    
    numclick = 2;
    [ImgX1, ImgY1] = ginput2(numclick);
    [ImgX2, ImgY2] = ginput2(numclick);
    
    
end