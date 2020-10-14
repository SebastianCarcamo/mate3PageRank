M = [0 1 1 1 1 1 1  ; 1 0 0 1 1 1 1 ; 0 0 0 0 1 1 0 ; 0 1 1 0 0 0 0 ; 1 1 0 1 0 1 1; 0 1 1 0 1 0 1; 1 1 1 0 1 1 0]
disp(M)
[V,D]= spec(M)
evals = diag(D)
vp1 = evals(1)
alpha=1/vp1


r=V(:,1)

r=r/sum(r)
x0=[1;1;1;1;1;1;1]

disp(x0)
disp(M)

for k = 1:20
    x0 = M*x0
    x0 = x0/sum(x0)
end

disp(x0)





//disp(alpha)
//S = alpha.'
//disp(S)
/*identidad = eye(7,7)
h=identidad*vp1
disp(h)
M2 = M - h
disp(M2)


vector0s=zeros(7,1)
disp(vector0s)
final=M2\vector0s
disp(final)*/
