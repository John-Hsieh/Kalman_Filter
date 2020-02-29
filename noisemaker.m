function result = noisemaker(sigma)
    [V,D] = eig(sigma);
    A = V*sqrt(D);
    x = randn(1,size(sigma,1));
    result = x*A';
    result2 = cov(result);
end