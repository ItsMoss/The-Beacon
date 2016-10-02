function [ num_finger,binamask,edgemask ] = w_countfinger_edge( ims,bina,flag_plot )
% Counting how many aparted fingers are in the image by edge detection.
% input: 
% 1. ims: target image
% 2. bina: binary mask of original image for hand area
% 3. flag_plot: 1 for plot; 0 for not plot
% output
% 1. num_finger: number of aparted fingers
% 2. binamask: binary mask for hand area
% 3. edgemask: edge of hand area
% date: 2015.dec.5
% by W&OJ, BME 790.02L

% parameters:
mdradius = 30; % radius of median value filtor
SE = strel('disk', 3, 4); % kernel of image open and close
% flag_plot = 1; % 1: plot, 0: not plot
[row,col] = size(bina);
%% image close (stuff the inner part of hand)
% use a disk kernel
binase = imclose(bina,SE);
if(flag_plot) % plot section 1
    figure;
    subplot(1,5,1);imagesc(ims/200);axis image;
    subplot(1,5,2);imagesc(bina);colormap('gray');axis image;
    subplot(1,5,3);imagesc(binase);colormap('gray');axis image;
end
%% find the independent connectivity blocks in the hand area and stuff them
L = bwlabel(~binase);
binase(L>1) = 1;

%% image open (smooth the edge of the hand)
binamask = imopen(binase,SE);
%% edge detection
edgemask = edge(binamask);
%% prpjection on y dimension
pro_edge = sum(edgemask,2);
%% median value filtor on the 1 dimensional projection
mpro_edge = medfilt1(pro_edge,mdradius); % with wide radius, important parameters
if(flag_plot) % plot section 2
    subplot(1,5,4);imagesc(binase);colormap('gray');axis image;
    subplot(1,5,5);imagesc(binamask);colormap('gray');axis image;
    figure;imshow(edgemask);colormap('gray');axis image;
    figure;
    subplot(2,1,1);plot(1:1:row,pro_edge');
    subplot(2,1,2);plot(1:1:row,mpro_edge');
end
num_finger = floor(max(mpro_edge)/2);%count independent fingers 
end

