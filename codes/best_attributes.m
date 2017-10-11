function [e_train_before,e_test_before,e_train_after,e_test_after,W_before,W_after] =best_attributes(X,Y,lambda)
[X_train,X_test,Y_train,Y_test] = partition(X,Y,0.7);
mn=mean(X_train(:,2:end));
S=std(X_train(:,2:end));
%disp(size(ones(size(X_train,1),1)*mn));
X_train(:,2:end)=(X_train(:,2:end)-ones(size(X_train,1),1)*mn)./(ones(size(X_train,1),1)*S);
X_test(:,2:end)=(X_test(:,2:end)-ones(size(X_test,1),1)*mn)./(ones(size(X_test,1),1)*S);
X_train(:,1)=1;
X_test(:,1)=1;
W=mylinridgereg(X_train,Y_train,lambda);
W_before=W;
T_train=mylinridgeregeva(X_train,W);
T_test=mylinridgeregeva(X_test,W);
e_test_before=meansquarederr(T_test,Y_test);
e_train_before=meansquarederr(T_train,Y_train);
W_abs=abs(W);
W1=sort(W_abs);
a=size(W_abs);
tem=zeros(3,1);
t=1;
for i=1:a(1)
    for j=i:a(1)
    if(W1(i)==W_abs(j))
        tem(t)=j;
t=t+1;
    end
    end
end
for i=1:3
    W(tem(i))=0;
end
W_after=W;
T_train=mylinridgeregeva(X_train,W);
T_test=mylinridgeregeva(X_test,W);
e_train_after=meansquarederr(T_train,Y_train);
e_test_after=meansquarederr(T_test,Y_test);
end

