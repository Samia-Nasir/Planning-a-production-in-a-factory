function [c, B, g, pi, D] = make_instance(R, P, K, seed)
% MAKE_INSTANCE generates a problem instance for laboration A.
%
%    [c, B, g, pi, D] = MAKE_INSTANCE(R, P, K, seed) returns an instance of
%    the problem in lab A described by the output parameters.
%
%    Input:
%    R    Number of different types of raw materials.
%    P    Number of products.
%    K    Number of scenarios.
%    seed Random number generator seed. (optional)
%
%
%    Output:
%    c    A P vector. c(p): the selling price for one unit of probuct p.
%    B    An R by P matrix. B(r,p): the amount of raw material r used to
%         produce one unit of product p.
%    g    An R vector. g(r): the buying price for one unit of 
%         raw material r.
%    pi   A K vector. pi(k): the probability of scenario k.
%    D    A K by P matrix. D(k,p): the demand of product p in scenario k 
%         in units.
%
%
% Example:
% Generate a problem with 4 different raw materials, 3 different products,
% 2 scenarios and seeding the random number generator with seed
% 1 (so we get the same random numbers each time we run the function).
%
% [c, B, g, pi, D] = make_instance(4, 3, 2, 1)
%
% c =
%
%     3.5878
%     2.9328
%     5.2905
%
%
% B =
%
%     0.7229    0.6552    0.9063
%     1.8050    0.7510    1.3407
%     0.6844    0.7563    0.6532
%     0.5742    1.0933    1.4921
%
%
% g =
%
%     0.4702
%     1.5495
%     0.8857
%     1.0870
%
%
% pi =
%
%     0.3134
%     0.6866
%
%
% D =
%
%   119.2535    3.1108   13.2317
%   118.3514    7.0209   81.6272
%

if nargin == 4
    rng(seed);
end;

B = abs(lognrnd(0,.5,R,P));  % Determine the usage of raw material for each product.
g = abs(lognrnd(0,.5,R,1));  % Prices for raw material.
c = B'*g.*lognrnd(0,.1,P,1); % Prices for products, with random markup.

pi = rand(K+1,1);            % Generate an approx. uniform sample over the
pi(1) = 0;                   % probability simplex.
pi(K+1) = 1;
pi = diff(sort(pi));

D = abs(lognrnd(3,1,K,P));   % Generate the demand for each scenario.

end
