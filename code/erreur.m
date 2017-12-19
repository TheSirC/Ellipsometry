function [E] = erreur(epsilons, omegat, h)
%erreur Compute the mean quadratic error for the measures
% Is and Ic are the ones retrieved from the litterature

theta = deg2rad(70); % Computation of the anfle
w = 1.5:0.01:2.5;

% Retrieve Is and Ic
[Is, Ic] = importI('../données/mesure1_sio2-si.txt');

% Computation of Isc and Icc
N2 = importN('../données/Csi_wor.txt');

N1 = []; % SiO2 index
for i = 1:numel(w)
    [n1, ~] = disp_lorrentz(w(i), omegat, epsilons);
    N1 = [N1, n1];
end
N1 = N1'; % Dimension fix

N0 = ones(size(N1)); % Air index

for i = 1:numel(w)
    [Isc(i), Icc(i)] = calcul_simple_couche_modulation(N0(i), N1(i), N2(i), h, 496e-9, 826e-9, 3.2, theta);
end
Isc = Isc';
Icc = Icc';

n = size(Is,1);
E = sqrt((sum(Isc - Is)^2+sum(Icc - Ic)^2)/(2 * n));

end

