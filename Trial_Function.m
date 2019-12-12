function [trial_records, Q] = Trial_Function(Valid_States, explo_rate)
    
    Q = Q_Initialise_Function();
    trial_records = [];
    for outer = 1:100
        for i = 1:1000
            [Q, steps, record_states] = Episode_Function(Q, Valid_States,explo_rate);
            trial_records = [trial_records; steps];
        end
    end
end