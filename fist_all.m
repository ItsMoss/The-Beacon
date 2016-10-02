function[answer] = fist_all(imgstring)
%Function used to determine between fists showing index and thumb
%consists of letters A, E, N, T
name = imgstring;
img = importdata(name);
blankname = '01-Blank.jpg';
%Obtains the first points of each of the tape indices
%e.g. rmax = [y x] indices
[rmax, gmax, bmax] = rgb(img,blankname);
a = sqrt((rmax(2)-bmax(2))^2+(rmax(1)-bmax(1))^2);
b = sqrt((gmax(2)-bmax(2))^2+(gmax(1)-bmax(1))^2);
c = sqrt((gmax(2)-rmax(2))^2+(gmax(1)-rmax(1))^2);

radtodeg = 180/pi;

angle = radtodeg * (acos((c^2-a^2-b^2)/(-2*a*b)));

%%
%Following code is conditions for determining the letter.
%Because for A the thumb is always to the right of the index
if rmax(2) >= bmax(2)
    answer = 'A';
%Because the Thumb is always under the index
elseif gmax(1)-rmax(1) <= gmax(1)-bmax(1)
    answer = 'E';
%Threshold determind through experimentation for distance between thumb and
%index finger
elseif angle <= 100
    answer = 'N';
else
    answer = 'T';
end
end