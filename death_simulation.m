%% FUNCTION THAT GIVEN AGE AND GENDER SIMULATES DEATHS IN FOLLOWING YEAR

function T = death_simulation(age, gender, mort_rate)
% creo T che alla fine mi genera vivo 1 o morto 0 in base alle prob
    T=ones(size(age,1),1);
    for i = 1:size(T,1)
        if gender(i,1)== 1
            T(i,1)=rand() > mort_rate(age(i,1), 1);
        else 
            T(i,1)=rand() > mort_rate(age(i,1), 2);
        end
    end
end