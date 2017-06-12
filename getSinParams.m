function [sinusoid_amp sinusoid_freq sinusoid_phase ] =...
    getSinParams(minFreq, ASD, white_noise_amp )
%getSinParams:
%  Gets sinusoidal parameters from a an Amplitude Spectral Density with
% a single sinusoidal component and white noise, possibly with other 
% components present. 
% Phase is not recoverable from the ASD.
% This routine sets phase=inf. The location is determined by finding the 
% first peak with a threshold of 2.5 times the white noise amplitude. 
% The sinusoid amplitude
% is determined from the amplitude of the ASD peak. The ASD spike should
% have an amplitude that scales as N/2, where N is the number of points
% in the original waveform. 


[ASDspikesAmp,ASDspikesIndex] = ...
    findpeaks(ASD,'THRESHOLD',2.5*sqrt(length(ASD))*white_noise_amp,...
    'NPEAKS', 1);
%requires 2.5 sigma detection 
%This is not a very sensitive algorithm. It would be possible to develop a
%more sensitive algorithm making use of next-to-neighbor comparisons or 
%small-region averages.

%if a peak is found
if(~isinf(ASDspikesAmp))
    %determine the sinusoidal frequency
    sinusoid_freq = minFreq*ASDspikesIndex;
    
    %determine the sinusoidal amplitude
    %Amplitude should scale as 
    sinusoid_amp = ASDspikesAmp/length(ASD-1);
else
    %return a nonsense frequency for an absent sinusoid
    % the presumption is that it is below threshold, so the amplitude is 0
    sinusoid_freq = inf;
    sinusoid_amp = 0;
end

%phase is not recoverable using the ASD. until some other method is 
% implemented, set phase=inf
sinusoid_phase = inf;
end

