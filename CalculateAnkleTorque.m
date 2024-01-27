function ankle_torque = CalculateAnkleTorque(Fy, Fz, L, H)
    %   CalculateAnkleAngle Uses markers to calculate ankle angle
    arguments
        Fy (:,1) double
        Fz (:,1) double
        L double
        H double
    end
%     if Fz<50
%         Fz==50
%     end
    % Put your code here
%     Fy=D.R_F(:,2);
%     Fz=D.R_F(:,3);
%     L=(D.R_Ankle_Med(:,2))-(D.R_Toe_Tip(:,2))
%     H=(D.R_Ankle_Med(:,3))-(D.R_Toe_Tip(:,3))
%     ankle_torque=(Fy.*H) + (Fz.*L); %this would be external
    ankle_torque=(Fz.*L)-(Fy.*H); %for internal
end