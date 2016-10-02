function [ pro_edge ] = w_countfinger_f( ima, background )
% Counting how many aparted fingers are in the image.
% input: 
% 1. ima: target image
% 2. background: background image
% output
% 1. num_finger: number of aparted fingers
% date: 2015.dec.5
% by W&OJ, BME 790.02L

% parameters:
mdradius = 50; % radius of median value filtor
th_percent = 0.75; % threshold value of binarize 
SE = strel('disk', 1, 4); % kernel of image open and close
flag_plot =0; % 1: plot, 0: not plot



%% read in target image and background picture
im = double(imread(ima));
% flip it up if the image is lying on the ground
im = im(:,:,3);
ims = imresize(im,0.1);
[row,col] = size(ims);
if (col>row)
    ims = ims';
    ims = fliplr(ims);
    [row,col] = size(ims);
end
bck = imread(background);
bck = double(bck(:,:,3));

%% threshold according to background intensity and binarize the image
avebc = mean(bck(:))*th_percent;
bina = zeros(size(ims));
bina(ims < avebc) = 1;

%% image close (stuff the inner part of hand)
% use a disk kernel
binase = imclose(bina,SE);
% if(flag_plot) % plot section 1
%     figure;
%     subplot(1,5,1);imagesc(ims);colormap('gray');axis image;
%     subplot(1,5,2);imagesc(bina);colormap('gray');axis image;
%     subplot(1,5,3);imagesc(binase);colormap('gray');axis image;
% end
%% find the independent connectivity blocks in the hand area and stuff them
L = bwlabel(~binase);
binase(L>1) = 1;

%% image open (smooth the edge of the hand)
binaseo = imopen(binase,SE);
%% edge detection
edbinase = edge(ims);
%% prpjection on y dimension
pro_edge = sum(edbinase,2);

%% median value filtor on the 1 dimensional projection
mpro_edge = medfilt1(pro_edge,mdradius); % with wide radius, important parameters
if(flag_plot) % plot section 2
%     subplot(1,5,4);imagesc(binase);colormap('gray');axis image;
%     subplot(1,5,5);imagesc(binaseo);colormap('gray');axis image;
%     figure;
%     imshow(edbinase);colormap('gray');axis image;
    figure;
    subplot(2,1,1);plot(1:1:row,pro_edge');
    subplot(2,1,2);plot(1:1:row,mpro_edge');
end
num_finger = floor(max(mpro_edge)/2);%count independent fingers 
% [platue,platuex] = findpeaks(-1.*pro_edge); % start of fingers
% [peak,peakx] = findpeaks(pro_edge);
    

end