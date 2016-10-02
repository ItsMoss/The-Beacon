function[letter] = side_wristless(image)
% Function determines what letter of the English alphabet the input image
% corresponds to. Only sign letters P and Q should fit the criteria to pass
% into this function. These letters are in Wristless subclass, lacking a
% green tag.
% PARAMETER
% image str: the image file of hand with sign language alphabet letter
% OUTPUT
% letter str: the corresponding English alphabet letter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1. Initialize known green tag value
G_tag = 'None';

% 2. Detect the red and blue tags
R_tag = findred(image);
B_tag = findblue(image);

% 3. Find Cartesian coordinates of red and blue tags
[R_XY, G_XY, B_XY] = findtags(image, R_tag, G_tag, B_tag);

% 4. Find the relative distance between the red and blue tag
d_R2B = finddistance(R_XY, B_XY);

% 5. Determine letter P or Q based on tested distance data
if d_R2B > 685
    letter = 'P';
else
    letter = 'Q';
end

end