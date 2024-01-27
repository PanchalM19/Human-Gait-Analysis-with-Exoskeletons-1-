function [segmented_data] = SegmentDataByPhase(heel_strike_indices, data_to_segment)
    %Segments data by heel strikes. 
    arguments
        heel_strike_indices double
        data_to_segment (:,:) double
    end
  
    gait_phase = 0:1:100;

    % put your code here

%     segmented_data=size(101,size(heel_strike_indices,1));
%     new_vector=size(gait_phase);

%     if data_to_segment=350 points
%     new_vector = linspace(size(gait_phase,1),size(gait_phase,1),data_to_segment)


    for i=2:length(heel_strike_indices)
        new_data = data_to_segment(heel_strike_indices(i-1):heel_strike_indices(i));
%         new_data = new_data'
        new_vector = linspace(size(gait_phase,1),size(gait_phase,2),length(new_data));
        segmented_data(:,i+1) = interp1(new_vector, new_data, gait_phase);
    end
end