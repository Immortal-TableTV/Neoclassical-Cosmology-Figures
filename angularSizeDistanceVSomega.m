%% Figure 13.3
% Angular size distance r as z --> infinity as a function of density parameter Omega.
%
% Figure 13.3 fixes the redshift at the limiting case z --> infinity and shows
% how that maximum distance depends on the density parameter Omega.
%
% Solid curve: negligible space curvature, R^-2 = 0
% Dashed curve: Lambda = 0

% Clean out data before running again
clear; clc; close all

%% Parameters

% Constants
H0_km_s_Mpc = 70;                                   % Hubble constant in km/s/Mpc
c = 299792.458;                                     % Speed of light in km/s

% Unit Conversions
Hubble_length_Mpc = c / H0_km_s_Mpc;                % c/H0 in Mpc
Hubble_length_Gpc = Hubble_length_Mpc / 1000;       % c/H0 in Gpc

% Omega Values
omegaVals = linspace(0.01, 2, 300);                % x-axis, density parameter Omega
                                                    % Start at 0.01 to avoid division by zero

% Store values
H0a0r_flat = zeros(size(omegaVals));                % Solid curve: R^-2 = 0
H0a0r_Lambda0 = zeros(size(omegaVals));             % Dashed curve: Lambda = 0

%% Calculate curves

for j = 1:length(omegaVals)

    Omega = omegaVals(j);

    %% Solid curve: negligible curvature, R^-2 = 0
    % Flat model:
    % Omega_k = 0
    % Omega_Lambda = 1 - Omega
    %
    % H0 a0 r(infinity)/c = integral from 0 to infinity of dz/E(z)

    Omega_m = Omega;
    Omega_k = 0;
    Omega_Lambda = 1 - Omega_m;

    % Expansion Function E(z) = H(z)/H0
    E_flat = @(z) sqrt(Omega_m*(1 + z).^3 + Omega_Lambda);

    % Dimensionless angular size distance at z --> infinity
    H0a0r_flat(j) = integral(@(z) 1 ./ E_flat(z), 0, Inf);

    %% Dashed curve: Lambda = 0
    % No dark energy model:
    % Omega_Lambda = 0
    % Omega_k = 1 - Omega
    %
    % For Lambda = 0, the limiting result is:
    % H0 a0 r(infinity)/c = 2/Omega

    H0a0r_Lambda0(j) = 2 / Omega;

end

%% Plot setup

figure
hold on

yyaxis left

% Plot solid curve: R^-2 = 0
plot(omegaVals, H0a0r_flat, ...
    'LineStyle', '-', ...
    'LineWidth', 2, ...
    'Marker', 'none', ...
    'DisplayName', 'R^{-2} = 0')

% Plot dashed curve: Lambda = 0
plot(omegaVals, H0a0r_Lambda0, ...
    'LineStyle', '--', ...
    'LineWidth', 2, ...
    'Marker', 'none', ...
    'DisplayName', '\Lambda = 0')

%% Labels and formatting

% Left y-axis: dimensionless Peebles quantity
ylabel('Dimensionless Angular Size Distance H_0 a_0 r / c')
ylim([0 10])

% Right y-axis: physical distance in Gpc
yyaxis right
ylim([0 10 * Hubble_length_Gpc])
ylabel('Angular Size Distance a_0 r [Gpc]')

% Formatting
xlabel('Density Parameter \Omega')
title('Angular Size Distance as z \rightarrow \infty')
legend('Location', 'northeast')
grid on
hold off