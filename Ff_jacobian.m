function dFfdq = Ff_jacobian(leg, X)

th1 = X(1);
th2 = X(2);
th3 = X(3);
l1 = X(4);

m_tot = leg.m1 + leg.m2 + leg.m3;

m1 = leg.m1;
m2 = leg.m2;
m3 = leg.m3;
d2 = leg.d2;
l2 = leg.l2;
l3 = leg.l3;


dFfdq = 1/m_tot*[(0.5*m1+m2+m3)*l1*cos(th1), (m2*d2+m3*l2)*cos(th2), m3*l3*cos(th3), (0.5*m1 + m2 + m3)*sin(th1);...
				 -(0.5*m1+m2+m3)*l1*sin(th1), -(m2*d2+m3*l2)*sin(th2), -m3*l3*sin(th3), (0.5*m1 + m2 + m3)*cos(th1)];
end
