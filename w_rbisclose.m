function [ sign ] = w_rbisclose( rmc,gmc,bmc,thclose )
% If red tape and blue tape is close 
% input: 
% 1. rmc, gmc, bmc: coordination of red, green and blue tapes
% 2. thclose: threshold for close judgement 
% output
% 1. sign: 1, red and blue tape are close, 0 not close
% date: 2015.dec.8
% by W&OJ, BME 790.02L

dis1 = sqrt((rmc(1)-bmc(1))^2+(rmc(2)-bmc(2))^2);
dis2 = sqrt((rmc(1)-gmc(1))^2+(rmc(2)-gmc(2))^2)*thclose;
sign = (dis1<dis2);
end

