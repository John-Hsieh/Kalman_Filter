function errorrate = errorfounder(trial,class,phi,V,A,Q,R,C,test_pos,test_spike)

predicted(:,1) = phi(:,1,class);

testcov = zeros(4,4);
testcov = V(1:4,1:4,class); %eye(4,4);

errorrate = 0;
counter = 0;
i = 2;

while(test_pos(:,i,trial,class)~=[0;0;0;0])
    disp(i)
    predicted(:,i) = A*predicted(:,i-1);%+noisemaker(testcov)';
    testcov = A*testcov*A'+Q;
    
    %after measure amendment
    K = testcov*C'*pinv(C*testcov*C'+R);
    haha = C*predicted(:,i);
    haha1 = test_spike(:,i,trial,class);
    predicted(:,i) = predicted(:,i)+K*(haha1-haha);
    testcov = (testcov - K*C*testcov);
    
    %measure
    
    margin = test_pos(:,i,trial,class)-predicted(:,i);
    errorrate = errorrate + sqrt(margin(1,1)^2+margin(2,1)^2);
    counter = counter+1;
    i = i+1;
end
errorrate = errorrate/counter;