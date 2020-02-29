haha = sum(squeeze(train(:,j,:,k)),1)'./91;
neuronnum = 97;

classbin = zeros(neuronnum,class,bins);
for j = 1:class
    for k = 1:bins
       classbin(:,k,j) = sum(squeeze(train(:,:,k,j)),1)./91';%sum(,2);
    end
end
for i = 1:class
    figure;
    imagesc(classbin(:,:,i));
    xlabel('# of Bin');
    ylabel('# of Neuron');
    colorbar

end


    
    

