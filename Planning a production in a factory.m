function [x, y, fval] = labA(R, P, K, seed)
% LABA Solves an instance of lab A.
%
% [x, y, fval] = LABA(P, R, K, seed)
%
% Input:
%
% R    Number of different types of raw materials.
% P    Number of products.
% K    Number of scenarios.
% seed Seed to the random number generator. (optional)
%
% Output:
% x    Vector describing the number of units to produce of each product.
% y    Vector describing the number of units to purchase of each raw
%      material.
% fval Expected profit.
%
% Example:
%  [x, y, fval] = labA(4,3,2,1)
%
% x =
%
%          0
%          0
%    13.2317
%
%
% y =
%
%    11.9914
%    17.7403
%     8.6423
%    19.7426
%
%
% fval =
%
%     7.7615
%
if nargin < 4
[c, B, g, pi, D ] = make_instance(R, P, K);
else
[c, B, g, pi, D ] = make_instance(R, P, K, seed);
end
% Your code goes here...
lb=zeros(K*P+P,1); %lower bound 
E=D'; % the transpose of demand 
ub=[E(:)' inf(1,P)] ; %upper bound 
I=eye(P*K); % to create identity matrix of products * scenarios
S=-eye(P); % to create negative identity matrix for the right hand side
Q=repmat(S,K,1); %repeat matrix k times in one column
A=[I Q]; %to create a matrix with both I and Q
C=c*pi'; % expected earnings from the objective function 
f=[-C(:)' g'*B]; % the objective function that contains negative expected earnings and the positive cost
b=zeros(1,K*P); % zero matrix in the size scenarios*products
[z  fval] = linprog(f,A,b,[],[],lb,ub); %linprog solver 
x = z(P*K+1:end); %how much you sell 
y = B*x; %how much you produce 
fval = -fval; %to convert the negative value of expected profit into the positive (max=-min)


