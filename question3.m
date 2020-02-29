%trial 1,4 & trial 1.1
disp(size(test_pos));
figure;
a = test_pos(1,1:11,1,1);
b = test_pos(2,1:11,1,1);
plot(a,b,'k');
hold on
originpos = phi(1,1,1);
scatter(phi(1,1,1),phi(2,1,1),'d');
hold on 
plotErrorEllipse(phi(1:2,1,1),V(:,:,1)); 
%Do 11 iterations
predicted = zeros(4,11);
predicted(:,1) = phi(:,1,1);
testcov = zeros(4,4);
testcov = V(1:4,1:4,1); %eye(4,4);
for i = 2:11
    %predict
    disp(i)
    predicted(:,i) = A*predicted(:,i-1);%+noisemaker(testcov)';
    testcov = A*testcov*A'+Q;
    disp(testcov);
    
    %after measure amendment
    K = testcov*C'*pinv(C*testcov*C'+R);
    haha = C*predicted(:,i);
    haha1 = test_spike(:,i,1,1);
    predicted(:,i) = predicted(:,i)+K*(haha1-haha);
    testcov = (testcov - K*C*testcov);
    
    %measure
    

    plotErrorEllipse(predicted(1:2,i),testcov); 
    hold on 
end
plot(predicted(1,:),predicted(2,:),'r');
xlabel('x position (mm)');
ylabel('y position (mm)');