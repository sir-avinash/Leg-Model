%init_symbols
% initializes the sybolic variables to be used in the dynamics

% Gravity acceleration
g = sym('g');
Qg.cons = {g};
Qa.cons = {g};

% Time independant symbolic variables
Qg.q = {'th1','l1'};
Qg.q_dot = {'dth1','dl1'};
Qg.q_ddot = {'ddth1','ddl1'};

%Qa.q = {'th1','l1','xcm','ycm'};
%Qa.q_dot = {'dth1','dl1','dxcm','dycm'};
%Qa.q_ddot = {'ddth1','ddl1','ddxcm','ddycm'};

Qa.q = {'th1','l1','ycm'};
Qa.q_dot = {'dth1','dl1','dycm'};
Qa.q_ddot = {'ddth1','ddl1','ddycm'};


% Time depedant symbolic variables
l1 = sym('l1(t)');
dl1 = sym('diff(l1(t),t)');
ddl1= sym('diff(l1(t),t,t)');
th1 = sym('th1(t)');
dth1 = sym('diff(th1(t),t)');
ddth1 = sym('diff(th1(t),t,t)');
xcm = sym('xcm(t)');
dxcm = sym('diff(xcm(t),t)');
ddxcm = sym('diff(xcm(t),t,t)');
ycm = sym('ycm(t)');
dycm = sym('diff(ycm(t),t)');
ddycm = sym('diff(ycm(t),t,t)');

Qg.qt = {th1,l1};
Qg.qt_dot = {dth1, dl1};
Qg.qt_ddot = {ddth1, ddl1};

% Qa.qt = {th1, l1, xcm, ycm};
% Qa.qt_dot = {dth1, dl1, dxcm, dycm};
% Qa.qt_ddot = {ddth1, ddl1, ddxcm, ddycm};

Qa.qt = {th1, l1, ycm};
Qa.qt_dot = {dth1, dl1, dycm};
Qa.qt_ddot = {ddth1, ddl1, ddycm};


