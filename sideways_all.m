function[answer] = sideways_all(imgname)
%%This function is used to determine signs in the sideways category with all
%tapes showing. These consists of the letters G, H, J, Y

colorimage = imread(imgname);

blankname = '01-Blank.jpg';
%Obtains the first points of each of the tape indices
%e.g. rmax = [y x] indices
[rmax, gmax, bmax] = rgb(colorimage,blankname);

%Obtains a binary figure of the hand called "bina"
[ ims,bina ] = w_readcolorful(imgname,1.2);

% figure
% imshow(bina)

%%
%The following code is mainly for differentiation between G and H
%Here pointsx and pointsy are all the x and y values of the hand
%respectively. The top points of the hand is then taken and then graphed.
%Since the middle finger extends past the index finger there will be a
%spike on the H graph at the beginning but not the G (indices start at 0 on
%the top and increase as it goes down)
%max point in first quarter of the graph is given as topmax
%min point given as topmin
[pointsy, pointsx] = find(bina==1);
toppoints = zeros(1,length(bina(1,:)));
n = [1:length(toppoints)];
for ii = 2:length(pointsx)
    if pointsx(ii) ~= pointsx(ii-1)
        toppoints(pointsx(ii)) = pointsy(ii);
    end
end
toppoints(pointsx(1)) = pointsy(1);
%figure
%plot(n,toppoints)
topmax = max(toppoints(1:round(0.25*length(bina(1,:)))));
topmin = toppoints(round(0.25*length(bina(1,:))));

%%
%These are the differential conditions for each letter. For 'Y' the thumb
%has to be to the right of the wrist. For 'J' The distance from Thumb to
%wrist is compared to the distance from index finger to wrist is determined
%for H and G. 
if rmax(2) >= gmax(2)
    answer = 'Y';
elseif sqrt(((rmax(2)-gmax(2))^2)+((rmax(1)-gmax(1))^2)) >= sqrt(((bmax(2)-gmax(2))^2)+((bmax(1)-gmax(1))^2))
    answer = 'J';
elseif topmax-topmin >= 12
    answer = 'H';
else
    answer = 'G';
end

end