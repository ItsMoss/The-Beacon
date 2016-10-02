function[hand_filt, Sum] = handfilter(image)
% Function runs a high pass filter through input image to detect edges and
% then sums up the edges to help distinguish size of image being detected
% PARAMETER
% image str: image file of hand
% OUTPUTS
% hand_filt: matrix representing filtered image
% Sum: the sum of the edges in the image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% INITIALIZING %%%
% 1. Import each of the Fist category letters 
hand = importdata(image);

% 2. Extract one of the three matrices from each image
hand = hand(:,:,1);

% 3. Transpose and flip each image to match orginal image
%hand = fliplr(hand.');

% PLOTTING AND METHODS %%%
% 1. Plot hand original image n a 1x2 subplot

subplot(1,2,1)
imshow(hand)
title(image(1))

% 2. Take the 2D fft of image
hand_fft=fft2(hand);

% 3. Take magnitude of 2D fftshift of image
factor1 = 1;
factor2 = 1;

hand_Shift=fftshift(hand_fft/factor1);

% 4. Creation of high pass filter
filter=image_filter('HPF',length(hand(:,1)),length(hand(1,:)));

% 5. Take magnitude of result of filter multiplied by 2D fftshift
filtered_hand_Shift2=filter.*hand_Shift;

% 6. Shift above result using fftshift and take inverse fft

shiftfilt_hand_Shift2=fftshift(filtered_hand_Shift2);
inv_SF_hand_Shift2=ifft2(shiftfilt_hand_Shift2);

% 7. Take magnitude of above result

subplot(1,2,2)
hand_filt = abs(inv_SF_hand_Shift2*factor2);

% 8. Clean up noise in image using a tested threshold

thr = 1.0;
hand_filt(hand_filt >= thr) = 1;
hand_filt(hand_filt < thr) = 0;

% 9. Plot the filtered image in second spot of 1x2 subplot

imshow(hand_filt)
title('Filtered Image')

% 10. Sum up filtered image

% In x direction
filt_sum = sum(hand_filt,1);

% Total sum
filt_sum = mean(filt_sum);
Sum = filt_sum; % rename

end