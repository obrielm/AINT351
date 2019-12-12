function reward = Reward_Function(state, action)

% All other states are not selected & give 0 as a result. 
    
    if(((state == 99) && (action == 1)) || (state == 90) && (action == 3) || (state == 100))
        reward = 10;        
    else
        reward = 0;
    end
end