function TO_idxs = GetToeOffs(vertical_force)
    % Uses a threshold on vertical force to calculate toe off indices
    arguments
        vertical_force (:,1) double
    end
    
    % put your code here
    a=find(vertical_force>40 & vertical_force<60);
    for i=1:1:length(a)
        if vertical_force(a(i)) < vertical_force(a(i)-1)
            TO_idxs(i)=a(i);
        else
            TO_idxs(TO_idxs==0)=[];
        end
    end
end