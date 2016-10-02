function[rmax, gmax, bmax] = rgb(colorimage, blankname)

blank = imread(blankname);

%Getting the separate components for rgb
redimage = colorimage;
blueimage = colorimage;
greenimage = colorimage;
redimage(:,:,2:3) = 0;
blueimage(:,:,1:2) = 0;
greenimage(:,:,[1,3]) = 0;

%rgb for blank slate
blankr = blank;
blankg = blank;
blankb = blank;
blankr(:,:,2:3) = 0;
blankg(:,:,[1 3]) = 0;
blankb(:,:,1:2) = 0;

%Use the avg of the blank picture as a threshold to eliminate background of
%colored pictures
addedimg = double(redimage(:,:,1))+double(greenimage(:,:,2))+double(blueimage(:,:,3));
addedblank = double(blankr(:,:,1))+double(blankg(:,:,2))+double(blankb(:,:,3));
threshold = mean(mean(addedblank));
ind1 = find(addedimg >= threshold);

redimage(ind1) = 0;
%imshow(redimage)

gim = double(greenimage(:,:,2));
gim(ind1) = 0;
greenimage(:,:,2) = gim;
%imshow(greenimage)

bim = double(blueimage(:,:,3));
bim(ind1) = 0;
blueimage(:,:,3) = bim;

[row, col] = size(greenimage);

%Finding max points of rgb
maxr = max(max(redimage(:,:,1)));
maxg = max(max(greenimage(floor(row/2):row,:,2)));
maxb = max(max(blueimage(:,:,3)));
[indrx indry] = find(redimage(:,:,1) == maxr);
[indgx indgy] = find(greenimage(:,:,2) == maxg);
[indbx indby] = find(blueimage(:,:,3) == maxb);

%selecting first point
rmax = [indrx(1) indry(1)];
gmax = [indgx(1) indgy(1)];
bmax = [indbx(1) indby(1)];
end
