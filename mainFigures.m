%% mainFigures.m
% Runs all reproduced Peebles Chapter 13 figure scripts from one place.
%
% Model choices:
%   1 = No Curvature / Flat Models, R^-2 = 0
%   2 = No Dark Energy / Lambda = 0

clear; clc; close all
% -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
%% Choose which figures to run


run_all = true;

run_fig_13_1  = true;   % Lookback time
run_fig_13_2  = true;   % Angular size distance vs redshift
run_fig_13_3  = true;   % Angular size distance as z -> infinity
run_fig_13_4  = true;   % Intersecting objects probability
run_fig_13_5  = true;   % Angular size factor
run_fig_13_6  = true;   % Bolometric distance modulus
run_fig_13_8  = true;   % Counts function
run_fig_13_9  = true;   % Redshift difference / angular size
run_fig_13_12 = true;   % Optical depth for gravitational lensing
run_fig_13_13 = true;   % Growth factor
run_fig_13_14 = true;   % Velocity factor

% -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

if run_all
    run_fig_13_1  = true;
    run_fig_13_2  = true;
    run_fig_13_3  = true;
    run_fig_13_4  = true;
    run_fig_13_5  = true;
    run_fig_13_6  = true;
    run_fig_13_8  = true;
    run_fig_13_9  = true;
    run_fig_13_12 = true;
    run_fig_13_13 = true;
    run_fig_13_14 = true;
end

%% Choose cosmology model

choice = input("Type (1) for No Curvature or Type (2) for No Dark Energy:   ");

% If you don't type in "1" or "2"
if choice ~= 1 && choice ~= 2
    error("Invalid input. Type 1 or 2.")
end

%% Run scripts

fprintf("\nRunning Peebles Chapter 13 figure scripts...\n\n")

if run_fig_13_1
    fprintf("Running Figure 13.1: Lookback Time...\n")
    run("lookBackTime.m")
end

if run_fig_13_2
    fprintf("Running Figure 13.2: Angular Size Distance...\n")
    run("angularSizeDistance.m")
end

if run_fig_13_3
    fprintf("Running Figure 13.3: Angular Size Distance vs Omega...\n")
    run("angularSizeDistanceVSomega.m")
end

if run_fig_13_4
    fprintf("Running Figure 13.4: Intersecting Objects Probability...\n")
    run("intersectingObjectsProb.m")
end

if run_fig_13_5
    fprintf("Running Figure 13.5: Angular Size Factor...\n")
    run("angSize.m")
end

if run_fig_13_6
    fprintf("Running Figure 13.6: Bolometric Distance Modulus...\n")
    run("bolometricDistance.m")
end

if run_fig_13_8
    fprintf("Running Figure 13.8: Counts Function...\n")
    run("countsFunction.m")
end

if run_fig_13_9
    fprintf("Running Figure 13.9: Redshift Difference / Angular Size...\n")
    run("redDiffangSize.m")
end

if run_fig_13_12
    fprintf("Running Figure 13.12: Gravitational Lensing Optical Depth...\n")
    run("opDepthGravLens.m")
end

if run_fig_13_13
    fprintf("Running Figure 13.13: Growth Factor...\n")
    run("growthFactor.m")
end

if run_fig_13_14
    fprintf("Running Figure 13.14: Velocity Factor...\n")
    run("veloFactor.m")
end

fprintf("\nDone running selected figures.\n")