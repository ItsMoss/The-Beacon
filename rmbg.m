function[object] = rmbg(image, bg)
% Function is designed to isolate the image of an object from its
% background.
% PARAMETERS
% image: image of the object with its background
% bg: image of only the background without object
% OUTPUT
% object: image of only the object without the background

an_image = imread(image);
a_bg = imread(bg);

% R_image = an_image;
% R_image(:,:,2:3) = 0;
% 
% G_image = an_image;
% G_image(:,:,[1 3]) = 0;
% 
% B_image = an_image;
% B_image(:,:,1:2) = 0;

figure(1)
subplot(1,2,1)
imagesc(an_image)

a_bg = a_bg(length(an_image(:,1)),length(an_image(1,:)));

thr = 0.8;

subplot(1,2,2)
object = an_image - thr * a_bg;
imagesc(object)

end