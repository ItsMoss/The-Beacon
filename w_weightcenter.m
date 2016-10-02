function [ wc_x,wc_y ] = w_weightcenter( binamask )
% calculate weight center coordination from binary binamask of hand area
% date: 2015.dec.6
% by W&OJ, BME 790.02L
[index_x,index_y] = find(binamask == 1);
wc_x = round(mean(index_x));
wc_y = round(mean(index_y));

end

