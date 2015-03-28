%the whole programming workflow
function main()
      %getting the corresponding points;
     [ImgX1,ImgY1,ImgX2,ImgY2, Img1, Img2] = GetT();
      %compute the matrix
      t1 = [ImgX1 ImgX2];
      t2 = [ImgY1 ImgY2];
      
     [H] = ComputeH(t1, t2);
      %compute the new Image
     [Iwarp,Imerge] = warpImage(Img2,Img1,H);
     
end
