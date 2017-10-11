function [e] =error_log(X,Y,W)
hypothesis = sigmoid(X*W); % hypothesis = mx1 column vector
%disp(X);
 %disp([X*W hypothesis Y]);
% costJ = single number 
costJ = 0;
costJ = (-1/100) * sum( Y .* log(hypothesis) + (1 - Y) .* log(1 - hypothesis) );

e=costJ;

end

