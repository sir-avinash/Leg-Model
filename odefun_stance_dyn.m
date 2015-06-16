function dx = odefun_stance_dyn (t, X, leg, params)
%% ODEFUN_STANCE_DYN

%% Read constant parameters
l1max = leg.l1max;
Ksp = leg.spring.Ksp;
Kd = leg.damper.Kd;
g = leg.g;

%% ------------- Extract State --------------------
t
l1 = X(4);
dl1 = X(8);

%% ------------ Input Forces ---------------
% Damper
Fd = Kd*dl1;
% Spring
lspring = leg.l1max- l1;
if(l1  < leg.l1min)     % spring maxed expansion
    %fprintf('spring maxed out: %d, %d\n',l1,dl1)
    Fsp = leg.spring.Ksp2*(leg.spring.k0 - leg.l1min) - leg.spring.Kb*dl1;

elseif(l1 > leg.l1max) % spring maxed compression
    %fprintf('spring exceeds rest position: %d, %d\n',l1,dl1);
    Fsp = leg.spring.Ksp2*(leg.spring.k0 - leg.l1max) - leg.spring.Kb*dl1;
else
    Fsp = leg.spring.Ksp*(leg.spring.k0 - l1);
end

gamma = [Fsp+Fd; 0; 0];

%% ------------- Equation of Motion ---------
[D,h,G,B] = Eval_Stance_DynFunc(X);
ddx = inv(D)*(B*gamma-h-G);

%% ------------- Assemble output -----------
dx = [X(5:end);
      ddx];

end