function ankle_angle = CalculateAnkleAngle(knee_marker, ankle_marker, toe_marker, heel_marker)
    % CalculateAnkleAngle uses markers to calculate ankle angle
    % Remember: only use the sagittal plane coordinates (y, z)
    arguments
        knee_marker (:,3) double
        ankle_marker (:,3) double
        toe_marker (:,3) double
        heel_marker (:,3) double
        
    end
    % Put your code here
%     d1=0;d2=0;
%     limit = height(knee_marker);
%     for a = 1:limit
%         d1 = [0,knee_marker(a,2),knee_marker(a,3)] - [0,ankle_marker(a,2),ankle_marker(a,3)];
%         d2 = [0,toe_marker(a,2),toe_marker(a,3)] - [0,heel_marker(a,2),heel_marker(a,3)];
% %     theta=0;
%         ankle_angle(a)=atan(d1,d2);
%     end
    
%     d1=line([],[]);
%     d2=line([],[]);
%     CosTheta = max(min(dot(d1,d2)/(norm(d1)*norm(d2)),1),-1);
%     ankle_angle = real(acosd(CosTheta));
% (x > 0 ? x : (2*PI + x)) * 360 / (2*PI)
%     if theta==90
%         ankle_angle==0
%     elseif theta<90
%         ankle_angle==
    ankle_angle = [];
    limit = height(knee_marker);
    for a = 1:limit
        d1 = [0,knee_marker(a,2),knee_marker(a,3)] - [0,ankle_marker(a,2),ankle_marker(a,3)];
        d2 = [0,toe_marker(a,2),toe_marker(a,3)] - [0,heel_marker(a,2),heel_marker(a,3)];
        ankle_angle(a) = -((atan2(norm(cross(d1,d2)), dot(d1,d2)))*(180/pi)-90);
        % - to assign positive to dorsiflexion
        % -90 to set straight shank and flat foot as 0 deg
    end
end