function batch_SaveVideo(mode, Type)

switch mode
    case 'subfolder'
        % StartingPath = 'C:\Users\lbl1985\Documents\MATLAB\work\SELF_KTH\oridata';
        ResultPath = 'C:\Users\lbl1985\Documents\MATLAB\work\SELF_KTH\ForeGroundData';
        dircontent = dir(ResultPath);

        for i = 3: length(dircontent)
            % Type of actions
        %     SubPath = [StartingPath '\' dircontent(i).name];
            SubResultPath = [ResultPath '\' dircontent(i).name];
        %     mkdir (SubResultPath);

            % Person and clips id
            SubPath_dircontent = dir(SubResultPath);
            for j = 3: length(SubPath_dircontent)
                if SubPath_dircontent(j).isdir == 1

                    PersonIdClipNum = SubPath_dircontent(j).name;        
                    TargetResultPath = [SubResultPath '\' PersonIdClipNum];

                    disp(['Working at path: ' PersonIdClipNum]);
                    filename = [TargetResultPath '\' PersonIdClipNum '.mat'];

                    comm = ['load ' filename]; eval(comm);




            %         mkdir(TargetResultPath);

            %         ForeGround = SELF_KTH_BackgroundSubtraction(WorkPath);
                    filename = [TargetResultPath '\' PersonIdClipNum '.avi'];
                    comm = ['saveM_asVideo(''' filename ''', ForeGround, 1, 0, 22, ''gray'');']; eval(comm);
                end
            end
        end
    case 'folder'
        [srcdir filenames] = rfdatabase(datadir(Type - 1, 'kthForeGround'), 'person');
        for i = 13 : length(filenames)
            filename = filenames{i};
            disp(['Working at ' filename]);
            load([srcdir filename]);
            filename = [srcdir filename(1 : end - 4) '.avi'];
            saveM_asVideo(filename, ForeGround, 1, 0, 22, 'gray');
        end
end
            
            