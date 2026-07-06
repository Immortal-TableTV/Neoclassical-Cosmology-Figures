%% Figure 13.2
% Angular size distance as a function of redshift.
% Peebles plots the dimensionless quantity H0 a0 r(z).
%
% Here a0 r(z) is the transverse comoving distance factor.
% It is related to the angular diameter distance by:
%
% d_A = a0 r(z) / (1 + z)
%
% So to recreate Figure 13.2, we plot H0 a0 r(z) / c,
%
% Panel (a): R^-2 = 0, so Omega_k = 0 and Omega_Lambda = 1 - Omega_m
% Panel (b): Lambda = 0, so Omega_k = 1 - Omega_m

% Clean out data before running again
clear; clc; close all

%% Inputs

choice = input("Type (1) for No Curvature or Type (2) for No Dark Energy:   ");

%% Parameters

Omega_m_vals = [0.05, 0.1, 0.2, 1/3, 0.5, 1, 2];    % List of Omega_m values to test

% Constants
H0_km_s_Mpc = 70;                                   % Hubble constant in km/s/Mpc
c = 299792.458;                                     % Speed of light in km/s

% Unit Conversions
Hubble_length_Mpc = c / H0_km_s_Mpc;                % c/H0 in Mpc
Hubble_length_Gpc = Hubble_length_Mpc / 1000;       % c/H0 in Gpc

% Redshift Values
zvals = linspace(0,10,200);                         % x-axis, redshift "z" values

%% Plot setup

figure
hold on

yyaxis left

max_H0a0r = 0;

% Give each Omega_m curve a different color (Since MatLab can't do this
% itself?)
colors = lines(length(Omega_m_vals));

for i = 1:length(Omega_m_vals)

    Omega_m = Omega_m_vals(i);

    if choice == 1
        Omega_Lambda = 1 - Omega_m;                 % Flat model: R^-2 = 0
        Omega_k = 0;
    elseif choice == 2
        Omega_Lambda = 0;                           % No dark energy: Lambda = 0
        Omega_k = 1 - Omega_m;
    else
        error("Invalid input. Please enter 1 or 2.")
    end

    % Expansion Function E(z) = H(z)/H0
    E = @(z) sqrt(Omega_m*(1 + z).^3 + Omega_k*(1 + z).^2 + Omega_Lambda);

    % Dimensionless radial coordinate:
    % chi = integral from 0 to z of dz / E(z)
    chi_integral = @(z) integral(@(zp) 1 ./ E(zp), 0, z);

    % Store values of H0*a0*r/c
    H0a0r_vals = zeros(size(zvals));

    for j = 1:length(zvals)

        z = zvals(j);

        % Dimensionless radial distance
        chi = chi_integral(z);

        % Curvature correction S_k(chi)
        if abs(Omega_k) < 1e-12
            S_k = chi;
        elseif Omega_k > 0
            S_k = sinh(sqrt(Omega_k) * chi) / sqrt(Omega_k);
        else
            S_k = sin(sqrt(-Omega_k) * chi) / sqrt(-Omega_k);
        end

        % Peebles Figure 13.2 quantity:
        % H0 a0 r(z) / c = S_k(chi)
        H0a0r_vals(j) = S_k;

    end

    max_H0a0r = max(max_H0a0r, max(H0a0r_vals));

    % Plot one curve for this Omega_m
    plot(zvals, H0a0r_vals, ...
        'LineStyle', '-', ...
        'LineWidth', 2, ...
        'Marker', 'none', ...
        'Color', colors(i,:), ...
        'DisplayName', ['\Omega_m = ', num2str(Omega_m)])

end

%% Labels and formatting

% Left y-axis: dimensionless Peebles quantity
ylabel('Dimensionless Angular Size Distance H_0 a_0 r(z) / c')
ylim([0 max_H0a0r])

% Right y-axis: physical distance in Gpc
yyaxis right
ylim([0 max_H0a0r * Hubble_length_Gpc])
ylabel('Angular Size Distance a_0 r(z) [Gpc]')

% Formatting
xlabel('Redshift z')

if choice == 1
    title('Angular Size Distance: Flat Models, R^{-2} = 0')
elseif choice == 2
    title('Angular Size Distance: No Dark Energy Models, \Lambda = 0')
end

legend('Location', 'east')
grid on
hold off