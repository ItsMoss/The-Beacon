function group = firstSort(lname, bname)
    %% read in target image and background picture
    
    [letter, mask] = w_readcolorful(lname, 0.75);
    if (strcmp(lname, 'D2.jpg') || strcmp(lname, 'D.jpg') || strcmp(lname, 'D3.jpg'))
        [letter, mask] = w_readcolorful(lname, 1.2);
    end
    letter = letter/180;
    letter(:,:,1) = letter(:,:,1).*mask;
    letter(:,:,2) = letter(:,:,2).*mask;
    letter(:,:,3) = letter(:,:,3).*mask;

    red = letter; red(:,:,2) = 0; red(:,:,3) = 0;
    green = letter; green(:,:,1) = 0; green(:,:,3) = 0;
    blue = letter; blue(:,:,1) = 0; blue(:,:,2) = 0;

    [rmax, gmax, bmax] = rgb(letter, bname);
    
    letter = mask;

    [h,w] = size(letter);

    %% edge detection
    % Making a high-pass fitler
    radius = w*0.3;
    filt = ones(h,w);
    [rr, cc] = meshgrid(1:h);
    C = sqrt((rr-(w/2)).^2+(cc-(h/2)).^2)<=(radius);
    filt(C) = 0;

    % FFT the letter image
    fft2d = fft2(letter);
    shifted = fftshift(fft2d);

    % Convolve letter image with HPF
    invShifted = ifft2(fftshift(filt.*shifted));
    magInv = abs(invShifted);
    letter = magInv;

    % Binarize again
    %avgimg2 = mean(letter(:));
    maxedge = max(letter(:));
    mask2 = zeros(size(letter));
    mask2(letter > (maxedge*0.25)) = 1;
    letter = mask2;

    %% Determine category
    group = '';
    letter(1:5, :) = 0;
    letter(end-5:end, :) = 0;
    across = sum(letter, 2);
    down = sum(letter, 1);

    warning('off', 'signal:findpeaks:largeMinPeakHeight');
    topAx = sum(letter(1:floor(h/2), :), 2);
    toptips = findpeaks(sum(letter(1:floor(h*0.24), :), 2), 'MinPeakHeight', 8);
    sidetips = findpeaks(sum(letter(:, 1:floor(w/7.5)), 1), 'MinPeakHeight', 5.5);

    acrosscount = length(find(across >= 3));
    topAxcount = length(find(topAx >= 3));
    downcount = length(find(down >= 3));

    wthresh = 0.6;
    hthresh = 0.7;
    topthresh = 0.6;

    if (length(toptips) == 0 & length(sidetips) == 0)
        group = 'fist';
    elseif (downcount > w*wthresh & acrosscount < h*hthresh)
        group = 'sideways';
    elseif (topAxcount > floor(h/2)*topthresh & downcount < w*wthresh)
        group = 'extended';
    elseif (length(toptips) ~= 0)
        group = 'extended';
    elseif (length(sidetips) ~= 0)
        group = 'sideways';
    elseif (topAxcount < floor(h/2)*topthresh & downcount < w*wthresh)
        group = 'fist';
    end

    % Looking for C
    if (bmax(1) > rmax(1) & bmax(1) > floor(2*h/3))
        group = 'fist';
    end
    % Looking for Q
    if (bmax(2) < floor(w/2) & bmax(1) > floor(h/2) & rmax(1) > floor(h/2))
        group = 'sideways';
    end
    % Looking for Z
    if (gmax(2) > rmax(2) & bmax(1) < floor(h/3))
        group = 'extended';
    end
    % Looking for X
    if (rmax(1) > gmax(1) - 20 & bmax(1) < floor(h/4))
        group = 'fist';
    end
    % Looking for G2
    if (sum(letter(:,1)) > 70) 
       group = 'sideways'; 
    end

end