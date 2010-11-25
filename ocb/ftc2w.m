function w = ftc2w(ftcSdesc, Type, clip)

ftc = ftcSdesc{Type}{clip};
k = size(ftc, 1);
[B IX] = sort(ftc, 'descend');

w1 = IX(1, :);
w2 = IX(2, :);
w3 = IX(3, :);

% close all
figure; title(['Type' num2str(Type) 'Clip' num2str(clip)]);
subplot(1, 3, 1); plot(1: size(w1, 2), w1); title('w1');    ylim([1 k]);
subplot(1, 3, 2); plot(1: size(w2, 2), w2); title('w2');    ylim([1 k]);
subplot(1, 3, 3); plot(1: size(w3, 2), w3); title('w3');    ylim([1 k]);

w = IX(1 : 3, :);