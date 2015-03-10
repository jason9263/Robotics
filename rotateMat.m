%home work 2
function [Prot] = rotateMat(R,p)
    %check the matrix R is the rotation matrix 
    %p is the 3 1 matrix
    sizeR = size(R);
    sizep = size(p);

    if(sizeR(1) == 3 && sizeR(2) == 3 && sizep(1) == 3 && sizep(2) == 1 )
        Prot = R*p;
    end

end
