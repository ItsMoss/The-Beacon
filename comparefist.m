function[] = comparefist(letter,hand1,hand1axis,hand2,hand2axis)
%%
% This file is for comparison of images from different individuals
% letter is a string indicating which letter of alphabet image depicts
% hand1 represents the normalized sums from individual 1
% hand1axis is corresponding axis for individual 1
% hand2 represents the normalized sums from individual 2
% hand2axis is corresponding axis for individual 2
%%
% 1. PLOT BOTH NORMALIZED SUMS WITH EACH OTHER
plot(hand1axis, hand1, 'r')
hold on
plot(hand2axis, hand2, 'g')
title(letter)
legend('Moss','Keaton')
end
