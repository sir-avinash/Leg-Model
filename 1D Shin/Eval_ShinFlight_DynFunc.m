function [D,h,G,B] = Eval_ShinFlight_DynFunc(X)

th1 = X(1);
l1 = X(2);
ycm = X(3);
dth1 = X(4);
dl1 = X(5);
dycm = X(6);
g = 9.81;

D = [ (45*l1^2)/184 - (45*l1^2*cos(2*th1))/184 + 99/100, -(45*l1*sin(2*th1))/184,    0;...
                          -(45*l1*cos(th1)*sin(th1))/92,      (45*cos(th1)^2)/92,    0;...
                                                      0,                       0, 69/4];
 

h = [ (45*dth1*l1*(2*dl1 - 2*dl1*cos(2*th1) + dth1*l1*sin(2*th1)))/184;...
      - (45*dth1^2*l1*cos(th1)^2)/92 - (45*dl1*dth1*cos(th1)*sin(th1))/46;...
                                                         -(69*ycm)/4];
                          
G = [     0;...
          0;...
    (69*g)/4];    

B = [0, 0, 0;...
     0, 1, 0;...
     0, 0, 0];
end

