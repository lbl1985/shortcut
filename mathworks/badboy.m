function cols = badboy(orig, sim, mod)
switch num2str(mod)
    case '1'
        
        x = [];
        l = [];
        if (length(orig.signals) == length(sim.signals))
            for i = 1 : length(orig.signals)
                if (isequal(length(orig.signals(i).values), length(sim.signals(i).values)))
                    if ~isequal(orig.signals(i).values, sim.signals(i).values)
                        fprintf('BadBoy #: %d \n', i);
                        fprintf('orig_sim_result.signals(%d).values:\n', i)
                        orig.signals(i).values;
                        fprintf('sim_result.signals(%d).values:\n', i)
                        sim.signals(i).values;
                        fprintf('Differences between orig & snapshot:\n')
                        orig.signals(i).values - sim.signals(i).values
                        x = [x i];
                    end
                    
                else
                    fprintf('Length of orig_sim_result(%d) and sim_result(%d) are different \n\n', i, i)
                    fprintf('Length of orig_sim_result(%d) is: \n', i)
                    length(orig.signals(i).values)
                    fprintf('Length of sim_result(%d) is: \n', i)
                    length(sim.signals(i).values)
                    l = [l i];
                end
            end
            
            if (~isempty(x))
                fprintf('Differences # is: \n');
                x
            elseif(isempty(x) && isempty(l))
                fprintf('Simulation with/without Snapshot are the same \n')
            end
            
        else
            display('Number of Signals are different \n');
        end
        
    case '2'
        n = size(orig, 2);
        cols = zeros(1, n);
        for i = 1 : n
            cols(i) = isequal(orig(:, i), sim(:, i));
        end
end