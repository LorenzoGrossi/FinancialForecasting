%% FUNCTION THAT GIVEN EVOLVED CLIENTS AND CENTERS
% COMPUTES THE NEW NEAREST CENTER FOR EACH CLIENT
% AND THE WEIGHT GIVEN TO INVESTOR TYPE VARIABLE CAN BE MODIFIED

function T_new=compute_new_cluster_coeffinv(BankClients_evolved, centers, coeffinv)
% calcola il centro più vicino a quel punto e assegna il punto al cluster
% del centro
    names=BankClients_evolved.Properties.VariableNames;
    centers_tab=array2table(centers, 'VariableNames',names); 
    centers_tab.Gender=categorical(centers_tab.Gender);
    centers_tab.Job=categorical(centers_tab.Job);
    centers_tab.Area=categorical(centers_tab.Area);
    centers_tab.CitySize=categorical(centers_tab.CitySize);
    centers_tab.Investments=categorical(centers_tab.Investments);
    % trasformo i centri come ho fatto le X 
    % Exclude 1st col = ID
    Data_cent = [centers_tab(:,2:18); BankClients_evolved(:,2:end)];
    % Numerical
    N = vartype('numeric');
    NumFeatures = Data_cent(:,N); % subtable of numerical features
    XNum = NumFeatures.Variables; % create a matrix 
    XNum = rescale(XNum); % normalize in [0, 1]
    % Categorical
    C = vartype('categorical');
    CatFeatures = Data_cent(:,C); % subtable of categorical features  
    % Encoding (ie create dummy variables)
    %grp2idx create a vector of integer values from 1 up to the number K of distinct groups.
    XCat = [];
    for i = 1:size(CatFeatures, 2)
        XCat_i = dummyvar(grp2idx(CatFeatures{:,i}));
        XCat = [XCat XCat_i(:,1:end)]; % To use the dummy variables in a model, we must delete a column
                % ABBIAMO DECISO DI TENERE ANCHE L'ULTIMA COLONNA DELLE DUMMY
    end   
    XC = [XCat XNum];  
    % ora mi serve una funzione che variate le caratteristiche
    % dei clienti calcoli il centro del cluster a cui 
    % sono diventati più vicini, per vedere se lo cambiano 
    dist_coeffinv=@(X,Y)MixDistanceL2copia_coeffinv(X,Y,coeffinv);
    Dtot=pdist(XC, dist_coeffinv); 
    Dtotsq=squareform(Dtot);  
    % calcolo il più vicino dei centri ad ogni punto    
    Duseful=Dtotsq(1:6,7:height(BankClients_evolved)+6);
    [~, T_new] = min(Duseful);
    T_new=transpose(T_new);
end
