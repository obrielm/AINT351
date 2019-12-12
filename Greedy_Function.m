function action = Greedy_Function(Q, state, explo_rate)

    random = rand();    
    if(random > explo_rate) % = 90%
        values = Q(state,:);
        [II ,action] = max(values);   % Choose max value in an array. This max value is the next action.               
    else
        action = randi(4);          
    end
end



















% function action = Greedy_Function(Q, state, explo_rate)
%     explo_rate = (0);
%     random = rand();    
%     if(random > explo_rate) % = 90%
%         random_state = Q(state,:);
%         [II ,action] = max(random_state);   % Choose max value in an array. This max value is the next action.               
%     else
%         action = randi(4);          
%     end
% end

