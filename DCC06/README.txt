

Simple instructions on how to use.
By T-K. Kim 27 Aug 2006.


Please see 'Main.m' for understadning the input and output parameters.

Refer to the default values for all of the parameters in the annotations of 
the code.


Procedures:

1) Prepare for the training and testing data: All object images should be 
first registered with regard to their positions, scales, to get uniform 
sized images (For face, you can use 'V-J face detector' in Intel OpenCV). 

2) Preprocessing: Typically, histrogram-equalization is applied to the 
collected images for getting some illumination-invariance. Any advanced filtering
would be also favored with the subsequent processes. All propocessed images are 
converted into column vectors by raster-scanning.


*Training* (For simplicity of the codes, the training data is assumed to have
same number of image sets for each object class. The dimension of every subspace 
is also fixed in the codes.)

3) Learn subspaces for image sets, one subspace for each set: For example, 
use 'Eigen_Decompose.m'.   

4) Concatenate the eigenvector matrices of the training data horizontally to 
form 'Pm'. 

5) Run 'Learn_DCC.m'

*Testing*

6) Run 'Eigen_Decompose.m' for a given test set to get 'Pq'.

7) Run 'Recog.m'.