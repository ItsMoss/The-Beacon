function [ rdu ] = w_dtm_rud( ims,bmc )
% Determine whether R or D or U;
% input: 
% 1. ims: original downsampled image.
% output
% 1. rdu: 1, R; 2, D; 3, U
% date: 2015.dec.8
% by W&OJ, BME 790.02L
thre = 100; % threshold of black glove;

image = ims(:,:,1);
line_r = image(bmc(1),:);
line_c = image(:,bmc(2));

line_r = medfilt1(line_r,5);
line_c = medfilt1(line_c,5);

if(min(line_r)>=thre)
    rdu = 2; % D
else
    if(min(line_c(1:bmc(1)))>=thre)
        rdu = 3; % U
    else
        rdu = 1; % R
    end
end
% figure;
% plot(1:1:length(line_r),line_r,'r');ylim([0,255]);
% hold on;
% plot(bmc(2),line_r(bmc(2)),'b*');
% figure;
% plot(1:1:length(line_c),line_c,'r');ylim([0,255]);
% rdu = 1;
% hold on;
% plot(bmc(1),line_c(bmc(1)),'b*');
end

