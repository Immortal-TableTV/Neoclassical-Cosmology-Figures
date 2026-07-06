%% Figure 13.9
% Ratio of redshift difference to angular size for an association of
% objects moving with the general expansion of the universe.
%
% 1/z Sz/Stheta = [H0 a0 r(z) E(z)] / z
%
% Solid curves: negligible space curvature, R^-2 = 0
%   Omega_k = 0, Omega_Lambda = 1 - Omega_m
%
% Dashed curves: Lambda = 0
%   Omega_Lambda = 0, Omega_k = 1 - Omega_m

% Clean out data before running again
clear; clc; close all

%% Parameters

% Omega Values
Omega_m_vals = [0.05, 0.1, 0.2, 1/3, 0.5, 1, 2];

% Redshift Values
zvals = linspace(0.01, 10.5, 300);     % Start above zero to avoid dividing by z = 0

%% Plot setup

figure
hold on

colors = lines(length(Omega_m_vals));

max_ratio = 0;

%% Calculate curves

for i = 1:length(Omega_m_vals)

    Omega_m = Omega_m_vals(i);

    %% Solid curve: negligible curvature, R^-2 = 0
    % Flat model:
    % Omega_k = 0
    % Omega_Lambda = 1 - Omega_m

    Omega_k = 0;
    Omega_Lambda = 1 - Omega_m;

    % Expansion Function E(z) = H(z)/H0
    E_flat = @(z) sqrt(Omega_m*(1 + z).^3 + Omega_k*(1 + z).^2 + Omega_Lambda);

    ratio_flat = zeros(size(zvals));

    for j = 1:length(zvals)

        z = zvals(j);

        % Comoving radial distance integral
        chi = integral(@(zp) 1 ./ E_flat(zp), 0, z);

        % Since Omega_k = 0, H0 a0 r / c = chi
        H0a0r = chi;

        % Ratio:
        % 1/z Sz/Stheta = [H0 a0 r(z) E(z)] / z
        ratio_flat(j) = H0a0r * E_flat(z) / z;

    end

    % Plot solid curve
    plot(zvals, ratio_flat, ...
        'LineStyle', '-', ...
        'LineWidth', 2, ...
        'Color', colors(i,:), ...
        'DisplayName', sprintf('\\Omega_m = %.3g', Omega_m))

    max_ratio = max(max_ratio, max(ratio_flat));
end

%% Labels and formatting

xlabel('Redshift z')
ylabel('(1/z) S_z / S_\theta = H_0 a_0 r(z) E(z) / z')

title('Figure 13.9: Redshift Difference to Angular Size Ratio')

xlim([0,10])
ylim([0, 5])

legend('Location', 'bestoutside')
grid on
hold off