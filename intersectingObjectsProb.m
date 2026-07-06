%% Figure 13.4
% Probability for intersecting objects along a line of sight as a function
% of redshift. 
% Plotted with dimensionless part
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
    lineOfSightProb = @(z) ((1 + z).^2) ./ E(z);
    
    % Store values of H0(t0 - tz)
    H0t_vals = zeros(size(zvals));

    for j = 1:length(zvals)
        H0t_vals(j) = lineOfSightProb(zvals(j));
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

ylabel('Dimensionless Line-of-Sight Probability Factor')
ylim([0 10])

xlabel('Redshift z')

if choice == 1
    title('Line-of-Sight Intersection Probability: Flat Models')
elseif choice == 2
    title('Line-of-Sight Intersection Probability: No Dark Energy Models')
end

legend('Location', 'east')
grid on
hold off