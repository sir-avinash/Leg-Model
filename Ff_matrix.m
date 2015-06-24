function Ff = Ff_matrix(leg, X)

th1 = X(1);
th2 = X(2);
th3 = X(3);
l1 = X(4);

m_tot = leg.m1 + leg.m2 + leg.m3;

p1 = 0.5*l1*cos(th1);
  
p2 = l1*cos(th1);
 
Ff = 1/m_tot*[leg.m1*p1 + leg.m2*p2 + leg.m3*p3];

end
