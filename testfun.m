function y = testfun(x)
%y = -x(1) * x(2) * x(3);
%y = sqrt( (  sin(x(1)) * x(3) - sin(x(2)) * x(4) )^2 + (cos(x(1))*x(3) - cos(x(2)) * x(4) )^2);
x1 = cos(x(1)) * x(3);
x2 = cos(x(2)) * x(4);
y1 = sin(x(1)) * x(3);
y2 = sin(x(2)) * x(4);

y = -pdist2([x1, y1], [x2, y2]);
%y = sin(x(1))*x(3) + cos(x(2))*x(4);
end

