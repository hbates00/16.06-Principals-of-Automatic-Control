close all
global omega

omega = .1;                % rad/s
V_0 = .86;                 % m/s

theta_1i = 116;

% initial position [m m]
rVec_1i = [10 0];

% target final positions [m m]
rVec_1t = [20 0];           
rVec_2t = [10 0];
rVec_3t = [10 0];

%initial velocity [m/s m/s]
vVec_1i = V_0*[cosd(180-theta_1i) sind(theta_1i)];

stateVec_0 = zeros(4,1);
%rRange_fEps = [-.2 .2];    % [m m]
%thetaRange = [deg2rad(90), deg2rad(180)];
tSpan = [0 8.5];

% State vector time derivative
stateVecD = @(t,x) [x(2); xDD(x); x(4); yDD(x)];

%% Run the outward simulation
stateVec_0(StateMap.x) =  rVec_1i(1);
stateVec_0(StateMap.xD) = vVec_1i(1);
stateVec_0(StateMap.y) =  rVec_1i(2);
stateVec_0(StateMap.yD) = vVec_1i(2);

[tOut_1, stateOut_1] = ode45(stateVecD, tSpan, stateVec_0);

% final position and velocity
rVec_1f = [stateOut_1(end, StateMap.x)  stateOut_1(end, StateMap.y) ];
vVec_1f = [stateOut_1(end, StateMap.xD) stateOut_1(end, StateMap.yD)];

V_1f = norm(vVec_1f);
theta_1f = atan2d(vVec_1f(2), vVec_1f(1));
T_1f = tOut_1(end);
eps_1 = norm(rVec_1f - rVec_1t);

%% Run the reverse case
% initial position [m m]
rVec_2i = rVec_1f;

%initial velocity [m/s m/s]
vVec_2i = -vVec_1f;

stateVec_0(StateMap.x) =  rVec_2i(1);
stateVec_0(StateMap.xD) = vVec_2i(1);
stateVec_0(StateMap.y) =  rVec_2i(2);
stateVec_0(StateMap.yD) = vVec_2i(2);

[tOut_2, stateOut_2] = ode45(stateVecD, tSpan, stateVec_0);

% final position and velocity
rVec_2f = [stateOut_2(end, StateMap.x)  stateOut_2(end, StateMap.y) ];
vVec_2f = [stateOut_2(end, StateMap.xD) stateOut_2(end, StateMap.yD)];

V_2f = norm(vVec_2f);
theta_2i = atan2d(vVec_2i(2), vVec_2i(1));
theta_2f = atan2d(vVec_2f(2), vVec_2f(1));
T_2f = T_1f + tOut_2(end);
eps_2 = norm(rVec_2f - rVec_2t);

%% Run the image case
% initial position [m m]
rVec_3i = rVec_1f;

%initial velocity [m/s m/s]
vVec_3i = [-vVec_1f(1) vVec_1f(2)];

stateVec_0(StateMap.x) =  rVec_3i(1);
stateVec_0(StateMap.xD) = vVec_3i(1);
stateVec_0(StateMap.y) =  rVec_3i(2);
stateVec_0(StateMap.yD) = vVec_3i(2);

[tOut_3, stateOut_3] = ode45(stateVecD, tSpan, stateVec_0);

% final position and velocity
rVec_3f = [stateOut_3(end, StateMap.x)  stateOut_3(end, StateMap.y) ];
vVec_3f = [stateOut_3(end, StateMap.xD) stateOut_3(end, StateMap.yD)];

V_3f = norm(vVec_3f);
theta_3i = atan2d(vVec_3i(2), vVec_3i(1));
theta_3f = atan2d(vVec_3f(2), vVec_3f(1));
T_3f = T_1f + tOut_3(end);
eps_3 = norm(rVec_3f - rVec_3t);

%% Graph it!
figTitle = 'y(t) vs x(t)';
saveName = 'y_vs_x';

fig = figure(1);
fig.PaperUnits = 'inches';
fig.PaperPosition = [.25 .25 10.5 8];
fig.PaperOrientation = 'landscape';
fig.Units = 'Pixels';
fig.InnerPosition = print_accurate(fig);
fig.Name = figTitle;
fig.NumberTitle = 'off';

hold on

plot(stateOut_1(:, StateMap.x), stateOut_1(:, StateMap.y), '-');
plot(stateOut_2(:, StateMap.x), stateOut_2(:, StateMap.y), '-.');
plot(stateOut_3(:, StateMap.x), stateOut_3(:, StateMap.y), '--');

scatter([rVec_1i(1) rVec_1f(1)], [rVec_1i(2) rVec_1f(2)], 64)

legend('Outward', 'Reversed', 'Imaged', 'Astronaut')

hold off

xlabel('x(t) [m]');
ylabel('y(t) [m]');
title(figTitle);
axis equal
%ylim([-4 12])
xlim([-3 25])
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
ax.Box = 'on';
ax.XGrid = 'on';
ax.YGrid = 'on';
%ax.Units = 'Normalized';
ax.Position = [0.0 0.075 1.0 0.850];    % Only need room for title

ax.XTick = -4:2:26;
ax.YTick = -100:2:100;

saveas(fig, saveName);
fig.PaperOrientation = 'portrait';
print(fig, saveName, '-dpng', '-r300');
fig.PaperOrientation = 'landscape';

%% Tabulate it!

% Several lessons were learned the hard way here...
theta_i = round([theta_1i; theta_2i; theta_3i], 0);
theta_f = round([theta_1f; theta_2f; theta_3f], 0);
V_f = round([V_1f; V_2f; V_3f], 3, 'significant');
T_f = round([T_1f; T_2f; T_3f], 1);
rVec_f = round([rVec_1f; rVec_2f; rVec_3f], 2, 'significant');
eps = round([eps_1; eps_2; eps_3], 2, 'significant');

% in retrospect: I'll change the way I record these on paper next time, because
% this is just absurd... each row should be a case.
final_results = table(theta_i, theta_f, V_f, T_f, rVec_f, eps);
final_results = table2array(final_results);
final_results = transpose(final_results);
final_results = array2table(final_results);
final_results.Properties.RowNames = ...
    {'theta_i'; 'theta_f'; 'V_f'; 'T_f'; 'rVec_fx'; 'rVec_fy'; 'eps'};
final_results.Properties.VariableNames = ...
    {'Case_1'; 'Case_2'; 'Case_3'};
final_results
