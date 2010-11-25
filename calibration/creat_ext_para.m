function ext_para = creat_ext_para(Rc_ext, Tc_ext)
ext_para = zeros(4);
ext_para(1 : 3, 1 : 3)  = Rc_ext;
ext_para(1 : 3, 4) = Tc_ext;
ext_para(4, 4) = 1;