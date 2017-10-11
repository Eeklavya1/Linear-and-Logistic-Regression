function [features] = featuretransform(X, degree)
X1(:,1)=X(:,2);
X2(:,1)=X(:,3);
k=2;
for i=1:degree
   for j=1:i
       features(:,k)=Deg(X1,j).*Deg(X2,i-j);
       k=k+1;
%        if j~=i-j
%        features(:,k)=Deg(X2,j).*Deg(X1,i-j);
%        k=k+1;
%        end
   end
   features(:,k)=Deg(X2,i);
   k=k+1;
end
%features=b;
