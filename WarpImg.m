% warp image
function [A,B] = WarpImg()

% warp incoming corners to determine the size of the output image (in to out)
    cp = T*[ 1 1 w2 w2 ; 
            1 h2 1 h2 ; 
            1 1 1 1 ];
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


end
