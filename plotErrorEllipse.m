function plotErrorEllipse(mu, Sigma)
    Sigma = Sigma(1:2,1:2);
    [V, D] = eig(Sigma);
    t = linspace(0, 2 * pi);
    a = (V * sqrt(D)) * [cos(t(:))'; sin(t(:))'];

    plot(a(1, :) + mu(1), a(2, :) + mu(2),'r');