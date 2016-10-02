function [ ims,bina ] = w_readcolorful(ima, thper)
% read in hand with colorful tapes and make a overall mask for hand area
% input: 
% 1. ima: target image
% 2. background: background image
% 3. thper: percentage of threshold value determine,recommend 1.2;
% output
% 1. bina: binary mask of hand area
% 2. ims: downsampled original hand sign image, not really useful
% date: 2015.dec.5
% by W&OJ, BME 790.02L
% ima = 'D.jpg'; background = '01-Blank.jpg'; thper = 1.2;
im = imread(ima);
% im = rgb2gray(im);
im = double(im);
ims = imresize(im,0.1);

% bck = imread(background );
% % bck = rgb2gray(bck);
% bck = double(bck);
% bcks = imresize(bck,0.1);

mask = zeros(size(ims(:,:,1)));
% imshow(ims/255);figure;
for k = 1:1:3
    imc = ims(:,:,k);
%     bckc = bcks(:,:,k);
    
    avebc = graythresh(imc/255)*255*thper;
%     avebc = mean(bckc(:))*thper;
    bina = zeros(size(imc));
    bina(imc < avebc) = 1;
    mask = mask + bina;
%     subplot(1,4,k);
%     imshow(bina);
end
mask(mask>1) = 1;
% subplot(1,4,4);
% imshow(bina);
bina = mask;
% flip it up if the image is lying on the ground
[row,col] = size(bina);
if (col>row)
    imsssss = zeros(size(ims,2),size(ims,1),size(ims,3));
    for k = 1:1:size(ims,3)
        imsssss(:,:,k) = ims(:,:,k)';
    end
    ims = imsssss;
    bina = bina';
    bina = fliplr(bina);
end
end
% end