function [ white_noise_amp ] = estimateWhiteNoise(ASD )
% -Estimates the white_noise_amp by finding the minimum average
% value over some region of the ASD. This is a biased estimator toward
% smaller values, except in the case where the gaussian is still present.
%
% The real and imaginary fourier component 
% each have standard deviations that scale as 
% sqrt(N/2) in normalization. As a result, the ASD should also have a factor 
% of sqrt(N/2) in normalization for gaussian white noise. The exact scale
% factor depends on only the standard deviation of the gaussian, since the
% mean only influences the phase. If it is possible to take an average 
% over all phases by averaging over a long enough integral on the ASD,
% the real and imaginary part combine orthogonally for a factor of sqrt(2)
% in the PSD. Because the minimum is used, this produces a biased 
% underestimate of the white noise amplitude of around 7% (not rigorously
% measured), handled by a scale factor.
%
% white_noise_amp = avg_ASD*(N/2)/sqrt(sqrt(2))*1.07

numPerWNRegion =50; %number per white noise region
%numWNRegions=floor(length(ASD)/numPerWNRegion); %number of regions for WN averaging

%calculate averages of regions to obtain minimum for white noise
%Correct way to do this is to add the spectral power, average that, 
%then take the square root.
ASDwnAvg=binASD(numPerWNRegion, ASD);

%PSDwnAvg=zeros(1,numWNRegions);
%ASDwnAvg = zeros(1,numWNRegions);
%for wnregion=1:numWNRegions
%    for findex= (wnregion-1)*numPerWNRegion+1:wnregion*numPerWNRegion
%        PSDwnAvg(wnregion) = PSDwnAvg(wnregion) + ASD(findex)^2;
%    end
%    ASDwnAvg(wnregion)=sqrt(PSDwnAvg(wnregion)/numPerWNRegion);
%end

%minimum average for white noise and the corresponding region
[minASDwn, minWNRegion]=min(ASDwnAvg);

% The real and imaginary part each have standard deviations that scale as 
% sqrt(N/2) in normalization. As a result, the ASD should also have a factor 
% of sqrt(N/2) in normalization for gaussian white noise. The exact scale
% factor depends on only the standard deviation of the gaussian, since the
% mean only influences the phase. If it is possible to take an average 
% over all phases by averaging over a long enough integral on the ASD,
% the real and imaginary part combine orthogonally for a factor of sqrt(2)
% in the PSD. Because the minimum is used, this produces a biased 
% underestimate of the white noise amplitude of around 7% (not rigorously
% measured), handled by a scale factor.

scaleFac=sqrt(sqrt(2))/1.07;
white_noise_amp = minASDwn/(numPerWNRegion/2)/scaleFac;
end

