function conv_clips2gradient(nsets, prefix)
% This function is mainly for calculate the gradient, Px Py Pt,  for the 
% video with padarray[5 5 15]. Then store them into the file named 
% ['grad_' clipname] in the same folder as clips and cuboids. 
% 
% TIMESTAMP:    11:00PM     05/OCT/2009
for k = 0 : nsets - 1
    [srcdir filenames n] = rfdatabase(datadir(k), prefix);
    ticstatusid = ticstatus('conv_clips2gradient', [], 40);
    for i = 1 : n
        filename = filenames{i};
        load([srcdir filename]);
        tempI = padarray(I, [5 5 15], 'both', 'replicate');
        [Px Py Pt] = gradient(double(tempI));
        destname = [srcdir 'grad_' clipname];
        save(destname, 'Px', 'Py', 'Pt');
        clear Px Py Pt I tempI
        tocstatus( ticstatusid, i/n );
    end
end