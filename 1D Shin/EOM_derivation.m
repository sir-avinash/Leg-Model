function [EOM, D, h, G, B] = EOM_derivation(T,V,Q,gamma)
% Finds the Equation of Motions of high-impact leg using Lagragian method
% 
% By: Roberto Shu
%-------------------------------------------------------------------------

% Symbols definitions
syms g;
 q = Q.q;
 q_dot = Q.q_dot;
 q_ddot = Q.q_ddot;
 qt = Q.qt;
 qt_dot = Q.qt_dot;
 qt_ddot = Q.qt_ddot;

T = subs(T,[qt, qt_dot],[q,q_dot]);
V = subs(V,[qt, qt_dot],[q,q_dot]);

for i = 1:length(q)
    
    dV_q{i} = diff(V,q{i});
    dV_q{i} = expdNsimp(dV_q{i});
    
    dT_q{i} = diff(T,q{i});
    dT_q{i} = expdNsimp(dT_q{i});
    
    % Differetiate with respect to q_dot
    dT_dq{i} = diff(T,q_dot{i});
    dT_dq{i} = expdNsimp(dT_dq{i});
    
    % substiute variabels interms of t
    dV_q{i}= subs(dV_q{i},[q,q_dot],[qt,qt_dot]);
    dT_q{i} = subs(dT_q{i},[q,q_dot],[qt,qt_dot]);
    dT_dq{i} = subs(dT_dq{i},[q,q_dot],[qt, qt_dot]); 
    
    % Differetiate with respect to t
    ddT_dq{i} = diff(dT_dq{i},'t');
    ddT_dq{i} = expdNsimp(ddT_dq{i});
    
    % Equation of Motion
    EOM{i} = ddT_dq{i} - dT_q{i} + dV_q{i};
    EOM{i} = expdNsimp(EOM{i});
end

% find D matrix
D = sym(zeros(length(EOM),length(q)));
for j = 1:length(EOM)
    for i = 1:length(qt_ddot)
        c = coeffs(EOM{j},qt_ddot{i});   
        
        if length(c) == 1
            D(j,i) = 0;
        else 
            e = 0;
            for k = 2:length(c)
                D(j,i) = D(j,i) + c(k)*qt_ddot{i}^e;
                e = e + 1;
            end
        end
    end
end

% find G matrix
G = sym(zeros(length(EOM),1));
for j = 1:length(EOM)
    c = coeffs(EOM{j},g);
    if length(c) > 1
        G(j) = c(2)*g;
    else
        G(j) = 0;
    end
end

% find h matrix
h = sym(zeros(length(EOM),1));
for j = 1:length(EOM)
    
    temp_h = EOM{j};
    for i = 1:length(qt_ddot)
        temp_h = temp_h - D(j,i)*qt_ddot{i};
    end
    temp_h = temp_h - G(j);
    h(j) = simplify(expand(temp_h));
end

% find B output matrix
gamma = subs(gamma,qt,q);
for j= 1:length(qt)
    if isempty(gamma)
        B = zeros(length(qt));
    else
        for i = 1:length(gamma);
            B(j,i) = diff(gamma(i),q{j});
        end
    end
end

end

function A = expdNsimp(A)
    A = simplify(expand(A));
end


