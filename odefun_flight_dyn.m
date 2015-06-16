function dx = odefun_flight_dyn_com(t, X, leg, params )
%% ODEFUN_FLIGHT_DYN_COM 

%% Read constant parameters
l1max = leg.l1max;
Ksp = leg.spring.Ksp;
Kd = leg.damper.Kd;
g = leg.g;

%% ------------- Forces --------------------
t
l1 = X(4);
xf = X(5);
yf = X(6);
dl1 = X(10);
dxf = X(11);
dyf = X(12);

%%  Determine if in flight or stance phase
if yf <= 0 % Stance phase

	% Need to figure out how to find the x-position of touchdown
	Fx = params.ground.Kg*(0 - xf) - params.ground.Bg*dxf;
	Fy = params.ground.Kg*(params.ground.y_td - yf) - params.ground.Bg*dyf;

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
else % Flight phase
	Fx = 0;
	Fy = 0;
    Fsp = 0;
    Fd = 0;
end

tauk = 0;
gamma = [Fsp+Fd; Fx; Fy];

%% ------------- Input Forces -------------


%% ------------- Equation of Motion ---------
%[D,h,G,B] = dyn_fun(X);
[D,h,G,B] = Eval_Flight_DynFunc(X);
ddx = inv(D)*(B*gamma-h-G);

%% Assemble output
dx = [X(7:end);
      ddx];
 
end

