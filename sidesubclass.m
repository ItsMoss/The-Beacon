function[subclass] = sidesubclass(image)
% Function takes an image that has already been tagged as being in the
% 'side' class and further determines its subclass based off of what
% colored markers are visible in the image.
% PARMAETER
% image str: image file of the hand
% OUTPUT
% subclass str: the subclass input image is placed (wristless OR all)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1. Run image through the tag detector functions
% R_tag = findred(image); % red tag not needed for side class letters
G_tag = findgreen(image); 
% B_tag = findblue(image); % blue tag not needed for side class letters

% 2. Determine the class based on whether or not a green tag is missing

% Subclass I: Wristless (no green tag)
try
    if strcmp(G_tag,'None') == 1
        subclass = 'wristless';
% Subclass II: All (has all tags)
    else
        subclass = 'all';
    end
catch
    subclass = 'all';
end        

end