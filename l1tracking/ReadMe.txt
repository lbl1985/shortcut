This code implements and demonstrates the L1-regularized tracking published in the following paper

		X. Mei and H. Ling, Robust Visual Tracking using L1 Minimization, 
		IEEE International Conference on Computer Vision (ICCV), Kyoto, Japan, 2009. 


All the varialbes have been commented and self-explanatory. 

The main tracking function is in L1Tracking_release.m
	function [track_res] = L1Tracking_release( s_frames, sz_T, n_sample, init_pos, bLighting, s_debug_path )
Details of the function can be seen by using "help L1Tracking" in matlab, or from the code directly. 

For demonstration, run demo.m to learn more. The result will be stored in the path "result/"

The implementation uses the following SPAM software package:
   SPArse Modeling Software
http://www.di.ens.fr/willow/SPAMS/downloads.html
J. Mairal, F. Bach, J. Ponce and G. Sapiro. Online Learning for Matrix Factorization and Sparse Coding. Journal of Machine Learning Research, volume 11, pages 19-60. 2010.
J. Mairal, F. Bach, J. Ponce and G. Sapiro. Online Dictionary Learning for Sparse Coding. International Conference on Machine Learning, Montreal, Canada, 2009


This is the version 3 of the distribution. We appreciate any comments/suggestions. For more quetions, please contact us at nathanmei@gmail.com or hbling@temple.edu.
	
Xue Mei and Haibin Ling, July 2010

Last updated, Sep 30, 2010