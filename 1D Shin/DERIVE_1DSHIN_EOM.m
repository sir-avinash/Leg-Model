%% DERIVE_1DSHIN_EOM derive equation of motion (EOM) of the shin constrained to only vertical motion
% due to boom with the center of mass CoM as reference point.
%
% File name: DERIVE_1DSHIN_EOM
% Date created: 6/16/2015
% Date last modified: 6/16/2015
% Author: Roberto Shu
% -------------------------------------------------------


%% --------------------- Initialize Workspace -----------------------
clear ; close all; clc;

% Initialize robot
init_shin;

%% Initiliaze symbols
init_shin_symbols;

%% --------------------- Derive Flight Phase EOM ---------------------------------

% Define driven variables
gamma = {};

[EOMa, Da, ha, Ga, Ba] = shin_DynsAir(shin,Qa,gamma);

% Substitue time variable symbol representation
Da = subs(Da,[Qa.qt, Qa.qt_dot],[Qa.q,Qa.q_dot]);
ha = subs(ha,[Qa.qt, Qa.qt_dot],[Qa.q,Qa.q_dot]);
Ga = subs(Ga,[Qa.qt, Qa.qt_dot],[Qa.q,Qa.q_dot]);
Ba = subs(Ba,[Qa.qt, Qa.qt_dot],[Qa.q,Qa.q_dot]);

%% --------------------- Derive Stance Phase EOM ---------------------------------

[EOMg, Dg, hg, Gg, Bg] = shin_DynsStance(shin,Qg,gamma);

% Substitue time variable symbol representation
Dg = subs(Dg,[Qg.qt, Qg.qt_dot],[Qg.q,Qg.q_dot]);
hg = subs(hg,[Qg.qt, Qg.qt_dot],[Qg.q,Qg.q_dot]);
Gg = subs(Gg,[Qg.qt, Qg.qt_dot],[Qg.q,Qg.q_dot]);
Bg = subs(Bg,[Qg.qt, Qg.qt_dot],[Qg.q,Qg.q_dot]);

