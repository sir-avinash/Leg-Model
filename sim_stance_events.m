function [value,isterminal,direction] = sim_stance_events(t,x,leg)
% Locate the time when the spring reaches maximum compression; stop
% integration. Also locate the time when the object has return to its
% rest position; stop integration.
%
% The length of the shin is given by
%
%   L(t) = x(4);
%
% When the sprign is compressed to its maximum the length of the leg
% reaches its mininum therefore 

    minCheck = leg.l1min - x(4);

% The leg is at its maximum length when the spring is at its minimum 
% compression of the spring happens when

    maxCheck = leg.l1max - x(4);

% Event to check lift-off 

value = [minCheck;maxCheck];
isterminal = [0;1];
direction = [1;-1];
end
