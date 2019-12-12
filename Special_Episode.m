function [Q, steps, record_states] = Special_Episode(Q, Valid_States)

    state = (1);    
    running = (1);
    steps = (0);
    
    record_states = [];
    
    while(running == 1)
        
%         action = Greedy_Function(Q, state, zero_explo);
        
        action = Special_Greedy(Q, state);
        
        next_state = Transition_Function(state, action, Valid_States);
        
        reward = Reward_Function(state, action);
        
        Q = Q_Update_Function(Q, state, action, reward, next_state);
        
        if(next_state == 100)
            running = 0;
        end
        
        steps = steps + 1;
        state = next_state;
        
        record_states = [record_states; state];        
    end
end