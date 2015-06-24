% SIM_DYN: simulation of high impact dynamic leg
% by Roberto Shu
%% --------------------- Initialize Workspace -----------------------
clear ; close all; clc;

%% Initialize robot
init_robot;

% Set Ground properties
params.ground.Kg = 10e4;     % [N/m]
params.ground.Bg = 75;       % [Ns/m]
params.ground.y_td = 0;

params.desired = [deg2rad(-10), deg2rad(-30), deg2rad(-10)];

% Set initial conditions
th1_0 = deg2rad(-10);
th2_0 = deg2rad(-30);
th3_0 = deg2rad(-10);
l1_0 = 0.3;
xf_0 = 0;
yf_0 = 9;

dth1_0 = 0;
dth2_0 = 0;
dth3_0 = 0;
dl1_0 = 0;
dxf_0 = 0;
dyf_0 = 0;

% assemble initial condition vector
X0 = [th1_0; th2_0; th3_0; l1_0; xf_0; yf_0;...
      dth1_0; dth2_0; dth3_0; dl1_0; dxf_0; dyf_0];

tout = 0;
Xout = X0.';
teout = [];
Xeout = [];
ieout = [];

%% Flight Phase
options = odeset('RelTol',1e-2,'AbsTol',1e-2,...
                     'Events',@(t,x)sim_flight_events(t,x,leg),'Stats','off');

tstart = 0;
tend = 5;
[t,X,te,xe,ie] = ode45(@(t,x)odefun_flight_dyn(t,x,leg, params),[tstart,tend],X0,options);

% Concatenate output
nt = length(t);
tout = [tout; t(2:nt)];
Xout = [Xout; X(2:nt,:)];
teout = [teout; te];   
Xeout = [Xeout; xe];
ieout = [ieout; ie];

%% --------- Flight --> Stance Transition --------------
% This defines the initial conditions for the simulation of the leg during contact with ground

% Change in state variable vector reduces in size to:
%   q = [th1, th2, th3, l1, dth1, dth2, dth3, dl1];

% Extract state just before impact w/ ground (qf-)
Q_fminus = X(end,:);
qf = X(end,1:6);
dqf = X(end,7:12);

[D,~,~,~] = Eval_Flight_DynFunc(Q_fminus);
A = D(1:4,1:4);

mt = leg.m1 + leg.m2 + leg.m3;
Ff = Ff_matrix(leg,qf);
dFfdq = Ff_jacobian(leg, qf);
dqs = inv(A + mt*dFfdq'*dFfdq)*[A, mt*dFfdq']*dqf';

X_stnc_plus = [qf(1:4),dqs'];

% Store landing coordinates
x_land = qf(5:6);

%% -------------- Stance Phase ----------------------
tstart = tout(end);

options = odeset('RelTol',1e-2,'AbsTol',1e-2,...
                     'Events', @(t,x)sim_stance_events(t,x,leg), 'Stats','off');

                 
[t,X] = ode45(@(t,x)odefun_stance_dyn(t,x,leg, params),[tstart,tend],X_stnc_plus,options);

% need to get CoM position given joint angles and foot location
xf = [0.2;0];
Ff = zeros(size(X,1),2);
for i = 1:size(X,1)
    Xcm(i,:) = Foot2COM_Pos(leg, X(i,:),xf);
end
% Concatenate output
nt = length(t);
xf = x_land(1)*ones(nt-1,1);
yf = x_land(2)*ones(nt-1,1);

x_temp = [X(2:nt,1:4),Xcm(2:end,:),X(2:nt,5:end),zeros(nt-1,2)];
tout = [tout; t(2:nt)];
Xout = [Xout; x_temp];
%teout = [teout; te];   
%Xeout = [Xeout; xe];
%ieout = [ieout; ie];

%% Stance --> Flight Transition

%% --------- Error Calculation ----------------
Err(:,1) = abs(params.desired(1) - X(:,1));
Err(:,2) = abs(params.desired(2) - X(:,2));
Err(:,3) = abs(params.desired(3) - X(:,3));


% Save results
X = Xout;
t = tout;
save('x14.mat','t','X','te','xe','ie','Err');