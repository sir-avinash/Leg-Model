function animation(leg, x)

% Read input
d2 = leg.d2;
l2 = leg.l2;
l3 = leg.l3;

th1 = x(:,1);
th2 = x(:,2);
th3 = x(:,3);
l1 = x(:,4);
xc = x(:,5);
yc = x(:,6);


%  CoM --> Foot map
Ff = zeros(size(x,1),2);
for i = 1:size(x,1)
    Ff(i,:) = Ff_matrix(leg,x(i,:))';
end

xf = xc - Ff(:,1);
yf = yc - Ff(:,2);

% m1 location
P{1} = [xf + 0.5*l1.*sin(th1),...
        yf + 0.5*l1.*cos(th1)];
    
% knee location
P{2} = [xf + l1.*sin(th1),...
        yf + l1.*cos(th1)];
    
% m2 location
P{3} = [xf + l1.*sin(th1) + d2*sin(th2),...
        yf + l1.*cos(th1) + d2*cos(th2)];
  
% hip location
P{4} = [xf + l1.*sin(th1) + l2*sin(th2),...
        yf + l1.*cos(th1) + l2*cos(th2)];
  
% m3 location
P{5} = [xf + l1.*sin(th1) + l2*sin(th2) + l3*sin(th3),...
        yf + l1.*cos(th1) + l2*cos(th2) + l3*cos(th3)];

% Determine range of data 
ymax = max(P{5}(2,:));
%% Plot 

figure
for i = 1:length(th1)

    plot([xf(i),P{1}(i,1)],[yf(i),P{1}(i,2)],'r','LineWidth',2); %foot --> shin mass m1
    hold on;
    
    plot([P{1}(i,1),P{2}(i,1)],[P{1}(i,2),P{2}(i,2)],'b','LineWidth',2); % shin mass m1 --> knee
    plot([P{2}(i,1),P{3}(i,1)],[P{2}(i,2),P{3}(i,2)],'g','LineWidth',2); % knee --> thigh mass m2
    plot([P{3}(i,1),P{4}(i,1)],[P{3}(i,2),P{4}(i,2)],'g','LineWidth',2); % thigh mass m2 --> hip
    plot([P{4}(i,1),P{5}(i,1)],[P{4}(i,2),P{5}(i,2)],'c','LineWidth',2); %hip --> torso mass m3
    
    % draw masses
    plot(P{1}(i,1),P{1}(i,2),'o','MarkerSize',15,'MarkerEdgeColor',[0.85,0.325,0.098],'MarkerFaceColor',[0.85,0.325,0.098]) % shin mass m1
    plot(P{3}(i,1),P{3}(i,2),'o','MarkerSize',15,'MarkerEdgeColor',[0.85,0.325,0.098],'MarkerFaceColor',[0.85,0.325,0.098]) % thig mass m2
    plot(P{5}(i,1),P{5}(i,2),'o','MarkerSize',15,'MarkerEdgeColor',[0.85,0.325,0.098],'MarkerFaceColor',[0.85,0.325,0.098]) % torso mass m3
    plot(xc(i),yc(i),'o','MarkerSize',15,'MarkerEdgeColor','r','MarkerFaceColor','r') % CoM

    % draw joints
    plot(P{2}(i,1),P{2}(i,2),'o','MarkerSize',10,'MarkerEdgeColor','b','MarkerFaceColor','b')  % knee joint
    plot(P{4}(i,1),P{4}(i,2),'o','MarkerSize',10,'MarkerEdgeColor','b','MarkerFaceColor','b')  % hip joint

    % Draw floor
    rectangle('Position',[-0.4 -0.1 0.8 0.1], 'FaceColor','k')
    %axis([-0.4,0.4,-0.1,ymax]); 
    axis equal
    ax = gca;
    %ax.DataAspectRatio = [1,1,1];
    grid on;
    hold off;
    pause(0.1);
end

end