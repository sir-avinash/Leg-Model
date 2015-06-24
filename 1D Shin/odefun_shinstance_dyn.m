function dx = odefun_shinstance_dyn(t, X, shin, params )
%% ODEFUN_FLIGHT_DYN_COM 

%% Read constant parameters
l1max = shin.l1max;
Ksp = shin.spring.Ksp;
Kd = shin.damper.Kd;
g = shin.g;

%% ------------- Forces --------------------
t
th1 = X(1);
l1 = X(2);
dth1 = X(3);
dl1 = X(4);

%%  Determine if in flight or stance phase
%% ------------ Input Forces ---------------
% Damper
Fd = -Kd*dl1;

% Spring
lspring = shin.l1max- l1;
if(l1  < shin.l1min)     % spring maxed expansion
    %fprintf('spring maxed out: %d, %d\n',l1,dl1)
    Fsp = shin.spring.Ksp2*(shin.spring.k0 - shin.l1min) - shin.spring.Kb*dl1;

elseif(l1 > shin.l1max) % spring maxed compression
    %fprintf('spring exceeds rest position: %d, %d\n',l1,dl1);
    Fsp = shin.spring.Ksp2*(shin.spring.k0 - shin.l1max) - shin.spring.Kb*dl1;
else
    Fsp = shin.spring.Ksp*(shin.spring.k0 - l1);
end

% Torque
tau1 = 0;

gamma = [tau1; Fsp+Fd];

%% ------------- Equation of Motion ---------
[D,h,G,B] = Eval_ShinStance_DynFunc(X);
ddx = inv(D)*(B*gamma-h-G);

% Assemble output
dx = [X(3:end);
      ddx];
 
end

