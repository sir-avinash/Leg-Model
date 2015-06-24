function Pf2com = COMrel2Foot(shin, X)

th1 = X(1);
l1 = X(2);
ycm = X(3);

m_tot = shin.m1 + shin.m2;

p1 = 0.5*l1*cos(th1);
  
p2 = l1*cos(th1);
 
Pf2com = 1/m_tot*[shin.m1*p1 + shin.m2*p2];

end
