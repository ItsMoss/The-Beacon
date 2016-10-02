function[green_tag] = findgreen(image)
% Function is designed to find the spatial position of the green tag worn
% on the thumb of the glove in the input image.
% PARAMETERS
% image str: image file of the hand
% OUTPUT
% green_tag: single index approximating pixel at center of the green tag
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1. Import image
an_image = imread(image);

% 2. Define boundaries for hue corresponding to known green tag
max_R = 183;
min_R = 142;
max_G = 208;
min_G = 175;
max_B = 90;
min_B = 51;

% 3. Define each color matrix
R = an_image(:,:,1); % red
G = an_image(:,:,2); % green
B = an_image(:,:,3); % blue

% 4. Specify the indices that fall within boundary guidelines
green_R = R >= min_R & R <= max_R;
green_G = G >= min_G & G <= max_G;
green_B = B >= min_B & B <= max_B;

% 5. Identify the corresponding indices within imported image and find
% approximate central one
green_tag = green_R & green_G & green_B;
green_tag = find(green_tag == 1);
green_tag = median(green_tag);
green_tag = round(green_tag); % must round to nearest integer since indices
% cannot be decimals AND using the median command in line 34 may produce a
% decimal

% 6. Initialize tagged image and attempt to mark that pixel
tagged_image = an_image;
try
    tagged_image(green_tag) = 0;
catch
    green_tag = 'None'; % this is for if green tag is completely hidden in image
end

% % 7. Plot orignal image next to image marked on green tag
% figure(1)
% subplot(1,2,1)
% imshow(an_image)
% 
% subplot(1,2,2)
% imshow(tagged_image) % must zoom in to visually see the mark!

end