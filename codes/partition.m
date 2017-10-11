function [X_train,X_test,Y_train,Y_test] =partition(X,Y,frac)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
a=4177;
p=randperm(a);
%display(p);
train=round(frac*a);
for i=1:train
    X_train(i,:)=X(p(i),:);
    Y_train(i,1)=Y(p(i),1);
end;
%Y_train=transpose(Y_train);
t=1;
for i=train+1:a
    X_test(t,:)=X(p(i),:);
    Y_test(t,1)=Y(p(i),1);
    t=t+1;
end

  %  Y_test=transpose(Y_test);

end

