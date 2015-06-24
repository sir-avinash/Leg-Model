function [D,h,G,B] = Eval_ShinStance_DynFunc(X)

th1 = X(1);
l1 = X(2);
dth1 = X(3);
dl1 = X(4);
g = 9.81;

D = [ (249*l1^2)/32 - (249*l1^2*cos(2*th1))/32 + 99/100, -(249*l1*sin(2*th1))/32;...
	                     -(249*l1*cos(th1)*sin(th1))/16,     (249*cos(th1)^2)/16];
 

h = [     (249*dth1*l1*(2*dl1 - 2*dl1*cos(2*th1) + dth1*l1*sin(2*th1)))/32;...
 - (249*dth1^2*l1*cos(th1)^2)/16 - (249*dl1*dth1*cos(th1)*sin(th1))/8];
                          
G = [ -(129*g*l1*sin(th1))/8;...
     (129*g*cos(th1))/8];    

B = [0, 0;...
     0, 1];
end

