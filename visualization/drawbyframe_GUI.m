function drawbyframe_GUI(y, cha, i)
% figure;

% y = Y_sep{id};
m = size(y, 1);
if max(cha) > m
    error(['we don''t have channel ' num2str(max(cha))]);
end

if length(cha) == 2
    plot(y(cha(1), 1 : i), y(cha(2), 1 : i), 'r-*');
end
if length(cha) == 3
    plot3(y(cha(1), 1 : i), y(cha(2), 1 : i), y(cha(3), 1 : i), 'r-*');
end
xlim([min(y(cha(1), :))-5 max(y(cha(1), :))+5]);
ylim([min(y(cha(2), :))-5 max(y(cha(2), :))+5]);
if length(cha) == 3
    zlim([min(y(cha(3), :))-5 max(y(cha(3), :))+5]);
end


title(['Frame ' num2str(i)]);


