function [acc] = accuracy(X,Y,W)
fx=sigmoid(X*W);
ab=size(fx);
for i=1:ab(1)
    if fx(i)>0.5
        fx(i)=1;
    else
        fx(i)=0;
    end
end
    count=0;
    for i=1:ab(1)
        if(fx(i)==Y(i))
            count=count+1;
        end
    end
    acc=(count/ab(1))*100;
    


end

