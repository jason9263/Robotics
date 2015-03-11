%the whole programming workflow
function WarpImgWhole()
      %getting the corresponding points;
     [ImgX1,ImgY1,ImgX2,ImgY2, Img1, Img2,Imgh1,Imgw1,Imgh2,Imgw2] = MosGetCor();
      %compute the matrix
      t1 = [ImgX1 ImgX2];
      t2 = [ImgY1 ImgY2];
     [T] = ComputeH(t1, t2);
     T=[
   -0.8270    0.4872  399.8522
   -0.4872   -0.8270  405.3609
         0         0    1.0000];
      %compute the new Image
     [NewImage] = warpImage(T,Imgh1, Imgw1,Imgh2,Imgw2,Img1,Img2);
end
