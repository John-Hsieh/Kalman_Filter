phi = zeros(4,1,8);
V = zeros(4,4,8);
counter = zeros(1,8);
for i = 1:trial
    for j = 1:class%sum of 200 points
        k=1;
        disp(size(train_trial(i,j).handPos,2));
        while(k*20+20<size(train_trial(i,j).handPos,2)&&k<20)
            b = (1+(k-1)*20):(20+(k-1)*20);                         %binµÄ·¶Î§c'le         
            train_spike(:,k,i,j) = mean(train_trial(i,j).spikes(:,b),2);  
            train_pos(1,k,i,j) = (train_trial(i,j).handPos(1,(20+(k-1)*20)));
            train_pos(2,k,i,j) = (train_trial(i,j).handPos(2,(20+(k-1)*20)));

            temp = (train_trial(i,j).handPos(1,(20+(k)*20)));
            temp2 = (train_trial(i,j).handPos(2,(20+(k)*20)));
            train_pos(3,k,i,j) = (temp-train_pos(1,k,i,j))./20;
            train_pos(4,k,i,j) = (temp2 -train_pos(2,k,i,j))./20;
            k = k+1;
        end
        phi(:,1,j) = phi(:,1,j)+train_pos(:,1,i,j);
        counter(1,j) = counter(1,j)+1;
    end
end

for i = 1:8
    phi(:,1,i) = phi(:,1,i)./counter(1,i);
end
counter = zeros(1,8);
for i = 1:trial
    for j = 1:class%sum of 200 points
        tempvar = train_pos(:,1,i,j)-phi(:,1,j);
        V(:,:,j) = V(:,:,j) + tempvar*tempvar';
        counter(1,j) = counter(1,j)+1;
    end
end
for i = 1:8
    V(:,:,i) = V(:,:,i)./counter(1,i);
end


for i = 1:trial
    for j = 1:class%sum of 200 points
        k=1;
        disp(size(test_trial(i,j).handPos,2));
        while(k*20+20<size(test_trial(i,j).handPos,2)&&k<20)
            if (test_trial(i,j).handPos(:,(20+(k-1)*20))==[0,0])
                break;
            end
            b = (1+(k-1)*20):(20+(k-1)*20);                         %binµÄ·¶Î§c'le         
            test_spike(:,k,i,j) = mean(test_trial(i,j).spikes(:,b),2);  
            test_pos(1,k,i,j) = (test_trial(i,j).handPos(1,(20+(k-1)*20)));
            test_pos(2,k,i,j) = (test_trial(i,j).handPos(2,(20+(k-1)*20)));

            temp = (test_trial(i,j).handPos(1,(20+(k)*20)));
            temp2 = (test_trial(i,j).handPos(2,(20+(k)*20)));
            test_pos(3,k,i,j) = (temp-test_pos(1,k,i,j))./20;
            test_pos(4,k,i,j) = (temp2 -test_pos(2,k,i,j))./20;
            k = k+1;
        end
    end
end
%A=[1,0,20,0;0,1,0,20;0,0,1,0;0,0,0,1];
%result = A*train_pos(:,2,1,1);
%result2 = train_pos(:,3,1,1)-train_pos(:,2,1,1);

%for i = 1:8
%    figure;
%    for j = 1:trial
%        haha = find(train_posx(:,j,i)==0);
%        train_posx(haha,j,i) = nan;
%        %train_posx(1,j,i) = 0;
%        plot(train_posx(:,j,i),'r');
%        hold on
%        haha = find(train_posy(:,j,i)==0);
%        train_posy(haha,j,i) = nan;
%        %train_posy(1,j,i) = 0;
%        plot(train_posy(:,j,i),'b');  
%        hold on
%    end
%end


%for i = 1:8
%    figure;
%    for j = 1:trial
%        haha = find(train_posx(:,j,i)==0);
%        train_pos(haha,j,i) = nan;
%        %train_posx(1,j,i) = 0;
%        plot(train_pos(:,j,i),'r');
%        hold on

%        haha = find(train_pos(:,j,i)==0);
%        train_pos(haha,j,i) = nan;
        %train_posy(1,j,i) = 0;
%        plot(train_pos(:,j,i),'b');  
%        hold on
%    end
%end