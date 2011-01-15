
   #!/bin/sh
   # if you can not use the mex files, uncomment this line.
   export LD_LIBRARY_PATH=./libs_ext/mkl64/
   export DYLD_LIBRARY_PATH=./libs_ext/mkl64/
   export KMP_DUPLICATE_LIB_OK=true
   matlab $* -r "addpath('/home/binlong/Documents/MATLAB/shortcut/SPAMS/release/mkl64'); addpath('/home/binlong/Documents/MATLAB/shortcut/SPAMS/test_release'); "
