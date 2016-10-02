function[letter] = fist_indexless(image)
% Function determines what letter of the English alphabet the input image
% corresponds to. Only sign letters C, O, and S should fit the criteria to 
% pass into this function. These letters are in Indexless subclass, lacking
% a blue tag.
% PARAMETER
% image str: the image file of hand with sign language alphabet letter
% OUTPUT
% letter str: the corresponding English alphabet letter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1. Initialize known blue tag value
B_tag = 'None';

% 2. Detect the red and green tags
R_tag = findred(image);
G_tag = findgreen(image);

% 3. Get the Cartesian coordinates for the tags
[R_XY, G_XY, B_XY] = findtags(image, R_tag, G_tag, B_tag);

% 4. Find relative distances between green and red tags

% True distance
d_G2R = finddistance(G_XY, R_XY);

% Lateral distance (x direction only)
dX_G2R = R_XY(1) - G_XY(1);

% 5. Determine letter C, O, or S based off of calculated distances
if d_G2R < 900
    letter = 'S'
else
    if dX_G2R > 505
        letter = 'C'
    else
        letter = 'O'
    end
end

end