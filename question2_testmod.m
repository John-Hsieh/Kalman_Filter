A=[1,0,20,0;0,1,0,20;0,0,1,0;0,0,0,1];
Q = train_pos(:,3,1,1);
haha = (-A*train_pos(:,2,1,1))'*A';

%param calculation
A1 = zeros(4,4);
A2 = zeros(4,4);
for j = 1:8
    for k = 1:trial
        for i = 2:size(train_pos(:,:,k,j),2)
            xtemp = train_pos(:,i,k,j);%当前state   
            xtemp2 = train_pos(:,i-1,k,j);
            if(xtemp==[0;0;0;0])
                disp('invalid')
                break;
            end
            A1 = A1 + xtemp*xtemp2';
            A2 = A2 + (xtemp2*xtemp2');
        end
    end
end

A = A1*inv(A2);
Q = zeros(4,4);
counter = 0;
for j = 1:8
    for k = 1:trial
        for i = 2:size(train_pos(:,:,k,j),2)
            xtemp = train_pos(:,i,k,j);%当前state   
            xtemp2 = train_pos(:,i-1,k,j);
            if(xtemp==[0;0;0;0])
                disp('invalid')
                break;
            end
            temp3 = (xtemp-A*xtemp2)*(xtemp-A*xtemp2)';
            Q = Q+temp3;
            counter = counter+1;
        end
    end
end
Q = Q./(counter-91);

C1 = zeros(97,4);
C2 = zeros(4,4);
for j = 1:8
    for k = 1:trial
        for i = 1:size(train_pos(:,:,k,j),2)
            xtemp = train_spike(:,i,k,j);%当前state   
            xtemp2 = train_pos(:,i,k,j);
            if(xtemp2==[0;0;0;0])
                disp('invalid')
                break;
            end
            C1 = C1 + (xtemp*xtemp2');
            C2 = C2 + (xtemp2*xtemp2');
        end
    end
end
C = C1/(C2);
R = zeros(97,97);
counter = 0;
for j = 1:8
    for k = 1:trial
        for i = 1:size(train_pos(:,:,k,j),2)
            xtemp = train_spike(:,i,k,j);%当前state   
            xtemp2 = train_pos(:,i,k,j);
            if(xtemp2==[0;0;0;0])
                disp('invalid')
                break;
            end
            R = R + (xtemp-C*xtemp2)*(xtemp-C*xtemp2)';
            counter = counter+1;
        end
    end
end
R = R./(counter);
