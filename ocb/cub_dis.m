function cub_dis(nsets)
% This function is mainly for figure out whether we can also find the
% cuboids in 1st frame can also be detected in the next frame. 
% This means, I just display all of the cuboids, which have been detected,
% in the same frame. And save them into a video file. This will make our
% life easier. 

for s = 0 : nsets - 1
    srcdir = datadir(s);
    feval_frame(srcdir, 'clip');
end

end

function feval_frame(srcdir, prefix)
   
%     if (~isempty(srcdir))
%         if(~exist(srcdir, 'dir')) error( ['feval_frame: dir ' srcdir ' not found' ]); end
%         if(srcdir(end)~='\' && srcdir(end) ~= '/') srcdir(end + 1) = '/'; end;
%     end
%     
%     %%% get appropriate filenames
%     if( isempty(prefix) ) 
%         dircontent = dir( [srcdir '*.mat'] ); 
%     else
%         dircontent = dir( [srcdir prefix '_*.mat'] ); 
%     end
%     filenames = {dircontent.name}; n = length(dircontent);        
%     if( n==0 ) error( ['No appropriate mat files found in ' srcdir] ); end;

    [srcdir filenames n] = rfdatabase(srcdir, prefix);
    
    ticstatusid = ticstatus('feval_frame', [], 40);
%     ncontents = length(matcontents);
    
    for i = 1 : n
        % load mat file and get contents
        filename = filenames{i};
        load([srcdir filename]);
        load([srcdir 'cuboids' filename(5:end)]);        
            I = overlayImage(subs, I);            
        close all
        saveM_asVideo([srcdir 'cubdis_' clipname], I, 1, 0, 3, 'gray');  
        tocstatus( ticstatusid, i/n );
    end
    
end

