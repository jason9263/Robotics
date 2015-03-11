% load input images
I1 = double(imread('wdc1.jpg'));
[h1 w1 d1] = size(I1);
I2 = double(imread('wdc2.jpg'));
[h2 w2 d2] = size(I2);

% show input images and prompt for correspondences
figure; subplot(1,2,1); image(I1/255); axis image; hold on;
title('first input image');
[X1 Y1] = ginput2(2); % get two points from the user
subplot(1,2,2); image(I2/255); axis image; hold on;
title('second input image');
[X2 Y2] = ginput2(2); % get two points from the user

% estimate parameter vector (t)
Z  = [ X2'  Y2' ; Y2' -X2' ; 1 1 0 0  ; 0 0 1 1 ]';	 
xp = [ X1 ; Y1 ];
t  = Z \ xp; % solve the linear system
a  = t(1); % = s cos(alpha)
b  = t(2); % = s sin(alpha)
tx = t(3);
ty = t(4);

% construct transformation matrix (T)
T = [a b tx ; -b a ty ; 0 0 1];

% warp incoming corners to determine the size of the output image (in to out)
cp = T*[ 1 1 w2 w2 ; 1 h2 1 h2 ; 1 1 1 1 ]; 
Xpr = min( [ cp(1,:) 0 ] ) : max( [cp(1,:) w1] ); % min x : max x
Ypr = min( [ cp(2,:) 0 ] ) : max( [cp(2,:) h1] ); % min y : max y
[Xp,Yp] = ndgrid(Xpr,Ypr);
[wp hp] = size(Xp); % = size(Yp)

% do backwards transform (from out to in)
X = T \ [ Xp(:) Yp(:) ones(wp*hp,1) ]';  % warp

% re-sample pixel values with bilinear interpolation
clear Ip;
xI = reshape( X(1,:),wp,hp)';
yI = reshape( X(2,:),wp,hp)';
Ip(:,:,1) = interp2(I2(:,:,1), xI, yI, '*bilinear'); % red
Ip(:,:,2) = interp2(I2(:,:,2), xI, yI, '*bilinear'); % green
Ip(:,:,3) = interp2(I2(:,:,3), xI, yI, '*bilinear'); % blue

% offset and copy original image into the warped image
offset =  -round( [ min( [ cp(1,:) 0 ] ) min( [ cp(2,:) 0 ] ) ] );
Ip(1+offset(2):h1+offset(2),1+offset(1):w1+offset(1),:) = double(I1(1:h1,1:w1,:));

% show the result
figure; image(Ip/255); axis image;
title('mosaic image');