close all
clear all
clc

%--------------------------------------------------------------------------
%--------------------------------TASK_1------------------------------------
Origin = [0; 0];                %   Arm Starting Point
Theta = [0; pi];                %   End Effector Range
Alpha = (0.0001);
Arm_Length = [0.4; 0.4];

samples = (1000);   
[angle_data] = Sample_Function(samples, Theta(1,:), Theta(2,:));
[P1, P2] = RevoluteForwardKinematics2D(Arm_Length, angle_data, Origin);

figure
plot(angle_data(1,:), angle_data(2,:), '.r')    % Uniform distribution data
ylabel('Y-axis')
xlabel('X-axis') 
title({'10555152 : Maximum Environment'})
hold off
axis equal

figure
hold on
plot(P2(1,:), P2(2,:), '.r') 
plot(Origin(1,:), Origin(2,:), 'hk', 'MarkerSize', 6, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'g') 
ylabel('Y-axis')
xlabel('X-axis') 
legend({'End Points', 'Origin [0 , 0]'}, 'location', 'SouthEast','FontSize', 8);
title({'10555152 : End Effector Work Space'})
hold off
axis equal

figure
hold on
for ten = 1:10  
    x_vector = [Origin(1,:) P1(1,(ten)) P2(1,(ten))];
    y_vector = [Origin(2,:) P1(2,(ten)) P2(2,(ten))];
    
    plot(x_vector, y_vector, '-k', 'LineWidth', 2);
    ylabel('Y-axis')
    xlabel('X-axis') 
    
    plot(Origin(1,1), Origin(2,1), 'h', 'MarkerSize', 8, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'w');
    plot(P1(1,(ten)), P1(2,(ten)), 'o', 'MarkerSize', 7, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'g');
    plot(P2(1,(ten)), P2(2,(ten)), 'o', 'MarkerSize', 7, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'r');  
    legend({'Arm Link', 'Arm Origin', 'Arm Joint', 'End Effector'}, 'location', 'NorthEast','FontSize', 8);
    legend('boxoff')
end
title({'10555152 : Arm Configuration'})
hold off

%--------------------------------------------------------------------------
%--------------------------------TASK_2------------------------------------
hidden_units = (10);
W1 = rand(hidden_units, 3);
W2 = rand(2, hidden_units+1);

sum_error_array = [];

