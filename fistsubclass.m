function[subclass] = fistsubclass(image)
% Function takes an image that has already been tagged as being in the
% 'fist' class and further determines its subclass based off of what
% colored markers are visible in the image.
% PARMAETER
% image str: image file of the hand
% OUTPUT
% subclass str: the subclass input image is placed (thumbless,indexless, all)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1. Run image through each of the tag detector functions
R_tag = findred(image);
% G_tag = findgreen(image); % green tag not needed for fist class letters
B_tag = findblue(image);

% 2. Determine the class based on whether a tag is missing

% Subclass I: Thumbless (no red tag)
try
    if strcmp(R_tag,'None') == 1
        subclass = 'thumbless';
% Subclass II: Indexless (no blue tag)        
    elseif strcmp(B_tag,'None') == 1
        subclass = 'indexless';
% Subclass III: All (has all tags)
    else
        subclass = 'all';
    end
catch
    subclass = 'all';
end        

end