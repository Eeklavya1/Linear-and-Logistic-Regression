function [W] = gradientdescent(w_initial,num_iterations,X,alpha,Y,lambda)
W=w_initial;
W=transpose(W);
a=size(X);
sum=0;
for i=1:num_iterations
fx=sigmoid(X*W);
%     for d=1:3
%    for j=1:a(1)
%       sum=sum+(sigmoid(X(j,:)*W)-Y(j))*X(j,d);
%    end
%    sum=sum/a(1);
%    W(d)=W(d)-alpha*sum;
%     end
%disp(norm(W));
W=W-alpha*(transpose(X)*(fx-Y)+lambda*W)/length(Y);
end
end


