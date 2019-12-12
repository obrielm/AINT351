function [P1 P2] = RevoluteForwardKinematics2D(armLen, theta, origin)


% min_angle = (0);
% max_angle = (pi); 
% max_data = (1000);   
% Group_One = (max_angle - min_angle) * rand(2, test_data) + min_angle;


% unpack joint angles to make clear what we are dong here
theta1 = theta(1,:);
theta2 = theta(2,:);

% unpack segment length
l1 = armLen(1,:);
l2 = armLen(2,:);

% relative forward kinematics
x = l1 * cos(theta1) + ones(size(theta1)) * origin(1,:);
y = l1 * sin(theta1) + ones(size(theta1)) * origin(2,:);

% pack results
P1 = [x; y;];

% relative forward kinematics
x = l1 * cos(theta1) + l2 * cos(theta1 + theta2) + ones(size(theta2)) * origin(1,:);
y = l1 * sin(theta1) + l2 * sin(theta1 + theta2) + ones(size(theta2)) * origin(2,:);

% pack results
P2 = [x; y;];


