function[letter] = fist_thumbless(image)
% Function determines what letter of the English alphabet the input image
% corresponds to. Only sign letters M and X should fit the criteria to pass
% into this function. These letters are in Thumbless subclass, lacking a
% red tag.
% PARAMETER
% image str: the image file of hand with sign language alphabet letter
% OUTPUT
% letter str: the corresponding English alphabet letter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1. Initialize known red tag value
R_tag = 'None';

% 2. Detect the green and blue tags
G_tag = findgreen(image);
B_tag = findblue(image);

% 3. Find Cartesian coordinates of green and blue tags
[R_XY, G_XY, B_XY] = findtags(image, R_tag, G_tag, B_tag);

% 4. Find the relative distance between the green and blue tag
d_G2B = finddistance(G_XY, B_XY);

% 5. Determine letter M or X based on tested distance data
if d_G2B < 1200
    letter = 'M'
else
    letter = 'X'
end

end
