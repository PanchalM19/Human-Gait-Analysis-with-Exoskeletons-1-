function HS_idxs = GetHeelStrikes(vertical_force)
    % Uses a threshold on vertical force to calculate heel strike indices
    arguments
        vertical_force (:,1) double
    end

    % put your code here
    a=find(vertical_force>40 & vertical_force<60);
    for i=1:1:length(a)
        if vertical_force(a(i)) > vertical_force(a(i)-1)
            HS_idxs(i)=a(i);
        end
    end
    HS_idxs=nonzeros(HS_idxs);
end