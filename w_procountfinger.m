% estimate finger numbers by projection
% thresholds = 
ima = ['F.jpg';'Z.jpg';'U.jpg';'D.jpg';'B.jpg';'I.jpg';'R.jpg'];
num = 7;

thre = [0.2,0.3,0.4];
background = '01-Blank.jpg';
figure;
for k = 1:1:num
[ num_finger,binamask,edgemask ] = w_countfinger_edge( ima(k,:), background,0 );
% imshow(binamask);axis image;colormap(gray);
[row,col] = size(binamask);
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
[centers,radii,metric] = imfindcircles(binamask,[1,20]);
if(isempty(centers))
    nfinger1 = 0;
else
    nfinger1 = length(centers(:,1));
end
subplot(4,2,k);
plot(1:1:row,proj);
title([ima(k,:),'  fingeraccValue = ', num2str(nfinger),'  ',num2str(per)]);
end