function dPf2comdq = Pf2com_jacobian(shin, X)

th1 = X(1);
l1 = X(2);
ycm = X(3);

m_tot = shin.m1 + shin.m2;

m1 = shin.m1;
m2 = shin.m2;

dPf2comdq = 1/m_tot*[-(0.5*m1+m2)*l1*sin(th1), (0.5*m1+m2)*cos(th1)];
end
