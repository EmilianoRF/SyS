%% Linear Chirp
% Generate a chirp with linear instantaneous frequency deviation. The chirp
% is sampled at 1 kHz for 2 seconds. The instantaneous frequency is 0 at t
% = 0 and crosses 250 Hz at t = 1 second.

% Copyright 2015 The MathWorks, Inc.
clear all;
clear clc;

nacimiento = 19961105;
factor = 6000;

f1 = nacimiento/factor;



t = 0:1/1e3:2;
y = chirp(t,0,1,f1);

sounsc(y,f1);
