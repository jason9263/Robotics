%compute the transform matrix
function [T] = MosT(ImgX1,ImgY1,ImgX2,ImgY2)
% estimate parameter vector (t)
    Z  = [ ImgX2'  ImgY2' ; 
        ImgY2' -ImgX2' ; 
        1 1 0 0  ; 
        0 0 1 1 ]';	 
    
    xp = [ X1 ; 
           Y1 ];
    
       
       
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


end



