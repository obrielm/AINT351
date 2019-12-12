function [Q, steps, record_states] = Episode_Function(Q, Valid_States, explo_rate)

    state = Starting_State(Valid_States);
    
    running = (1);
    steps = (0);
    
    record_states = [];
    
    while(running == 1)
        
        action = Greedy_Function(Q, state, explo_rate);
        
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