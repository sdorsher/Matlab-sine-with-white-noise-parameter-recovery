function [ ASDavg ] = binASD( numPerRegion, ASD )
%binASD:
%   Bins the Amplitude Spectral Density into a number of regions. The 
% value of the "average" ASD is given by the square root of the average 
% Power Spectral Density in that region. The number of regions is equal
% to the floor of the length of the ASD divided by the number of points 
% per region. 

numRegions=floor(length(ASD)/numPerRegion); %number of regions for averaging

PSDavg=zeros(1,numRegions);
ASDavg = zeros(1,numRegions);
for region=1:numRegions
    for findex= (region-1)*numPerRegion+1:region*numPerRegion
        PSDavg(region) = PSDavg(region) + ASD(findex)^2;
    end
    ASDavg(region)=sqrt(PSDavg(region)/numPerRegion);
end

end

