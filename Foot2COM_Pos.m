function P_cm = Foot2COM_Pos(leg, X,P_f)
% FOOT2COM_POS given the leg foot location determines the legs CoM position
%
% Inputs:
% 	- leg
% 	- X
%	- P_f
%
% Outputs:
%	- Xcm
% by Roberto Shu
% ---------------------------------------------------------

th1 = X(1);
th2 = X(2);
th3 = X(3);
l1 = X(4);

m_tot = leg.m1 + leg.m2 + leg.m3;

p1 = [0.5*l1*sin(th1);...
      0.5*l1*cos(th1)];
  
p2 = [l1*sin(th1) + leg.d2*sin(th2);...
      l1*cos(th1) + leg.d2*cos(th2)];
  
p3 = [l1*sin(th1) + leg.l2*sin(th2) + leg.l3*sin(th3);...
      l1*cos(th1) + leg.l2*cos(th2) + leg.l3*cos(th3)];

P_cm = 1/m_tot*[leg.m1*p1 + leg.m2*p2 + leg.m3*p3] + P_f;
end