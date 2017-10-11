function plotDecisionBoundary(w,data, label,degree,M,S)
Z=zeros(100,100);
X=linspace(0,7,100);
%disp(X);
Y=linspace(0,7,100);

for i=1:100
    
    feat=featuretransform([ ones(100,1) X(i)*ones(100,1) Y'],degree);
    feat(:,2:end)=(feat(:,2:end)-ones(size(feat,1),1)*M)./(ones(size(feat,1),1)*S);
    Z(i,:)=feat*w;

end
plotData(data(:,2:end),label);
hold on;
contour((X-M(1))/S(1),(Y-M(2))/S(2),Z',[0,0]);
hold off;
end