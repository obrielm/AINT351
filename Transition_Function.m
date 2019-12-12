function next_state = Transition_Function(state, action, Valid_States)
%     [res, rul, status] = find(maze_num == state, 1, 'first');
%     [TRUE, VALIDITY] = ismember(4, Valid_States);

% DO NOT TAKE AN ACTION TOWARDS A BLOCKED STATE
%     EAST - action 1 = (i+1);
%     WEST - action 2 = (i-1);
%     NORTH - action 3 = (i+n);
%     SOUTH - action 4 = (i-n);
    
    EAST_STATES = Valid_States;
    WEST_STATES = Valid_States;
    
    Blocked_West = [ 10 70 80 90 ];
    Blocked_East = [ 11 71 81 91 ];
    Blocked_East = transpose(Blocked_East);
    
    for z0 = 1:length(Blocked_East)
        Ex = Blocked_East(z0);
        Wx = Blocked_West(z0);
        [east_row, rul_e, status_e] = find(EAST_STATES == Ex, 1, 'first');
        EAST_STATES(east_row,:) = [];  
        
        [west_row, rul_w, status_w] = find(WEST_STATES == Wx, 1, 'first');
        WEST_STATES(west_row,:) = [];
    end
      
    n = (10);
    i = (state);           % current state

    if(action == 1)        % EAST
        EAST = (i+1);
        [TRUE, IGNORE] = ismember(EAST, EAST_STATES);
        if(TRUE == 1)
            next_state = EAST;
        else
            next_state = state;
        end
        
    else if(action == 2)  % WEST
            WEST = (i-1);
            [TRUE, IGNORE] = ismember(WEST, WEST_STATES);
            if((TRUE == 1))
                next_state = WEST;
            else
                next_state = state;
            end
            
        else if(action == 3) % NORTH
                NORTH = (i+n);
                [TRUE, IGNORE] = ismember(NORTH, Valid_States);
                if(TRUE == 1)
                    next_state = NORTH;
                else
                    next_state = state;
                end
                
            else if(action == 4) % SOUTH
                    SOUTH = (i-n);
                    [TRUE, IGNORE] = ismember(SOUTH, Valid_States);
                    if(TRUE == 1)
                        next_state = SOUTH;
                    else
                        next_state = state;
                    end
                else
                    next_state = state;
                end
            end
        end
    end
end