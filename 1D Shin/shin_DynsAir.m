function [EOM, D, h, G, B] = shin_DynsAir(shin,Q, gamma)
% Derive the the dynamics of the robot's shin constrained to vertical motion using the Lagragian when the robot is in the air 

th1 = Q.qt{1};
l1 = Q.qt{2};
ycm = Q.qt{3};
g = Q.cons{1};

% Center of Mass CoM
m_tot = shin.m1 + shin.m2;

p1 = 0.5*l1*cos(th1);
  
p2 = l1*cos(th1);


Ff = 1/m_tot*(shin.m1*p1 + shin.m2*p2);

Pcm = ycm;

% Position and Velocity of links CoM
p1 =  Pcm - Ff + 0.5*l1*cos(th1);
 
p2 =  Pcm - Ff + l1*cos(th1);
  
v1 = diff(p1,'t');
v2 = diff(p2,'t');

% Potenial Energy
V = shin.m1*g*p1 + shin.m2*g*p2;
%V = m_tot*g*ycm;

% Kinetic Energy
v1v1 = simplify(expand(v1.'*v1));
v2v2 = simplify(expand(v2.'*v2));

T = 0.5*shin.m1*v1v1 + 0.5*shin.I1*diff(th1)^2 + ...
    0.5*shin.m2*v2v2 + 0.5*shin.I2*diff(th1)^2 + ...
    0.5*m_tot*ycm^2;

T = simplify(expand(T));

% Calculate dynamics
[EOM, D, h, G, B] = EOM_derivation(T,V,Q,gamma);

end