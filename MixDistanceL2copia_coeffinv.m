
function D = MixDistanceL2copia_coeffinv(X,Y, coeffinv)
%
% Mixed categorical/numerical distance 
%
% INPUT:
% X = matrix of features, nObs x (nCategorical + nNumerical)
%        NOTE: categorical features must be
%                               1) grouped together
%                               2) the first block 
% Y = X (for most applications)
%
% OUTPUT:
% D = matrix of distances (nObsCat+nObsNum) x (nObsCat+nObsNum)

%% Find the number of categorical and numerical features
% The idea is that categorical variables are encoded, so they are
% represented by dummy/binary variables,
% and the sum of the possibile values == 1

nFeatures = size(X,2);
nCat = 0;
for i = 1:nFeatures
    if sum(unique(X(:,i))) == 1
        nCat = nCat + 1;
    end
end
nNum = nFeatures - nCat;

%% Compute distances, separately
DCat = pdist2(X(:,1:13), Y(:,1:13), 'hamming');
DInv = pdist2(X(:,14:16), Y(:,14:16), 'hamming');
DNum = pdist2(X(:,17:end), Y(:,17:end), 'euclidean');
% Compute relative weight based on the number of categorical variables

wCat = (nCat - 3)/(nCat - 3 + nNum + (3 * coeffinv)); 
wNum = nNum/(nCat - 3 + nNum + (3 * coeffinv)); 
wInv = (3 * coeffinv)/(nCat - 3 + nNum + (3 * coeffinv)); 
D = wCat*DCat + wNum*DNum + DInv*wInv;
end


