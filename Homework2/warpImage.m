% warp image
function  [Iwarp,Imerge] = warpImage(Img2,Img1,T)

    [Imgh1,Imgw1,Imgd1] = size(Img1); 
    [Imgh2,Imgw2,Imgd2] = size(Img2);


    V1 = T*[1;1;1];
    %for (w2 1)
    V3 = T*[Imgw2;1;1];
    %for (1 h2)
    V2 = T*[1; Imgh2; 1];
    %for (w2, h2)
    V4 = T*[Imgw2; Imgh2; 1];
    
    NewPos = [V1 V2 V3 V4];
    
    Xmin = min( [ NewPos(1,:) 0]);
    Xmax = max( [NewPos(1,:) Imgw1]);
    Ymin = min( [ NewPos(2,:) 0]);
    Ymax = max( [NewPos(2,:) Imgh1]);
    Xwidth = [Xmin: Xmax];
    Yheight = [Ymin: Ymax];
    
    % the main idea is compute the second image in previous image
    % and copy the else part of the previous image
    
    % grid the new domain 
    [Xgrid, Ygrid] = ndgrid(Xwidth, Yheight);
    [NewX, NewY ] = size(Xgrid);
    
    %compute the inverse mapping of the second image
    %which means the (u, v) mapping to (x,y)
    %AX = B the solution is A \ B

    
    InverseImg = T \ [Xgrid(:) Ygrid(:) ones(NewX * NewY,1)]';
    clear NewImage;
    
    Xindex = reshape(InverseImg(1,:), NewX, NewY)';
    Yindex = reshape(InverseImg(2,:), NewX, NewY)';
    
    %we get RGB information, respectively
    Imerge(:,:,1) = interp2(Img2(:,:,1),Xindex, Yindex, '*bilinear');
    Imerge(:,:,2) = interp2(Img2(:,:,2),Xindex, Yindex, '*bilinear');
    Imerge(:,:,3) = interp2(Img2(:,:,3),Xindex, Yindex, '*bilinear');
    Iwarp = Imerge;
    figure;
    image(Iwarp/255);
    axis image;
    title('Jaosn wrap image');
    %compute the offset of the second images
    offset = -round( [  min( [NewPos(1,:),0] ), min( [NewPos(2,:),0] )]  );
    
    Imerge(1+offset(2): Imgh1+ offset(2),  1+ offset(1):Imgw1+offset(1), : ) = double(Img1(1:Imgh1,1:Imgw1,:));
    
    
    figure;
    image(Imerge/255);
    axis image;
    title('Jason New Image');
    
end
