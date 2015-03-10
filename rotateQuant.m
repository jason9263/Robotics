%home work 2
function [Prot] = rotateQuant(q,p)
    w = q(1);
    v1 = q(2);
    invq = [w,-v1];
    p = [0 p];
    r1 = multiplyquatern(q,p);
    Prot = multiplyquatern(r1,invq);
    
end
