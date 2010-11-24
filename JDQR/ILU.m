function v=ILU(v)

n=size(v,1); e=ones(n,1);

L=spdiags([-e,e],-1:0,n,n); U=L';

v=U\(L\v);

return
