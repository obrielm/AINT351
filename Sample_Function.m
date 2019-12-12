function [data_out] = Sample_Function(samples, min_angle, max_angle)

    test_data = samples;
    
    data_out = (max_angle - min_angle) * rand(2, test_data) + min_angle;

end