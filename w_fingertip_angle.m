function [ centers,angle,wcenter] = w_fingertip_angle( binamask,num_f,flag_plot)
% Function locates the finger tips and calulatses the angles of the two fingles take weight center as reference 
% input: 
% 1. binamask: binary mask of hand area
% 2. num_f: number of expected finger tips, 0: no expectation
% 3. flag_plot: 1 plot 0 not plot
% date: 2015.dec.5
% by W&OJ, BME 790.02L
SE = strel('disk', 6, 4); % image open to make edge more smooth
binamask = imopen(binamask,SE);

[centers,radii,metric] = imfindcircles(binamask,[2,20]);
num_c = length(centers(:,1));
% if a lot of finger tips are found, only take the expected number of
% them
if num_f > 0 && num_f < num_c;
    centers = centers(1:num_f,:);
end
% realign the center according to their y axis;
centers = centers';
[Y,I]=sort(centers(1,:));
centers = centers(:,I);
centers = centers';
% calculate weight center;
[ wc_x,wc_y ] = w_weightcenter( binamask );
wcenter = [ wc_x,wc_y ];
angle = zeros(1,num_c-1);
% calculate the angles between all adjacant fingertips
for k = 1:1:num_c-1
    u = [centers(k,1)-wc_y,centers(k,2)-wc_x];
    v = [centers(k+1,1)-wc_y,centers(k+1,2)-wc_x];
    CosTheta = dot(u,v)/(norm(u)*norm(v));
    angle(k) = acos(CosTheta)*180/pi;
end
% plot
tit = [];
if(flag_plot)
    figure;
    imagesc(binamask);axis image;colormap('gray');
    hold on
    plot(centers(:,1), centers(:,2), 'r*');
    plot(wc_y, wc_x, 'b*');
    for k = 1:1:num_c-1
        plot ([centers(k,1);wc_y],[centers(k,2);wc_x],'b');
        tit = [tit,' |Angle ',num2str(k),' = ', num2str(angle(k))];
    end
    plot ([centers(k+1,1);wc_y],[centers(k+1,2);wc_x],'b');
end
% title(tit);

end

