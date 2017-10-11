function [W] = NewtonRaphson(w_initial,X, Y, n_iter,lambda)
for i=1:1:n_iter
    
    %Activating values of y using sigmoid function 
    W=w_initial;
 W=transpose(W);
    fx = X*W;
    fx = sigmoid(fx);
	
    %Calculating gradient of error
	error_grad = X'*(fx - Y);
    
	%Calculating Hessain Matrix using sparse diagonal matrix
	RColumnVector = fx.*(1-fx);
   % disp(RColumnVector);
    R = spdiags( RColumnVector, 0, numel(RColumnVector), numel(RColumnVector) );
    
    H = X'*R*X;
    H=H+lambda*eye(size(H));
    HInverse = inv(H);
    
	%Finding new weight and updating old weight
	W = W- (HInverse*error_grad);

end
end