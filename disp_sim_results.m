%% DISP_SIM_RESULTS displays animation & plots of simulation results 
%
% by Roberto Shu
% ------------------------------------------------------------------

%% -------------- Initialize Workspace -----------------------------
init_robot;

%% -------------- Load Results -------------- 
X = [deg2rad(-10), deg2rad(-30),deg2rad(-10),0.2,0.5,0.5];
X = [-0.1745,-0.5236,-0.1745,0.3000,0,0.6159,0,0,0,0,0,-4.8513];

load('x14.mat');

%% ------------- Animate -------------- 
animation(leg,X);

%% ------------ Plots -----------------

