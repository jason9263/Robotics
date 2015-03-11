%the whole programming workflow
function WarpImgWhole()
      %getting the corresponding points;
     [ImgX1,ImgY1,ImgX2,ImgY2, Img1, Img2,Imgh1,Imgw1,Imgh2,Imgw2] = MosGetCor();
      %compute the matrix
     [T] = MosT(ImgX1,ImgY1,ImgX2,ImgY2);
     T=[
   -0.8270    0.4872  399.8522
   -0.4872   -0.8270  405.3609
         0         0    1.0000];
      %compute the new Image
     [NewImage] = WarpImg(T,Imgh1, Imgw1,Imgh2,Imgw2,Img1,Img2);
end
