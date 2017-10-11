function [W] = mylinridgereg(X,Y,lambda)
A=transpose(X)*Y;
B=transpose(X)*X +lambda*eye(size(transpose(X)*X));
W=pinv(B)*A;
end
% 
% function [theta, J_history] = mylinridgereg(X, Y, theta, alpha,lambda, num_iters)
% 
% m = length(Y); % number of training examples
% [~,c]=size(X);
% J_history = zeros(num_iters, 1);
% temp=zeros(c,1);
% 
% for iter = 1:num_iters
%     theta = theta - alpha*((X'*(X*theta - Y))/m + lambda*theta);
%     predict =  mylinridgeregeval(X, theta);
%     J_history(iter,1) = meansquarederr(Y,predict);
% end
% end