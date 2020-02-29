load hw4


trial = 91;
class = 8;

%min = 99999;
%for i = 1:trial
%    for j = 1:class
%        if min>size(train_trial(i,j).spikes(:,:),2)
%            min = size(train_trial(i,j).spikes(:,:),2);
%        end
%    end
%end
%8bins total
bins = 8;

for i = 1:trial
    for j = 1:class%sum of 200 points
        k=1;
        while(k*20+20<size(train_trial(i,j).handPos,2)&&k<20)%k是开始的pos = 141-160
 %每个bin=sum spike
            k = k+1;
        end
    end
end