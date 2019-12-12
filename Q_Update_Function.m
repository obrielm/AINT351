function Q = Q_Update_Function(Q, state, action, reward, next_state)
    
    alpha = 0.2;
    gamma = 0.9;    
    Qx = (Q(state, action) + ...
         (alpha*(reward + gamma*max(Q(next_state,:)))- ...
         (Q(state, action)))); %
    Q(state, action) = Qx;   
end