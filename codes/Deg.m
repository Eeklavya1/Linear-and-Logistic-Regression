function [Y] = Deg(X,degr)
Y=ones(size(X));
for i=1:degr
Y=Y.*X;
end
end

