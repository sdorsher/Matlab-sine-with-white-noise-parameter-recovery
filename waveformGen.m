function [waveform ] = waveformGen( white_noise_amp, gaussian_amp,... 
    gaussian_std, gaussian_mean, sinusoid_amp, sinusoid_freq,...
    sinusoid_phase, deltaT, length)
%WAVEFORMGEN: Generates a waveform with white noise, a gaussian, and a
%sinusoid of a given length for a given time step, deltaT.
% Written by Steven (Susan) Dorsher on 8/9/13.
% waveform = waveformGen(1,5,3,10,1,0.1,0,0.1,1000);

pi=3.14159265;

if((gaussian_std<=0)||(sinusoid_freq<=0)) 
    waveform = -1; %return an error if the the standard deviation
    % or the frequency are less than or equal to zero
else
    t=0:deltaT:deltaT*(length-1); %time array
    waveform = white_noise_amp*randn(size(t)); %generate white noise
    waveform = waveform + sinusoid_amp*sin(sinusoid_phase+...
        2*pi*sinusoid_freq*t); %generate sinusoidal component
    waveform =waveform+...
        gaussian_amp*gaussmf(t,[gaussian_std gaussian_mean]);
        %generate gaussian component of waveform
end

