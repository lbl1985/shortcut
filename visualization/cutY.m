function Y_sep = cutY(Y, nf, group, display, mode)
% Example: 
% group = [1 1 1 1 2 2 2 2 3 3 3 3];
% Y_sep = cutY(Y, nf, group);



if nargin < 4
    display = 0;
elseif nargin < 5
    mode = 'initial';
end

m = length(nf);
Y_sep = cell(m, 1);
nf = [0; nf];
% chas short for Channels 
chas = [1 2; 1 3; 2 3];

for i = 1 : m
    Y_sep{i} = Y(:, nf(i) + 1 : nf(i + 1));
end

if display
    % 2D channels plot
%     for k = 1 : 3
%         cha = chas(k, :);
%         figure;
%         for i = 1 : m
%             if i ~= m
%                 switch num2str(group(i))
%                     case '1'
%                         hold on; plot(Y_sep{i}(cha(1), :), Y_sep{i}(cha(2), :), 'b.');
%                     case '2'
%                         hold on; plot(Y_sep{i}(cha(1), :), Y_sep{i}(cha(2), :), 'go');
%                     case '3'
%                         hold on; plot(Y_sep{i}(cha(1), :), Y_sep{i}(cha(2), :), 'rx');
%                 end
%             else
%                 % Depend on the mode to decide how to deal with the last
%                 % element
%                 switch mode
%                     case 'initial'
%                         switch num2str(group(i))
%                             case '1'
%                                 hold on; plot(Y_sep{i}(cha(1), :), Y_sep{i}(cha(2), :), 'b.');
%                             case '2'
%                                 hold on; plot(Y_sep{i}(cha(1), :), Y_sep{i}(cha(2), :), 'go');
%                             case '3'
%                                 hold on; plot(Y_sep{i}(cha(1), :), Y_sep{i}(cha(2), :), 'rx');
%                         end
%                     case 'increamental'
%                         hold on; plot(Y_sep{i}(cha(1), :), Y_sep{i}(cha(2), :), 'kd');
%                 end
%             end         
%         end
%         title(['group' num2str(group) ' Channel' num2str(cha)]);
%         hold off
%     end
    % 3D plot
%     figure;
    for i = 1 : m
        if i ~= m
            switch num2str(group(i))
                case '1'
                    if i ~= 1
                        hold on;
                    end
        %             'b-.'
                    plot3(Y_sep{i}(1, :), Y_sep{i}(2, :), Y_sep{i}(3, :),'b.');     
        %             legend('1st Type');
                case '2'
                    if i ~= 1
                        hold on;
                    end
        %             'g:o'
                    hold on; plot3(Y_sep{i}(1, :), Y_sep{i}(2, :), Y_sep{i}(3, :), 'go');
        %             legend('2nd Type');            
                case '3'
                    if i ~= 1
                        hold on;
                    end
        %             'r--x'
                    hold on; plot3(Y_sep{i}(1, :), Y_sep{i}(2, :), Y_sep{i}(3, :), 'rx');
        %             legend('3rdType');
            end
        else
            switch mode
                case 'initial'
                    switch num2str(group(i))
                        case '1'
                            if i ~= 1
                                hold on;
                            end
                %             'b-.'
%                             plot3(Y_sep{i}(1, :), Y_sep{i}(2, :), Y_sep{i}(3, :),'b.');    
                            plot3(Y_sep{i}(1, :), Y_sep{i}(2, :), Y_sep{i}(3, :),'b.'); 
                %             legend('1st Type');
                        case '2'
                            if i ~= 1
                                hold on;
                            end
                %             'g:o'
%                             hold on; plot3(Y_sep{i}(1, :), Y_sep{i}(2, :), Y_sep{i}(3, :), 'go');
                            hold on; plot3(Y_sep{i}(1, :), Y_sep{i}(2, :), Y_sep{i}(3, :), 'go');
                %             legend('2nd Type');            
                        case '3'
                            if i ~= 1
                                hold on;
                            end
                %             'r--x'
%                             hold on; plot3(Y_sep{i}(1, :), Y_sep{i}(2, :), Y_sep{i}(3, :), 'rx');
                            hold on; plot3(Y_sep{i}(1, :), Y_sep{i}(2, :), Y_sep{i}(3, :), 'rx');
                %             legend('3rdType');
                    end
                case 'increamental'
                    if i ~= 1
                        hold on;
                    end
                %             'r--x'
                        hold on; plot3(Y_sep{i}(1, :), Y_sep{i}(2, :), Y_sep{i}(3, :), 'kd');
            end
        end
    end
    % legend('1st Type', '2nd Type', '3rd Type');
    hold off
    title(['group' num2str(group) ' ---- 3D plot']);
end