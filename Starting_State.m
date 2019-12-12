function state = Starting_State(Valid_States)

    % RETURN A NUMBER BETWEEN 1:100 BUT NOT END STATE.
    % RETURN A STATE THAT IS IN THE LIST OF OPEN_STATES.

    pos = randi(length(Valid_States));   % Ignore blocked states !!!
    value = Valid_States(pos);

    state = 100;                % Do not pick last state !!!
    while(state == 100)
        pos = randi(length(Valid_States));
        value = Valid_States(pos);
        state = value;
    end
end

