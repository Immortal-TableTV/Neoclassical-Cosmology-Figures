%% Figure 13.6
% Bolometric distance modulus as a function of redshift.
%
% Vertical axis:
% m - M + 5 log h
%
% Full relation:
% m - M + 5 log h = 42.38 + 5 log10[(1+z)(H0*a0*r/c)]
%
% Flat models: Omega_k = 0, Omega_Lambda = 1 - Omega_m
% No dark energy models: Omega_Lambda = 0, Omega_k = 1 - Omega_m

% Clean out data before running again
clear; clc; close all

%% Inputs

choice = input("Type (1) for No Curvature or Type (2) for No Dark Energy:   ");

%% Parameters

% Omega Values
Omega_m_vals = [0.05, 0.1, 0.2, 1/3, 0.5, 1, 2];

% Redshift Values
zvals = linspace(0.0001, 10, 300);     % Avoid z = 0 because log10(0) is undefined

%% Plot setup

figure
hold on

% Give each Omega_m curve a different color
colors = lines(length(Omega_m_vals));

for i = 1:length(Omega_m_vals)

    Omega_m = Omega_m_vals(i);

    if choice == 1
        Omega_Lambda = 1 - Omega_m;     % Flat model
        Omega_k = 0;
    elseif choice == 2
        Omega_Lambda = 0;               % No dark energy model
        Omega_k = 1 - Omega_m;
    else
        error("Invalid input. Type 1 or 2.")
    end

    % Expansion Function E(z) = H(z)/H0
    E = @(z) sqrt(Omega_m*(1 + z).^3 + Omega_k*(1 + z).^2 + Omega_Lambda);

    % Dimensionless radial coordinate:
    % chi = integral from 0 to z of dz / E(z)
    chi_integral = @(z) integral(@(zp) 1 ./ E(zp), 0, z);

    % Store values
    H0a0r_vals = zeros(size(zvals));
    Bolo_vals = zeros(size(zvals));

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

        % Dimensionless transverse comoving distance:
        % H0*a0*r/c = S_k(chi)
        H0a0r_vals(j) = S_k;

        % Dimensionless luminosity distance:
        % H0*d_L/c = (1+z)(H0*a0*r/c)
        H0dL_over_c = (1 + z) * H0a0r_vals(j);

        % Bolometric distance modulus:
        % m - M + 5 log h = 42.38 + 5 log10(H0*d_L/c)
        Bolo_vals(j) = 42.38 + 5 * log10(H0dL_over_c);

    end

    % Plot one curve for this Omega_m
    plot(zvals, Bolo_vals, ...
        'LineStyle', '-', ...
        'LineWidth', 2, ...
        'Marker', 'none', ...
        'Color', colors(i,:), ...
        'DisplayName', ['\Omega_m = ', num2str(Omega_m)])

end

%% Labels and formatting

ylabel('Bolometric Distance Modulus  m - M + 5 log h')
ylim([40 52])

xlabel('Redshift z')

if choice == 1
    title('Bolometric Distance Modulus: Flat Models')
elseif choice == 2
    title('Bolometric Distance Modulus: No Dark Energy Models')
end

legend('Location', 'southeast')
grid on
hold off