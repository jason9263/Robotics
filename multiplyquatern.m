%home work 3
function [r] = multiplyquatern(q1,q2)
    w1 = q1(1);
    w2 = q2(1);
    v1 = [q1(2), q1(3), q1(4)];
    v2 = [q2(2), q2(3), q2(4)];
    r = [w1*w2, v1*v2', w1*v2+w2*v1,cross(v1,v2)];
end