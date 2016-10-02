function[red_XY, green_XY, blue_XY, img_Y] = findtags(image, red_index, green_index, blue_index)
% Function is designed to take the tag locations from an input image and
% convert them to Cartesian coordinates assuming bottomest left pixel of the
% image is at the origin (0,0).
% PARAMETERS
% image str: image file of the hand
% red_index: single value of index (pixel) location of red tag in image
% green_index: single value of index (pixel) location of green tag in image
% blue_index: single value of index (pixel) location of blue tag in image
% OUTPUTS
% red_XY: 1x2 array representing Cartesian coordinates of red tag ([X,Y])
% green_XY: 1x2 array representing Cartesian coordinates of green tag
% blue_XY: 1x2 array representing Cartesian coordinates of blue tag
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1. Import the image
an_image = imread(image);

% 2. Find the total Y dimension length of the image
img_Y = length(an_image(:,1,1));

% 3. Calculate the x and y coordinates of the tag

% Make input variables easier/quicker to call
R = red_index;
G = green_index;
B = blue_index;

% Calculations
% Red
try
    if strcmp(R,'None') == 1
        red_XY = 'None';
    else
        N = R / img_Y;
        redX = floor(N);
        M = N - redX;
        redY = img_Y - img_Y * M;
        
        red_XY = [redX, redY];
    end
catch
    N = R / img_Y;
    redX = floor(N);
    M = N - redX;
    redY = img_Y - img_Y * M;
    
    red_XY = [redX, redY];
end

% Green
try
    if strcmp(G,'None') == 1
        green_XY = 'None';
    else
        N2 = G / img_Y;
        greenX = floor(N2);
        M2 = N2 - greenX;
        greenY = img_Y - img_Y * M2;
        
        green_XY = [greenX, greenY];
    end
catch
    N2 = G / img_Y;
    greenX = floor(N2);
    M2 = N2 - greenX;
    greenY = img_Y - img_Y * M2;

    green_XY = [greenX, greenY];
end

% Blue
try
    if strcmp(B,'None') == 1
        blue_XY = 'None';
    else
        N3 = B / img_Y;
        blueX = floor(N3);
        M3 = N3 - blueX;
        blueY = img_Y - img_Y * M3;

        blue_XY = [blueX, blueY];
    end
catch
    N3 = B / img_Y;
    blueX = floor(N3);
    M3 = N3 - blueX;
    blueY = img_Y - img_Y * M3;

    blue_XY = [blueX, blueY];
end

end