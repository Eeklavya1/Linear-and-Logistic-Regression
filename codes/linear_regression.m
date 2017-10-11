M=importdata('linregdata',',');
%display((size(M.data(1,:))));
%[4177,11]=zeros(X);
for i=5:11
    X(:,i)=M.data(:,i-4);
end
Y=M.data(:,8);
for i=1:size(M.textdata())
    if(strcmp(M.textdata(i),'F')==1)
        X(i,2)=1;
        X(i,3)=0;
        X(i,4)=0;
    end
    if(strcmp(M.textdata(i),'M')==1)
        X(i,2)=0;
        X(i,3)=0;
        X(i,4)=1;
    end
    if(strcmp(M.textdata(i),'I')==1)
        X(i,2)=0;
        X(i,3)=1;
        X(i,4)=0;
    end
end
[e1,e2,e3,e4,W1,W2]=best_attributes(X,Y,0.1);
disp([e1 e2 e3 e4]);
frac=[0.2 0.3 0.5 0.6 0.8 0.9];
disp('-------------Q6------------------------------------');
disp('lambda value used->' );
disp('0.1');
disp('training error before removing the  least significant attributes');
disp(e1);
disp('testing error before removing the  least significant attributes');
disp(e2);
disp('training error after removing the  least significant attributes');
disp(e3);
disp('testing error after removing the  least significant attributes');
disp(e4);
disp('Weights before removing the  least significant attributes');
disp(W1);
disp('Weights after removing the  least significant attributes');
disp(W2);
disp('-------------Q6------------------------------------');
disp('------------------------Q7------------------------------')
for f=1:6
    error_train=zeros(1,100);
error_test=zeros(1,100);
lam=zeros(1,100);

for k=1:100
     %t=1;
     
[X_train,X_test,Y_train,Y_test] = partition(X,Y,frac(f));
mn=mean(X_train(:,2:end));
S=std(X_train(:,2:end));
%disp(size(ones(size(X_train,1),1)*mn));
X_train(:,2:end)=(X_train(:,2:end)-ones(size(X_train,1),1)*mn)./(ones(size(X_train,1),1)*S);
X_test(:,2:end)=(X_test(:,2:end)-ones(size(X_test,1),1)*mn)./(ones(size(X_test,1),1)*S);
X_train(:,1)=1;
X_test(:,1)=1;
    %(X_train(:,3)-mn(3));
s=1;
%----------------------------------for variety of lambdas------------------
    for l=0.1:0.1:10     %change the lambda values here
W=mylinridgereg(X_train,Y_train,l);
T_train=mylinridgeregeva(X_train,W);
error_train(s)=error_train(s)+meansquarederr(T_train,Y_train);
T_test=mylinridgeregeva(X_test,W);
error_test(s)=error_test(s)+meansquarederr(T_test,Y_test);
lam(s)=l;
s=s+1;
    end
end
        error_train=error_train./100;
        error_test=error_test./100;
       % disp(error_train);
    [min_test,lambda_test]=min(error_test);
    [min_train,lambda_train]=min(error_train);
    lambda_t=lam(lambda_test);
   % subplot(2,3,f);
  %  display(lam);
   % display(array_train);
   figure(f),
   title('effect of lambda onaverage mean squared error for training and test cases');
   plot(lam,error_train,'r','DisplayName','Training');
   hold on;
   title(['training-' num2str(frac(f))]);
   xlabel('lambda values->');
   ylabel('average mean squared error->');
  % ylim([4.6 5.1]);
   
   %disp([size(lam) size(array_test) size(array_train)]);
     plot(lam,error_test,'DisplayName','Testing');
     legend('show');
     hold off;
%    title(['test-' num2str(1-frac(f))]);
%    xlabel('lambda values->');
%    ylabel('average mean squared error->');
   %ylim([4.6 5.1]);
arr_frac(f)=min_test;
arr_l(f)=lambda_t;
end

        
%display(arr_frac);
figure(f+1),plot(frac,arr_frac);
title('plot of fraction size(training) v/s minimum average mean squared error(test)');
xlabel('fraction size->');
ylabel('minimum average mean squared error->');
figure(f+2),plot(frac,arr_l);
title('plot of fraction size v/s lambda values that give minimum average mean squared error');
xlabel('fraction size(training->)');
ylabel('corresponding lambda values->');
%----------------question 10------------------
min_f=100000;
for i=1:f
    if arr_frac(i)<min_f
        min_f=arr_frac(i);
        min_frac=frac(i);
        min_l=arr_l(i);
    end
end
[X_train,X_test,Y_train,Y_test] =partition(X,Y,min_frac);
mn=mean(X_train(:,2:end));
S=std(X_train(:,2:end));
%disp(size(ones(size(X_train,1),1)*mn));
X_train(:,2:end)=(X_train(:,2:end)-ones(size(X_train,1),1)*mn)./(ones(size(X_train,1),1)*S);
X_test(:,2:end)=(X_test(:,2:end)-ones(size(X_test,1),1)*mn)./(ones(size(X_test,1),1)*S);
X_train(:,1)=1;
X_test(:,1)=1;

W=mylinridgereg(X_train,Y_train,min_l);
T_train=mylinridgeregeva(X_train,W);
figure(f+3),plot(T_train,Y_train,'.');
xlabel('predicted values->');
ylabel('actual values->');
hline=refline(1,0);
hline.Color='r';
title('plot of observed target value v/s actual target  value for training ');
T_test=mylinridgeregeva(X_test,W);
figure(f+4),plot(T_test,Y_test,'.');
xlabel('predicted values->');
ylabel('actual values->');
hline=refline(1,0);
hline.Color='r';
title('plot of observed target value v/s actual target  value for test cases');
disp('All graphs have beel plotted in different figures');
disp('---------------------------Q7---------------------');