cycles = 10000;
for i = 1:cycles
    %--------------------------------------------------------------------------
    %------------------------Feed Forward Pass---------------------------------
    Xin = (P2);
    Xin_Aug = [Xin; ones(size(Xin(1,:)))];
    
    net_two = (W1*Xin_Aug);
    A2 = ((1)./(1+exp(-net_two)));
    A2_Aug = [A2; ones(size(A2(1,:)))];
    
    o = (W2*A2_Aug);
    %--------------------------------------------------------------------------
    %------------------------Applying The Delta Rule---------------------------
    Delta_D3 = (-(angle_data - o));
    Delta_D2 = (W2' * Delta_D3) .* A2_Aug .* (1-A2_Aug);
    Delta_D2 = Delta_D2(1:(end-1), :);
    
    Error_Grad_W1 = (Delta_D2*transpose(Xin_Aug));
    Error_Grad_W2 = (Delta_D3*transpose(A2_Aug));
    
    %--------------------------------------------------------------------------
    %------------------------Weights Update------------------------------------
    
    W1 = W1 - (Alpha*Error_Grad_W1);
    W2 = W2 - (Alpha*Error_Grad_W2);
    
    f_error = (Theta - o);
    
    origin_elbow_error = ((f_error(1,:) * f_error(1,:)')/samples);
    elbow_end_error = ((f_error(2,:) * f_error(2,:)')/samples);
    
    sum_error = (origin_elbow_error + elbow_end_error);
    sum_error_array = [sum_error_array, sum_error];
end

[~, P3] = RevoluteForwardKinematics2D(Arm_Length, o, Origin);

figure
plot(sum_error_array, '-m')
ylabel('Y-axis')
xlabel('Iterations')
title({'10555152: Joint Angles Error'})

figure
subplot(2,2,1);
plot(P2(1,:), P2(2,:), '.b')
ylabel('Y-axis')
xlabel('X-axis')
axis equal
title({'10555152: Original End Effector Angles'})

subplot(2,2,2);
plot(angle_data(1,:), angle_data(2,:), '.b')
ylabel('Y-axis')
xlabel('X-axis')
axis equal
title({'10555152: Original Joint Angles'})

subplot(2,2,3);
plot(P3(1,:), P3(2,:), '.r')
ylabel('Y-axis')
xlabel('X-axis')
axis equal
title({'10555152: Trained End Effector Angles'})

subplot(2,2,4);
plot(o(1,:), o(2,:), '.r')
ylabel('Y-axis')
xlabel('X-axis')
axis equal
title({'10555152: Trained Joint Angles'})
    mse = [mse, sum(Delta_D3.^2)/1000];
 
%--------------------------------------------------------------------------
%--------------------------------TASK_3------------------------------------
limits = [0 10; 0 10;];
maze = CMazeMaze10x10(limits);
%--------------------------------------------------------------------------
minVal = (0.010);
maxVal = (0.100);
%--------------------------------------------------------------------------
Open_State = maze.stateOpen();
maze_num = maze.stateNumber();
%--------------------------------------------------------------------------
[row_x,col_y] = find(Open_State);
a = size(row_x, 1);

Valid_States = [];
for i = 1:a    
    coordinates = maze_num((row_x(i)), (col_y(i)));
    Valid_States = [Valid_States; coordinates];
end
%--------------------------------------------------------------------------
explo_rate = (0.1);

test to generate histogtam
for tidx = 1:10000
    stateArray(tidx) = Starting_State(Valid_States);
end

figure
H1 = histogram(stateArray, 100);
H1.FaceColor = [0 0.5 0.5];
title('10555152: Histogram Plots')

%------------------------CUSTOM_FUNCTIONS----------------------------------
Q = Q_Initialise_Function();
state = Starting_State(Valid_States);
action = Greedy_Function(Q, state, explo_rate);
reward = Reward_Function(state, action);
next_state = Transition_Function(state, action, Valid_States);
Q = Q_Update_Function(Q, state, action, reward, next_state);
[Q, steps, record_states] = Episode_Function(Q, Valid_States, explo_rate);
%--------------------------------------------------------------------------
[trial_records, Q] = Trial_Function(Valid_States, explo_rate);
[~, ~, path] = Special_Episode(Q, Valid_States);
%--------------------------------------------------------------------------
Steps_2_Goal = length(path);
path = [1; path];

Rx = [];
Cy = [];
Rx_Cy = [];
for i = 1:length(path)
    [rows, cols, ~] = find(maze_num == path(i), 1, 'first');
    Rx = [Rx; rows];
    Cy = [Cy; cols];
    Rx_Cy = [Rx_Cy; rows, cols];
end

figure
XT = 1:length(trial_records);
YT = transpose(trial_records);                     
err = ones(size(YT));
errorbar(XT, YT,err)
title({'10555152: Q-Learning Trials'})
ylabel('Num of Steps')
xlabel('Num of Episodes')

maze.DrawMaze();
Xe = 0.75;
Ye = 0.75;

for b = 1:length(path)
    maze.DrawCircle([(Rx(b)-Xe) (Cy(b)-Ye) 0.5 0.5], 'm');
end
%--------------------------------------------------------------------------
%--------------------------------TASK_4------------------------------------

Rx_Cy = transpose(Rx_Cy);   % coordinates from the maze [19x2]
Xin_N = (Rx_Cy);            % use them as input to trained NN
Xin_Aug_N = [Xin_N; ones(size(Xin_N(1,:)))];

net_two_N = (W1*Xin_Aug_N);
A2_N = ((1)./(1+exp(-net_two_N)));
A2_Aug_N = [A2_N; ones(size(A2_N(1,:)))];

o_N = (W2*A2_Aug_N);

[P5, P4] = RevoluteForwardKinematics2D(Arm_Length, o_N, Origin);

figure
plot(P4(2,:), P4(1,:), 'or')
ylabel('Y-axis')
xlabel('X-axis')
title({'10555152 : NN End Effector Location'})

% figure
% hold on
% for path_i = 1:19
%     x_vector = [Origin(1,:) P1(1,(path_i)) P2(1,(path_i))];
%     y_vector = [Origin(2,:) P1(2,(path_i)) P2(2,(path_i))];
%     
%     plot(x_vector, y_vector, '-k', 'LineWidth', 2);
%     ylabel('Y-axis')
%     xlabel('X-axis') 
%     
%     plot(Origin(1,1), Origin(2,1), 'h', 'MarkerSize', 8, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'w');
%     plot(P5(1,(path_i)), P5(2,(path_i)), 'o', 'MarkerSize', 7, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'g');
%     plot(P4(1,(path_i)), P4(2,(path_i)), 'o', 'MarkerSize', 7, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'r');  
%     legend({'Arm Link', 'Arm Origin', 'Arm Joint', 'End Effector'}, 'location', 'NorthEast','FontSize', 8);
%     legend('boxoff')
% end
% title({'10555152 : Path Configuration'})
% hold off

%--------------------------------------------------------------------------
%--------------------------------END------------------------------------
