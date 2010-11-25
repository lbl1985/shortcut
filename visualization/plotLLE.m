function plotLLE(Y)
plot((1:size(Y,2))', Y(1,:)', 'red', 'LineWidth', 3);
hold on; plot((1:size(Y,2))', Y(2,:)', 'blue', 'LineWidth', 2);
hold on; plot((1:size(Y,2))', Y(3,:)', 'green', 'LineWidth', 1);
% plot((1:size(Y,2))', Y(1:end - 1,:)');
% legend('First', 'Second', 'Third');
hold off;