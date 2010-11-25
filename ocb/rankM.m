function rankM(nsets, psiz)
% Calculate the M matrix and deltaR value according to Iran's paper IEEE
% journal 2007. Save the value in the same folder as the data as name 
% rankM_clipname;
%
% Example
% rankM(2, [7 7 3]);
%
% TIMESTAME:    1:30PM      10/OCT/2009
    psiz2 = floor(psiz/2);
    for k = 0 : nsets - 1
        [srcdir filenames n] = rfdatabase(datadir(k), 'clip');
        ticstatusid = ticstatus('rankM', [], 40);
        for i = 1 : n
            filename = filenames{i};
            load([srcdir 'cuboids_' filename(6:end)]); clear cuboids;
            load([srcdir 'grad_' filename(6:end)]);
            M = cell(size(subs, 1), 1);     R = zeros(size(subs, 1), 1);
            for j = 1 : size(subs, 1)
%                 disp(['j = ' num2str(j)]);
                patchx = calPatch(Px, subs(j, :), psiz2);
                patchy = calPatch(Py, subs(j, :), psiz2);
                patcht = calPatch(Pt, subs(j, :), psiz2);
                G = [patchx(:) patchy(:) patcht(:)];
                tempM = G' * G;
                M{j} = tempM;   R(j) = det(tempM) / (det(tempM(1:2, 1:2)) * norm(tempM, 'fro') + eps);
            end
            destname = [srcdir 'rankM_' clipname];
            save(destname, 'M', 'R');    
            tocstatus( ticstatusid, i/n );
        end
    end
end

function patch = calPatch(P, subs, psiz2)
    if (subs(1) + psiz2(1) > size(P, 1))  subs(1) = size(P, 1) - psiz2(1); end
    if (subs(1) - psiz2(1) < 1)           subs(1) = 1 + psiz2(1); end
    if (subs(2) + psiz2(2) > size(P, 2))  subs(2) = size(P, 2) - psiz2(2); end
    if (subs(2) - psiz2(2) < 1)           subs(2) = 1 + psiz2(2); end
    if (subs(2) + psiz2(3) > size(P, 3))  subs(3) = size(P, 3) - psiz2(3); end
    if (subs(2) - psiz2(3) < 1)           subs(3) = 1 + psiz2(3); end
    patch = P(subs(1) - psiz2(1) : subs(1) + psiz2(1), ...
        subs(2) - psiz2(2) : subs(2) + psiz2(2), ...
        subs(3) + psiz2(3) : subs(3) + psiz2(3));
end