%trial 1,4 & trial 1.1
disp(size(test_pos));
figure;
a = test_pos(1,1:10,1,4);
b = test_pos(2,1:10,1,4);
plot(a,b,'k');
hold on
scatter(phi(1,1,4),phi(2,1,4),'d');
hold on 
plotErrorEllipse(phi(1:2,1,4),V(:,:,1)); 
%Do 11 iterations
predicted = zeros(4,10);
predicted(:,1) = phi(:,1,class);
testcov = zeros(4,4);
testcov = V(1:4,1:4,4); %eye(4,4);
for i = 2:10
    %predict
    disp(i)
    predicted(:,i) = A*predicted(:,i-1);%+noisemaker(testcov)';
    testcov = A*testcov*A'+Q;
    disp(testcov);
    
    %after measure amendment
    K = testcov*C'*pinv(C*testcov*C'+R);
    haha = C*predicted(:,i);
    haha1 = test_spike(:,i,1,4);
    predicted(:,i) = predicted(:,i)+K*(haha1-haha);
    testcov = (testcov - K*C*testcov);
    
    %measure
    

    plotErrorEllipse(predicted(1:2,i),testcov); 
    hold on 
end
plot(predicted(1,:),predicted(2,:),'r');
xlabel('x position (mm)');
ylabel('y position (mm)');

count = 0;
totalerror = 0;
for i = 1:8
    for j = 1:91
        totalerror = totalerror + errorfounder(1,1,phi,V,A,Q,R,C,test_pos,test_spike);
        count = count + 1;
    end
end
totalerror = totalerror/count

