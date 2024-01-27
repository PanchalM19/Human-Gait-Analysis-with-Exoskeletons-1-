function velocity = CalculateJointVelocity(angle, fs, do_filter)
    % Takes the time derivative of the angle input
    
    % TIP: You can specify a default value for an argument so that is
    % doesn't need to be passed. In this instance, I have set the do_filter
    % default value to false.
    arguments
        angle (:,1) double          
        fs double                   % sampling frequency
        do_filter logical = false   % default = false
    end

    % Put your code here
    velocity=diff(angle).*fs;
    
    if do_filter==true     
%         new_fs = fs/2
        [b,a] = butter(4,10/(fs/2),'low'); %4th order, 10 Hz, zero-lag low-pass
        filtered_velocity = filtfilt(b,a, velocity);
        velocity = filtered_velocity;
    else
        filtered_velocity = [];
    end
        
end