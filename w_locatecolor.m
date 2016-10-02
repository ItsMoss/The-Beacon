function [ rmc,gmc,bmc ] = w_locatecolor( ima,thper,flag_plot )
% locate the center of 3 color tapes
% input: 
% 1. ima: target image
% 2. background: background image
% 3. thper: percentage of threshold value determine,recommend 1.2;
% output
% 1. rmc,gmc,bmc: [row,col] coordination of the color tape center
% date: 2015.dec.7
% by W&OJ, BME 790.02L
local_thre = 0.8;

[ ims,mask ] = w_readcolorful( ima, thper);
rm_ims = ims(:,:,1).*mask; 
[row,col] = size(rm_ims);

rmplot = rm_ims;

% find red tape center
maxrm = max(rm_ims(:));
[rmx,rmy] = find(rm_ims == maxrm );
rmx = rmx(1);
rmy = rmy(1);

upx = (rmx-20<=0).*1+(rmx-20>0).*(rmx-20);
lowx = (rmx+20>=row).*row+(rmx+20<row).*(rmx+20);
lefty = (rmy-20<=0).*1+(rmy-20>0).*(rmy-20);
righty = (rmy+20>=col).*col+(rmy+20<col).*(rmy+20);

[rmx_local,rmy_local] =  find(rm_ims(upx:1:lowx,lefty:1:righty) >= maxrm*local_thre );
rmx_local = rmx_local+upx;
rmy_local = rmy_local+lefty;
rmxcenter = median(rmx_local);
rmycenter = median(rmy_local);

rmc = round([rmxcenter,rmycenter]);

% find blue tape center
rm_ims = ims(:,:,3).*mask; 
maxrm = max(rm_ims(:));
[rmx,rmy] = find(rm_ims == maxrm );
rmx = rmx(1);
rmy = rmy(1);

upx = (rmx-20<=0).*1+(rmx-20>0).*(rmx-20);
lowx = (rmx+20>=row).*row+(rmx+20<row).*(rmx+20);
lefty = (rmy-20<=0).*1+(rmy-20>0).*(rmy-20);
righty = (rmy+20>=col).*col+(rmy+20<col).*(rmy+20);

[rmx_local,rmy_local] =  find(rm_ims(upx:1:lowx,lefty:1:righty) >= maxrm*local_thre );
rmx_local = rmx_local+upx;
rmy_local = rmy_local+lefty;
rmxcenter = median(rmx_local);
rmycenter = median(rmy_local);

bmc = round([rmxcenter,rmycenter]);

% find green tape center
rm_ims = ims(:,:,2).*mask; 
bound = (bmc(1)<rmc(1)).*rmc+(bmc(1)>=rmc(1)).*bmc;
rm_ims(1:bound,:) = 0;

maxrm = max(rm_ims(:));
[rmx,rmy] = find(rm_ims == maxrm );
rmx = rmx(1);
rmy = rmy(1);

upx = (rmx-20<=0).*1+(rmx-20>0).*(rmx-20);
lowx = (rmx+20>=row).*row+(rmx+20<row).*(rmx+20);
lefty = (rmy-20<=0).*1+(rmy-20>0).*(rmy-20);
righty = (rmy+20>=col).*col+(rmy+20<col).*(rmy+20);

[rmx_local,rmy_local] =  find(rm_ims(upx:1:lowx,lefty:1:righty) >= maxrm*local_thre );
rmx_local = rmx_local+upx;
rmy_local = rmy_local+lefty;
rmxcenter = median(rmx_local);
rmycenter = median(rmy_local);

gmc = round([rmxcenter,rmycenter]);

if(flag_plot)
figure;
subplot(1,2,1);
imshow(rmplot/255);hold on;
subplot(1,2,2);
imshow(rmplot/255);hold on;
plot(rmc(2),rmc(1),'r*');
plot(bmc(2),bmc(1),'b*');
plot(gmc(2),gmc(1),'g*');
end
end
