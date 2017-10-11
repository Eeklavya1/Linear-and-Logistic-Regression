function [error] =meansquarederr(T, Tdash)
e=0;
a=size(T);
for i=1:a(1);
    e=e+((Tdash(i)-T(i))*(Tdash(i)-T(i)));
end
error=e/a(1);
end

