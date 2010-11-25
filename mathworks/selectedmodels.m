
%----------------------------------
function test=lvlTwo_params_single(test, testparams)

    testInfo.mainModel.name = 'mparams_single';     %Use it.
    testInfo.mainModel.relativePath = './models';

    test = evil_test_harness( test, testInfo);
end

%----------------------------------
function test=lvlTwo_complex2(test, testparams)

    testInfo.mainModel.name = 'mcomplex2';  %Use it. Better than mcomplex1, less than mcomplex3 but after here there is Library chart test point for this model
    testInfo.mainModel.relativePath = './models';

    test = evil_test_harness( test, testInfo);
end

%----------------------------------
function test = lvlTwo_params_single_lib(test, testparams)
% Library version of the model in lvlTwo_params_single.

    testInfo.mainModel.name             = 'mparams_singlelib';      % Use it. 
    testInfo.mainModel.relativePath     = 'models';
    testInfo.mainModel.destRelativePath = '.';

    testInfo.additionalFiles(1).name             = 'msimplelib';
    testInfo.additionalFiles(1).relativePath     = 'models';
    testInfo.additionalFiles(1).destRelativePath = '.';
 
    testInfo.additionalFiles(2).name             = 'bparams_singlelib.mat';
    testInfo.additionalFiles(2).relativePath     = 'models';
    testInfo.additionalFiles(2).destRelativePath = '.';
  
    test = evil_test_harness(test, testInfo);
end

function test = lvlTwo_complexlib2(test, testparams)
% Library version of complex2.mdl

    testInfo.mainModel.name             = 'mcomplexmdl2';   % Use it.
    testInfo.mainModel.relativePath     = 'models';
    testInfo.mainModel.destRelativePath = '.';

    testInfo.additionalFiles(1).name             = 'mcomplexlibrary1';
    testInfo.additionalFiles(1).relativePath     = 'models';
    testInfo.additionalFiles(1).destRelativePath = '.';
 
    testInfo.additionalFiles(2).name             = 'bcomplexmdl2.mat';
    testInfo.additionalFiles(2).relativePath     = 'models';
    testInfo.additionalFiles(2).destRelativePath = '.';
  
    test = evil_test_harness(test, testInfo);
end