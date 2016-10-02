function[distance] = finddistance(coordinate1, coordinate2)
% Function finds the distance between two Cartesian coordinates
% PARAMETERS
% coordinate1: 1x2 array representing Cartesian coordinates in form [x,y]
% coordinate2: 1x2 array representing Cartesian coordinates in form [x,y]
% OUTPUT
% distance: single value that is the calculated distance between both points
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1. Rename input coordinates to quick/easy names to call
C1 = coordinate1;
C2 = coordinate2;

% 2. Separate the x and y components from each coordinate

% First
C1X = C1(1);
C1Y = C1(2);

% Second
C2X = C2(1);
C2Y = C2(2);

% 3. Calculate distance
distance = sqrt((C2X - C1X)^2 + (C2Y - C1Y)^2);

end