function [ w ] = perceptron2layer( patterns, targets, epochs, eta, nbhidden, alpha )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
rng(2);
ndata=size(patterns,2);

patterns=[patterns; ones(1,ndata)]
w=randn(nbhidden, size(patterns,1));
v=randn(size(targets,1), nbhidden+1);

dw=zeros(size(w));
dv=zeros(size(v));
error=zeros(epochs,1);
for ii=1:epochs
    %forward
    hin = w * patterns;
    hout = [2 ./ (1+exp(-hin)) - 1 ; ones(1,ndata)];
    oin = v * hout;
    out = 2 ./ (1+exp(-oin)) - 1;
    
    %backward
    delta_o = (out - targets) .* ((1 + out) .* (1 - out)) * 0.5;
    delta_h = (v' * delta_o) .* ((1 + hout) .* (1 - hout)) * 0.5;
    delta_h = delta_h(1:nbhidden, :);
    
    %changing of weights
    dw = (dw * alpha) - (delta_h * patterns') * (1-alpha);
    dv = (dv * alpha) - (delta_o * hout') * (1-alpha);
    w = w + dw .* eta;
    v = v + dv .* eta;
    error(ii)= sum(sum(abs(sign(out) - targets)./2));
end
figure(2)
plot(error)