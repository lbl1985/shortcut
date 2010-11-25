function playftc_asVideo(ftc)
% This is a function to lets see the histogram changing around the time.
% With x-axis wrt feature types. (such as from word 1 to 50). And y-axis 
% wrt to count of that features. (such as feature 1 with 100 count, feature
% 50 with 30). 

[m n] = size(ftc);

ymax = max(ftc(:));
for i = 1 : n
    bar(ftc(:, i));
    xlim([1 m + 1]);   ylim ([0 ymax]);
    xlabel('Feature');  ylabel('Count');    title(['Frame: ', num2str(i)]);
    pause(1/26);
end