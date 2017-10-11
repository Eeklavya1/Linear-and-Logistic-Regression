M=importdata('credit.txt',',');
X=zeros(1000,3);
Y=zeros(1000,1);
X(:,1)=1;
X(:,2)=M(:,1);
X(:,3)=M(:,2);
Y(:,1)=M(:,3);
figure(1),plotData(X(:,2:end),Y);
disp('data is plotted in figure(1)');
frac=0.8;


% error_g=zeros(100,1);
% error_n=zeros(100,1);
Mean=mean(X(:,2:end));
Std=std(X(:,2:end));
X(:,2:end)=(X(:,2:end)-ones(size(X,1),1)*Mean)./(ones(size(X,1),1)*Std);
%figure(1),plotData(X(:,2:3), Y);
 W_i=rand(1,3)*0.2-0.1;
 abc=[10 100 500 1000 10000];
 e1=zeros(5,1);
 e2=zeros(5,1);
   disp('we will check error for fixed lambda for both cases to know which performs better ');
  disp('                                                                        ');
 for r=1:5
 W1=NewtonRaphson(W_i,X,Y,abc(r),0.01);
  W2=gradientdescent(W_i,abc(r),X,0.003,Y,0.01);
  disp('------------Q2-----------------------------------------------')
  e1(r)=error_log(X,Y,W1);
  e2(r)=error_log(X,Y,W2);
  disp(['Newton Raphson  Gradient Descent']);
  disp([e1(r)                      e2(r)]);
  disp('------------Q2-----------------------------------------------')
 end
 figure(4),plot(abc,e1,'r','DisplayName','Newton Raphson');
 hold on;
 plot(abc,e2,'DisplayName','Gradient Descent');
 xlabel('number of iterations->');
 ylabel('error->');
 title('plot of error v/s num of iterations for newrton raphson and gradient descent');
 legend('show');
 hold off;
[X_train,X_test,Y_train,Y_test] =partition_log(X,Y,frac);
  
X(:,1)=1;
X(:,2)=M(:,1);
X(:,3)=M(:,2);
accu_train=zeros(10,1);
accu_test=zeros(10,1);
t=1;
lam=zeros(10,1);
%---------------------finding degree-------------------------------------
for deg=1:10
    lam(t)=deg;
new_X_train=featuretransform(X_train,deg);
new_X_train(:,1)=1;
Mean=mean(new_X_train(:,2:end));
Std=std(new_X_train(:,2:end));
new_X_train(:,2:end)=(new_X_train(:,2:end)-ones(size(new_X_train,1),1)*Mean)./(ones(size(new_X_train,1),1)*Std);
%figure(34),plotData(new_X(:,2:end),Y);
ab=size(new_X_train);
%disp([X new_X Y]);
W_j=rand(1,ab(2))*0.2-0.1;
W_new_train=gradientdescent(W_j,1000,new_X_train,0.001,Y_train,0.1);
accu_train(t)=accuracy(new_X_train,Y_train,W_new_train);
t=t+1;
end
figure(2),plot(lam,accu_train);
title('plot of accuracy for training set v/s degree');
xlabel('degree->');
ylabel('accuracy');
%------------------plotting decision boundary for degree=3-----------------

X(:,1)=1;
X(:,2)=M(:,1);
X(:,3)=M(:,2);
[X_train,X_test,Y_train,Y_test] =partition_log(X,Y,frac); 
new_X_train=featuretransform(X,3);
new_X_train(:,1)=1;
Mean=mean(new_X_train(:,2:end));
Std=std(new_X_train(:,2:end));
new_X_train(:,2:end)=(new_X_train(:,2:end)-ones(size(new_X_train,1),1)*Mean)./(ones(size(new_X_train,1),1)*Std);
ab=size(new_X_train);
%disp([X new_X Y]);
W_j=rand(1,ab(2))*0.2-0.1;
W_new_train=gradientdescent(W_j,1000000,new_X_train,1,Y,0.001);%change value of lambda here


 figure(3),plotDecisionBoundary(W_new_train,new_X_train,Y,3,Mean,Std);
 
% %---------test for overfitting or inderfitting-----------------------------------------
new_X_train=featuretransform(X_train,3);
new_X_train(:,1)=1;
Mean=mean(new_X_train(:,2:end));
Std=std(new_X_train(:,2:end));
new_X_train(:,2:end)=(new_X_train(:,2:end)-ones(size(new_X_train,1),1)*Mean)./(ones(size(new_X_train,1),1)*Std);
ab=size(new_X_train);
%disp([X new_X Y]);
W_j=rand(1,ab(2))*0.2-0.1;
W_new_train=gradientdescent(W_j,1000000,new_X_train,1,Y_train,120);%change value of lambda here
new_X_test=featuretransform(X_test,3);
new_X_test(:,1)=1;
Mean=mean(new_X_test(:,2:end));
Std=std(new_X_test(:,2:end));
new_X_test(:,2:end)=(new_X_test(:,2:end)-ones(size(new_X_test,1),1)*Mean)./(ones(size(new_X_test,1),1)*Std);
figure(34),plotData(new_X_train(:,2:end),Y_train);
title('training set');
figure(35),plotData(new_X_test(:,2:end),Y_test);
title('test set');
acc_train=accuracy(new_X_train,Y_train,W_new_train);
acc_test=accuracy(new_X_test,Y_test,W_new_train);
disp('--------------Q6--------------------------------');
disp('train accuracy=');
disp(acc_train);
disp('test accuracy');
disp(acc_test);