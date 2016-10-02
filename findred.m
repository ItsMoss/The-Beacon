function[red_tag] = findred(image)
% Function is designed to find the spatial position of the red tag worn on
% the thumb of the glove in the input image.
% PARAMETERS
% image str: image file of the hand
% OUTPUT
% red_tag: single index approximating pixel at center of the red tag
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1. Import image
an_image = imread(image);

% 2. Define boundaries for hue corresponding to known red tag
max_R = 255;
min_R = 132;
max_G = 95;
min_G = 28;
max_B = 98;
min_B = 29;

% 3. Define each color matrix
R = an_image(:,:,1); % red
G = an_image(:,:,2); % green
B = an_image(:,:,3); % blue

% 4. Specify the indices that fall within boundary guidelines
red_R = R >= min_R & R <= max_R;
red_G = G >= min_G & G <= max_G;
red_B = B >= min_B & B <= max_B;

% 5. Identify the corresponding indices within imported image and find
% approximate central one
red_tag = red_R & red_G & red_B;
red_tag = find(red_tag == 1);
red_tag = median(red_tag);
red_tag = round(red_tag); % must round to nearest integer since indices
% cannot be decimals AND using the median command in line 34 may produce a
% decimal

% 6. Initialize tagged image and attempt to mark that pixel
tagged_image = an_image;
try
    tagged_image(red_tag) = 0;
catch
    red_tag = 'None'; % this is for if red tag is completely hidden in image
end

% % 7. Plot orignal image next to image marked on red tag
% figure(1)
% subplot(1,2,1)
% imshow(an_image)
% 
% subplot(1,2,2)
% imshow(tagged_image) % must zoom in to visually see the mark!

end