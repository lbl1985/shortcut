function go(str)

if isunix
    workingpath = '/media/A642E42A42E3FD45/Users/Binlong/Documents/MATLAB';
end

switch str
    case ''
        cd (matlabroot);
    case 'temp'
        cd C:\Users\lbl1985\Documents\MATLAB\work\temp;
    case 'Blue'
        cd C:\Users\lbl1985\Documents\MATLAB\work\cali\BlueCCal;
    case 'BR'
        cd C:\Users\lbl1985\Documents\MATLAB\work\BR;
    case 'RIB'
        cd C:\Users\lbl1985\Documents\MATLAB\work\RIB;
    case 'SCO'
        cd C:\Users\lbl1985\Documents\MATLAB\work\singleCameraOutput;
    case 'self'
        cd ([workingpath 'SELF_KTH']);
    case 'Pro3'
        cd C:\Users\lbl1985\Documents\MATLAB\work\CV\Project3;
    case 'backup'
        cd ('//mathworks/devel/sandbox/bli/backup/');
    case 'calib'
        cd ('C:\Users\lbl1985\Documents\MATLAB\work\cali');
    case 'cuboids'
        cd ('C:\Users\lbl1985\Documents\MATLAB\work\BR\cuboids');
    case 'cuboids_trial'
        cd ('C:\Users\lbl1985\Documents\MATLAB\work\BR\cuboids_trial');
    case 'database'
        cd C:\Users\lbl1985\Downloads\tarFiles;
    case 'datam'
        cd C:\Users\lbl1985\Documents\MATLAB\work\datamining;
    case 'desktop'
        cd C:\Users\lbl1985\Desktop;
    case 'downloads'
        cd ('C:\Users\lbl1985\Downloads');
    case 'final'
        cd ('C:\Users\lbl1985\Documents\MATLAB\work\CV\final');
    case 'gui'
        cd ('C:\Users\lbl1985\Documents\MATLAB\work\GUI');
    case 'ind'
        cd ('C:\Users\lbl1985\Documents\MATLAB\work\CV\IndPro');
    case 'irani'
        cd ('C:\Users\lbl1985\Documents\MATLAB\work\Irani');
    case 'kth'
        cd ('C:\Users\lbl1985\Documents\MATLAB\work\BR\cuboids_trial\KTH');
    case 'learn'
        cd //gracie/bli/Learning;
    case 'multi'
        cd C:\Users\lbl1985\Documents\MATLAB\work\multiCalib;
    case 'msp'
        cd ([workingpath 'msp']);
    case 'ocb'
        cd C:\Users\lbl1985\Documents\MATLAB\work\Irani\ocb;
    case 'rep'
        cd C:\Users\lbl1985\Documents\MATLAB\work\BR\cuboids_trial\rep;
    case 'shortcut'
        cd (fullfile(workingpath, 'shortcut')); 
    case 'sim'
        cd ('C:\Users\lbl1985\Documents\MATLAB\work\BR\cuboids_trial\similarity');
    case 'ski'
        cd (fullfile(workingpath, 'work', 'self_kth_idea'));
    case 'stf'
        cd C:\Users\lbl1985\Documents\MATLAB\work\BR\cuboids\stfeatures;
    case 'tadmor'
        cd (fullfile(workingpath, 'Tadmor'));
    case 'tv'
        cd (fullfile(workingpath, 'work', 'interaction', 'tvinteration'));
    case 'work'
        cd(fullfile(workingpath, 'work'));
    case '..'
        cd ..
    otherwise
        str = sprintf('/%s', str);
        cd ([matlabroot str])
end

end