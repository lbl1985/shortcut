k = ls;
for i = 3 : size(k, 1)
    s = sprintf('k(%d, :)', i);
    I = imread(eval(s));    
    imshow(I);
    pause(.1);
end