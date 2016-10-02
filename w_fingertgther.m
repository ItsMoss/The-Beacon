ima = 'F.jpg';
background = 'back.jpg';
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

[ num_finger,binamask,edgemask ] = w_countfinger_edge( ima, background,1 );
[ centers,angle,wcenter] = w_fingertip_angle( binamask,0,1 );
[ rmc,gmc,bmc ] = w_locatecolor( ima,background,thper );

num_tip1 = length(centers(:,1));