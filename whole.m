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
    [ImgX1, ImgY1] = ginput2(2);
    
    subplot(1,2,2);
    image(Img2/255);
    axis image;
    hold on
    title('The second component');
    [ImgX2, ImgY2] = ginput2(2);
    
    % estimate parameter vector (t)
    Z  = [ ImgX2'  ImgY2' ; 
        ImgY2' -ImgX2' ; 
        1 1 0 0  ; 
        0 0 1 1 ]';	 
    
    xp = [ ImgX1 ; 
           ImgY1 ];
    T  = Z \ xp; 
    %the rotation element
    a  = T(1); 
    b  = T(2);
    %the translate element
    tx = T(3);
    ty = T(4);

% construct transformation matrix (T)
    T = [a b tx ; 
        -b a ty ; 
         0 0 1];
     
     
     
     
         %compute the show area
    %for (1 1)
    V1 = T*[1;1;1];
    %for (w2 1)
    V2 = T*[Imgw2;1;1];
    %for (1 h2)
    V3 = T*[1; Imgh2; 1];
    %for (w2, h2)
    V4 = T*[Imgw2; Imgh2; 1];
    
    NewPos = [V1 V2 V3 V4];
    
    Xmin = min(NewPos(1,:));
    Xmax = max(NewPos(1,:));
    Ymin = min(NewPos(2,:));
    Ymax = max(NewPos(2,:));
    Xwidth = [Xmin, Xmax];
    Yheight = [Ymin, Ymax];
    
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
    NewImage(:,:,1) = interp2(Img2(:,:,1),Xindex, Yindex, '*bilinear');
    NewImage(:,:,2) = interp2(Img2(:,:,2),Xindex, Yindex, '*bilinear');
    NewImage(:,:,3) = interp2(Img2(:,:,3),Xindex, Yindex, '*bilinear');
    %compute the offset of the second images
    offset = -round( [  min( [NewPos(1,:),0] ), min( [NewPos(2,:),0] )]  )
    
    NewImage(1+offset(2): Imgh1+ offset(2),  1+ offset(1):Imgw1+offset(1), : ) = double(Img1(1:Imgh1,1:Imgw1,:));
    
    
    figure;
    image(NewImage/255);
    axis NewImage;
    title('Jason New Image');
    
    
    
    