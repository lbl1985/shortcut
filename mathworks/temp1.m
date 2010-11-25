%     persistent  k;
   
    s = sprintf('Calib%d.tif', tempk);
    imwrite(I, s);
    tempk = tempk + 1;