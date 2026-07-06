%% Figure 13.14
% Velocity factor f = d logD / d loga
% Evaluated at z = 0
%
% D(0) = (5 Omega_m / 2) E(0) int_0^inf [(1+z) / E(z)^3] dz
%
% f(0) = -1 - Omega_m/2 + Omega_Lambda + 5 Omega_m / [2 D(0)]
%
% Solid curve: negligible space curvature, R^-2 = 0
% Dashed curve: Lambda = 0

% Clean out data before running again
clear; clc; close all

%% Parameters

% Omega Values
omegaVals = linspace(0.01, 2, 300);                % x-axis, density parameter Omega
                                                    % Start at 0.01 to avoid division by zero

% Store values
f_flat = zeros(size(omegaVals));                   % Solid curve: R^-2 = 0
f_Lambda0 = zeros(size(omegaVals));                % Dashed curve: Lambda = 0

D0_flat = zeros(size(omegaVals));                  % Optional: store D(0)
D0_Lambda0 = zeros(size(omegaVals));               % Optional: store D(0)

%% Calculate curves

for j = 1:length(omegaVals)

    Omega = omegaVals(j);

    %% Solid curve: negligible curvature, R^-2 = 0
    % Flat model:
    % Omega_k = 0
    % Omega_Lambda = 1 - Omega_m

    Omega_m = Omega;
    Omega_k = 0;
    Omega_Lambda = 1 - Omega_m;

    % Expansion Function E(z) = H(z)/H0
    E_flat = @(z) sqrt(Omega_m .* (1 + z).^3 ...
                     + Omega_k .* (1 + z).^2 ...
                     + Omega_Lambda);

    % Growth factor evaluated at z = 0
    integrand_flat = @(zp) (1 + zp) ./ (E_flat(zp).^3);

    D0_flat(j) = (5 * Omega_m / 2) * E_flat(0) * integral(integrand_flat, 0, Inf);

    % Velocity factor evaluated at z = 0
    f_flat(j) = -1 - (Omega_m / 2) + Omega_Lambda + (5 * Omega_m) / (2 * D0_flat(j));


    %% Dashed curve: Lambda = 0
    % No dark energy model:
    % Omega_Lambda = 0
    % Omega_k = 1 - Omega_m

    Omega_m = Omega;
    Omega_Lambda = 0;
    Omega_k = 1 - Omega_m;

    % Expansion Function E(z) = H(z)/H0
    E_Lambda0 = @(z) sqrt(Omega_m .* (1 + z).^3 ...
                        + Omega_k .* (1 + z).^2 ...
                        + Omega_Lambda);

    % Growth factor evaluated at z = 0
    integrand_Lambda0 = @(zp) (1 + zp) ./ (E_Lambda0(zp).^3);

    D0_Lambda0(j) = (5 * Omega_m / 2) * E_Lambda0(0) * integral(integrand_Lambda0, 0, Inf);

    % Velocity factor evaluated at z = 0
    f_Lambda0(j) = -1 - (Omega_m / 2) + Omega_Lambda + (5 * Omega_m) / (2 * D0_Lambda0(j));

end

%% Plot setup

figure
hold on

% Plot solid curve: R^-2 = 0
plot(omegaVals, f_flat, ...
    'LineStyle', '-', ...
    'LineWidth', 2, ...
    'Marker', 'none', ...
    'DisplayName', 'R^{-2} = 0')

% Plot dashed curve: Lambda = 0
plot(omegaVals, f_Lambda0, ...
    'LineStyle', '--', ...
    'LineWidth', 2, ...
    'Marker', 'none', ...
    'DisplayName', '\Lambda = 0')

%% Labels and formatting

xlabel('Density Parameter \Omega')
ylabel('Velocity Factor, f(\Omega)')
title('Velocity Factor for Density Fluctuations at z = 0')

ylim([0 1.6])
xlim([0 2])

legend('Location', 'northwest')
grid on
hold off