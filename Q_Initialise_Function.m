function Q = Q_Initialise_Function()
    min_limit = 0.010;
    max_limit = 0.100;
    
    range = (max_limit - min_limit);
    mean = ((max_limit - min_limit)/2);
    
    Q = rand(100,4) .* range + mean;    
end
