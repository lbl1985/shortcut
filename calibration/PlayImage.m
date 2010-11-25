function [ImageIndex ndata_truth]= PlayImage(videofile, ndata, M, ext_para, num_points, turner, moviefile, fbeg, WF)
% PlayImage(videofile, xlsfile, M, ext_para, num_points, turner)
% If turner == 'save', we will save the output images into a '.avi' vedio
% named "mymovie.avi';
movie = mmread(videofile);
num_frame = size(movie.frames, 2);

if strcmp(turner, 'save')
    aviobj = avifile(moviefile, 'fps', 29);
end

% ndata = xlsread(xlsfile);
% ndata = ndata(5:end, :);
Rows = size(ndata, 1);
ndata = resample(ndata, num_frame + 15, Rows);
ndata_truth = zeros(num_frame, size(ndata, 2));
ImageIndex = zeros(num_points, 2);

%WF = WorkingFrame
%  WF = 1;

for j = fbeg : num_frame    
        I = movie.frames(j).cdata;  
        if WF == 0
            i = j;
        else
            i = WF;
        end
%     for i = WF : Rows
        ImageIndex = TestProg(M, ext_para, reshape(ndata(i, 3 : end), 3, num_points)');
        if WF ~= 0
            WF = WF + 1;
        end
        imshow(I); hold on
        plot(ImageIndex(:, 1), ImageIndex(:, 2), 'y*');
        s = sprintf('Frame %d, Row %d', j, i);
        title(s);
        pause(.05);
%         text(ImageIndex(:, 1), ImageIndex(:, 2), int2str((1 : num_points)'));
%         text(size(I, 1) / 2 -50, size(I, 2) /2  -50, 'Please Click'); 
%         X = getpts(gcf);
%         text(size(I, 1) /2 - 50, size(I, 2) / 2 - 50, 'Thank You ');
        
%         if (X > size(I, 1) /2)
%             ndata_truth(j, :) = ndata(i, :);
%             WF = i+1;
%             
            if strcmp(turner, 'save')
                frame = getframe(gcf);
                aviobj = addframe(aviobj, frame);
            end
%             
%             break;
%         else
%             continue;
%         end
        
%     end    
end

if strcmp(turner, 'save')
    aviobj = close(aviobj);
end
    
%     
% %     for i = j : num_points        
% %         tempIndex = TestProg(M, ext_para, ndata_sel(j, i * 3 : i * 3 + 2));
% %         tempIndex = tempIndex';
% %         ImageIndex(i, :) = round(tempIndex(1 : 2));      
% %         
% %     end
%     
%     imshow(I); hold on; 
%     
%     not_accepted=1;
%     while (not_accepted)
%     
%         for i = j : num_points        
%         tempIndex = TestProg(M, ext_para, ndata_sel(j, i * 3 : i * 3 + 2));
%         tempIndex = tempIndex';
%         ImageIndex(i, :) = round(tempIndex(1 : 2));      
%         
%         end
%         
%         for k = 1 : num_points       
%                     plot(ImageIndex(k, 1), ImageIndex(k, 2), 'y*');
%                     text(ImageIndex(k, 1), ImageIndex(k, 2),['point' num2str(k)]);
%         end
%         
%         hold off;
%         pause(1/20);
%         
%         [X Y] = getpts(gcf);
%         
%         if (X > size(I, 1) / 2)
%             ndata_truth(j, :) = ndata_sel(i, :);
%             if strcmp(turner, 'save');
%                 frame = getframe(gcf);
%                 aviobj = addframe(aviobj, frame);
%             end
%         end
%     
% %     imshow(I); hold on; 
% %     for i = 1 : num_points       
% %                 plot(ImageIndex(i, 1), ImageIndex(i, 2), 'y*');
% %                 text(ImageIndex(i, 1), ImageIndex(i, 2),['point' num2str(i)]);
% %     end
% %     s = sprintf('Frame %d', i);
% %     title(s);
%     
%     
% end       