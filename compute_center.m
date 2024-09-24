
%% FUNCTION THAT GIVEN CLUSTERS COMPUTE CENTERS

function center = compute_center(cluster)
% Calcola il centro del cluster come media dei valori numerici e moda di
% valori categorici
    dim=size(cluster,2);
    center=zeros(dim,1);
    for i = 2:dim
        if (i >= 3 && i <= 6) || i==18
           center(i,1) = mode(table2array(cluster(:,i)));
        else 
            center(i,1)= mean(table2array(cluster(:,i)));
        end
        center(2,1)=round(center(2,1));
        center(7,1)=round(center(7,1));
    end
end




