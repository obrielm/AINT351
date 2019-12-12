function action = Special_Greedy(Q, state)

        values = Q(state,:);
        [II ,action] = max(values);   
        % Choose max value in an array. This max value is the next action.
end