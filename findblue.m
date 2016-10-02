function[blue_tag] = findblue(image)
% Function is designed to find the spatial position of the blue tag worn
% on the thumb of the glove in the input image.
% PARAMETERS
% image str: image file of the hand
% OUTPUT
% blue_tag: single index approximating pixel at center of the blue tag
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1. Import image
an_image = imread(image);

% 2. Define boundaries for hue corresponding to known blue tag
max_R = 150;
min_R = 121;
max_G = 206;
min_G = 166;
max_B = 234;
min_B = 189;

% 3. Define each color matrix
R = an_image(:,:,1); % red
G = an_image(:,:,2); % green
B = an_image(:,:,3); % blue

% 4. Specify the indices that fall within boundary guidelines
blue_R = R >= min_R & R <= max_R;
blue_G = G >= min_G & G <= max_G;
blue_B = B >= min_B & B <= max_B;

% 5. Identify the corresponding indices within imported image and find
% approximate central one
blue_tag = blue_R & blue_G & blue_B;
blue_tag = find(blue_tag == 1);
blue_tag = median(blue_tag);
blue_tag = round(blue_tag); % must round to nearest integer since indices
% cannot be decimals AND using the median command in line 34 may produce a
% decimal

% 6. Initialize tagged image and attempt to mark that pixel
tagged_image = an_image;
try
    tagged_image(blue_tag) = 0;
catch
    blue_tag = 'None'; % this is for if blue tag is completely hidden in image
end

% % 7. Plot orignal image next to image marked on blue tag
% figure(1)
% subplot(1,2,1)
% imshow(an_image)
% 
% subplot(1,2,2)
% imshow(tagged_image) % must zoom in to visually see the mark!

end