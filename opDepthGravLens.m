%% Figure 13.12
% Optical depth for gravitational lensing as a function of redshift
%
% log(F_gl)(z) vs z
%
% F_gl = 16*pi^3 * integral from 0 to z_s of
%        dz_l/E(z_l) * (y_ol*y_ls/y_os)^2
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
zvals = linspace(0.00001, 10, 300);     % Avoid z = 0 because log(F_gl) is undefined

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
    % chi(z) = integral from 0 to z of dz/E(z)
    chi_integral = @(z) integral(@(zp) 1 ./ E(zp), 0, z);

    % Curvature correction function S_k(chi)
    S_k_func = @(chi) curvature_distance(chi, Omega_k);

    % Store values
    Fgl_vals = zeros(size(zvals));
    logFgl_vals = zeros(size(zvals));

    for j = 1:length(zvals)

        z_s = zvals(j);                 % Source redshift

        % Radial distance to source
        chi_s = chi_integral(z_s);

        % Distance from observer to source
        y_os = S_k_func(chi_s);

        % Lensing integrand over lens redshift z_l
        integrand = @(z_l) lensing_integrand(z_l, z_s, E, chi_integral, S_k_func, y_os);

        % Optical depth factor
        Fgl_vals(j) = 16 * pi^3 * integral(integrand, 0, z_s, 'ArrayValued', true);

        % Plot log10(F_gl)
        logFgl_vals(j) = log10(Fgl_vals(j));

    end

    % Plot one curve for this Omega_m
    plot(zvals, logFgl_vals, ...
        'LineStyle', '-', ...
        'LineWidth', 2, ...
        'Marker', 'none', ...
        'Color', colors(i,:), ...
        'DisplayName', ['\Omega_m = ', num2str(Omega_m)])

end

%% Labels and formatting

ylim([0 3])
ylabel('log_{10}(F_{gl})')
xlabel('Redshift z')

if choice == 1
    title('Gravitational Lensing Optical Depth: Flat Models')
elseif choice == 2
    title('Gravitational Lensing Optical Depth: No Dark Energy Models')
end

legend('Location', 'southeast')
grid on
hold off

%% Local Functions

function S_k = curvature_distance(chi, Omega_k)

    if abs(Omega_k) < 1e-12
        S_k = chi;
    elseif Omega_k > 0
        S_k = sinh(sqrt(Omega_k) .* chi) ./ sqrt(Omega_k);
    else
        S_k = sin(sqrt(-Omega_k) .* chi) ./ sqrt(-Omega_k);
    end

end

function val = lensing_integrand(z_l, z_s, E, chi_integral, S_k_func, y_os)

    val = zeros(size(z_l));

    for n = 1:length(z_l)

        zl = z_l(n);

        % Radial distance to lens
        chi_l = chi_integral(zl);

        % Radial distance to source
        chi_s = chi_integral(z_s);

        % Angular diameter distance factors
        y_ol = S_k_func(chi_l);              % Observer to lens
        y_ls = S_k_func(chi_s - chi_l);      % Lens to source

        % Integrand:
        % dz/E(z) * (y_ol*y_ls/y_os)^2
        val(n) = (1 ./ E(zl)) .* ((y_ol .* y_ls ./ y_os).^2);

    end

end