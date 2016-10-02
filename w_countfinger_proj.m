function [ nfinger ] = w_countfinger_proj( binamask,thre )
% Counting how many aparted fingers are in the image by projection the binary mask on y axis.
% input: 
% 1. binamask: binary mask of hand area of target image
% 2. thre: threshold cascade of how many fingers
% output
% 1. nfinger: how many fingers are detected
% date: 2015.dec.8
% by W&OJ, BME 790.02L

proj = sum(binamask,2)';
index = find(proj(5:end-5)~=0);
maxval = max(proj(5:end-5));
index = index(1);
val = median(proj(index:index+40));
per = val/maxval;
if per<thre(1)
    nfinger = 1;
else
    if per<thre(2)
        nfinger = 2;
    else
        if per<thre(3)
            nfinger = 3;
        else
            nfinger = 4;
        end
    end
end
end

