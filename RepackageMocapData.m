function D = RepackageMocapData(data, fs_force, fs_markers)
% Repackages the data into a data struct with the following steps:
% 1) Creates struct with fields for each labeled marker trajectory;
% 2) Removes error column (x, y, z, error) -> (x, y, z)
% 3) Filters data
% 4) Downsamples and adds IMUs

    D = [];
    labels = data.Trajectories.Labeled.Labels;
    D.Time   = (0:1/fs_markers:(data.Frames-1)/fs_markers)';


    cutoff_freq = 20;
    [b,a] = butter(4, cutoff_freq/(fs_markers/2)); % 10 Hz filter coeffs

    for label = labels
        idx = find(contains(data.Trajectories.Labeled.Labels,label));
        % Note: Squeeze used to remove singleton dimension formerly holding
        % marker #
        new_label = strrep(label{1},'.','_');
        D.(new_label) = transpose(squeeze(data.Trajectories.Labeled.Data(idx,1:3,:)));
%         D.(label{1}) = transpose(squeeze(data.Trajectories.Labeled.Data(idx,1:3,:)));
    end

    fns = fieldnames(D);
    for idx = 1:numel(fns)        
        D.(fns{idx})(isnan(D.(fns{idx})))=0; %remove missing vals
        D.(fns{idx}) = filtfilt(b,a, D.(fns{idx})); %filter kinematic data
    end 

    R_fp_idx = 1; % Right Force Plate idx
    L_fp_idx = 2; % Left Force Plate idx

    % Calculate COP offset from ForcePlateLocation in [x, y]  
    R_COP_offset = [mean([data.Force(R_fp_idx).ForcePlateLocation(2,1), data.Force(R_fp_idx).ForcePlateLocation(1,1)]), ...
            mean([data.Force(R_fp_idx).ForcePlateLocation(2,2), data.Force(R_fp_idx).ForcePlateLocation(3,2)])];

    L_COP_offset = [mean([data.Force(L_fp_idx).ForcePlateLocation(2,1), data.Force(L_fp_idx).ForcePlateLocation(1,1)]), ...
            mean([data.Force(L_fp_idx).ForcePlateLocation(2,2), data.Force(L_fp_idx).ForcePlateLocation(3,2)])];

    % 50 Hz butterworth filter
    cutoff_freq = 20;
    [b,a] = butter(4, cutoff_freq/(fs_force/2));

    R_COP = ResampleByFreq(filtfilt(b,a, data.Force(R_fp_idx).COP([1,2],:)'), fs_force, fs_markers);
    L_COP = ResampleByFreq(filtfilt(b,a, data.Force(L_fp_idx).COP([1,2],:)'), fs_force, fs_markers);
    R_COP(:,1) = -1.*R_COP(:,1); %Pos X R_COP comes in facing left
    L_COP(:,1) = -1.*L_COP(:,1); %Pos X R_COP comes in facing left
    D.R_COP = R_COP + R_COP_offset;
    D.L_COP = L_COP + L_COP_offset;
    

    % Force TM puts on Person: +y = backwards (need to flip), +z = up, +x =
    % right
    % filter and downsample force vector
    D.R_F = ResampleByFreq(filtfilt(b,a,data.Force(R_fp_idx).Force(:,:)'), fs_force, fs_markers);
    D.R_F(:,2) = -1.*D.R_F(:,2);    
    D.L_F = ResampleByFreq(filtfilt(b,a,data.Force(L_fp_idx).Force(:,:)'), fs_force, fs_markers);
    D.L_F(:,2) = -1.*D.L_F(:,2);

    % ADD IMU DATA
    if isfield(data, 'Analog')
        try
%             R_swizzle = [0, 0, -1; 1, 0, 0; 0, -1, 0];
%             L_swizzle = [0, 0, 1; -1, 0, 0; 0, -1, 0];
            R_swizzle = eye(3);
            L_swizzle = eye(3);
            fs_delsys = data.Analog(2).Frequency;
            cutoff_freq = 50;
            [b,a] = butter(4, cutoff_freq/(fs_delsys/2));
            filtered_data = filtfilt(b, a, data.Analog(2).Data');
            D.R_Accel   = ResampleByFreq(filtered_data(:,2:4), fs_delsys, fs_markers);
            D.R_Gyro    = ResampleByFreq(filtered_data(:,5:7), fs_delsys, fs_markers);
            D.R_Accel    = (R_swizzle*D.R_Accel')';
            D.R_Gyro    = (R_swizzle*D.R_Gyro')';            
            D.L_Accel   = ResampleByFreq(filtered_data(:,9:11), fs_delsys, fs_markers);
            D.L_Gyro    = ResampleByFreq(filtered_data(:,12:14), fs_delsys, fs_markers);
            D.L_Accel    = (L_swizzle*D.L_Accel')';
            D.L_Gyro    = (L_swizzle*D.L_Gyro')';
        catch
            disp('Error with IMU')
        end
    end

    % REMOVE UNNECSSARY MARKERS
    fields2remove = ["R_Thigh_Upper", "R_Thigh_Rear", "R_Shank_Upper", ...
        "R_Shank_Rear", "R_Midfoot_Sup", "R_Midfoot_Lat",...
        "L_Thigh_Upper", "L_Thigh_Rear", "L_Shank_Upper", ...
        "L_Shank_Rear", "L_Midfoot_Sup", "L_Midfoot_Lat", "Sternum", ...
        "R_Acromium", "L_Acromium"];
    for i = 1:length(fields2remove)
        if isfield(D,fields2remove(i))
            D = rmfield(D,fields2remove(i));
        end
    end

    D = struct2table(D);


end

% Internal function for resampling by frequency
function resampled_data = ResampleByFreq(data, fs_data, fs_desired)
    time_original_data = linspace(0,1/fs_data*(length(data)-1), length(data));
    time_new_data = 0:1/fs_desired:time_original_data(end);
    resampled_data = interp1(time_original_data, data, time_new_data);
    if size(resampled_data) ~= size(data)
        resampled_data = resampled_data';
    end
end