%% Figure 13.1
% Lookback time as a function of redshift.
% At a given redshift z, the x-axis tells how much 
% the universe has expanded since emission, while the 
% y-axis gives the corresponding lookback time H0(t0 - tz).
% Flat models: Omega_k = 0, Omega_Lambda = 1 - Omega_m

% Clean out data before running again
clear; clc; close all

%% Inputs

choice = input("Type (1) for No Curvature or Type (2) for No Dark Energy:   ");
    

%Parameters
Omega_m_vals = [0.05, 0.1, 0.2, 1/3, 0.5, 1, 2];    % Present-day matter density parameter
                                                   % Flat Space: negligible curvature

% Constants
H0_km_s_Mpc = 70;                                   % Hubble constant in km/s/Mpc
c = 299792.458;                                     % Speed of light in km/s

% Unit Conversions
Mpc_km = 3.085677581e19;                            % 1 Mpc in km
sec_per_Gyr = 3.15576e16;                           % seconds in 1 gyr

% Variable Conversions
H0_s = H0_km_s_Mpc / Mpc_km;                        % H0 in 1/s
Hubble_time_Gyr = (1 / H0_s) / sec_per_Gyr;         % 1/H0 in Gyr

% Redshift Values:
zvals = linspace(0,10,100);

%% Plot setup

figure
hold on

yyaxis left

max_H0t = 0;

% Give each Omega_m curve a different color
colors = lines(length(Omega_m_vals));

for i = 1:length(Omega_m_vals)
    Omega_m = Omega_m_vals(i);

    if choice == 1
        Omega_Lambda = 1 - Omega_m; % Present-day Cosmological Constant/DE Parameter 
        Omega_k = 0;
    elseif choice == 2
        Omega_Lambda = 0;
        Omega_k = 1 - Omega_m;
    end

    % Expansion Function E(z) = H(z)/ H0
    E = @(z) sqrt(Omega_m*(1 + z).^3 + Omega_k*(1 + z).^2 + Omega_Lambda);

    % Dimensionless lookback time:
    % H0(t0 - tz) = integral from 0 to z of dz / ((1+z)E(z))
    H0_lookback = @(z) integral(@(zp) 1 ./ ((1 + zp).*E(zp)), 0, z);
    
    % Store values of H0(t0 - tz)
    H0t_vals = zeros(size(zvals));

    for j = 1:length(zvals)
        H0t_vals(j) = H0_lookback(zvals(j));
    end

    max_H0t = max(max_H0t, max(H0t_vals));

   % Plot one curve for this Omega_m in dimensionaless lookback time
    plot(zvals, H0t_vals, ...
        'LineStyle', '-', ...
        'LineWidth', 2, ...
        'Marker', 'none', ...
        'Color', colors(i,:), ...
        'DisplayName', ['\Omega_m = ', num2str(Omega_m)])
end

%% Labels and formatting

% Left y-axis: dimensionless time
ylabel('Dimensionless Lookback Time H_0(t_0 - t_z)')
ylim([0 max_H0t])

% Right y-axis: physical time in Gyr
yyaxis right
ylim([0 max_H0t * Hubble_time_Gyr])
ylabel('Lookback Time t_0 - t_z [Gyr]')

% Add horizontal dashed black line at 13.8 Gyr
% Current estimated age of the universe
yline(13.8, 'r--', 'LineWidth', 1.5, ...
    'DisplayName', 'Estimated age of universe = 13.8 Gyr');

% Formatting
xlabel('Redshift z')
title('Lookback Time for Flat Models with Different \Omega_m')
legend('Location', 'east')
grid on
hold off