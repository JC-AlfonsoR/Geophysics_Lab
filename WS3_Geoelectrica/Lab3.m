%% Geo-Electrica Teoria
%{

El parametro de investigacion es resistividad electrica [ohm/m]

%}
clear; close all; clc
%% Metodos

% ===========================================

%% Solucion Lab P1
% Constantes del problema
%a = 1.0;       % [m]
p1 = 10;        % Resistividad 1 [ohm*m]
p2 = 100;
z = 20;         % profundidad de interface [m]
n = 1:10;         % Numero de iteraciones
k = (p2-p1)/(p2+p1);

A = logspace(-1,3,100);    % Mediciones de a [m]
pa = zeros(1,length(A));
k_f = k.^n;

for i = 1:length(A)
    a = A(i);
    div1 = (1+(2*n*z/a).^2).^(1/2);
    div2 = (1+(n*z./a).^2).^(1/2);
    sum1 = k.^n./div1;
    sum2 = k.^n./div2;
    pa(i) = p1*(1 + 4*sum(sum1) - 2*sum(sum2));
end

% Graficar
figure(1)
loglog(A,pa,'LineWidth',2)%,'LineWidth',2,'Marker','x')
title({'Perfil de Resistividad',['\rho_a=10\Omega m     ', ...
    '\rho_b=100\Omega m    z=20m']})
xlabel('Electrode Spacing a [m]')
ylabel('\rho_a[\Omega m]')
grid on
print('Geoelectrica_P1','-dpng')

%% Solucion Lab P2

%function [a,pa] = r_aparente(z,p1,p2)

%end

% Constantes del problema
%a = 1.0;       % [m]
p1 = 10;        % Resistividad 1 [ohm*m]
p2 = 200;
Z = [5,10,20];         % profundidad de interface [m]
n = 1:10;         % Numero de iteraciones
k = (p2-p1)/(p2+p1);

A = logspace(-1,3,100);    % Mediciones de a [m]
pa = zeros(length(Z),length(A));
k_f = k.^n;



for j = 1:length(Z)
    z = Z(j);
    for i = 1:length(A)
        a = A(i);
        div1 = (1+(2*n*z/a).^2).^(1/2);
        div2 = (1+(n*z./a).^2).^(1/2);
        sum1 = k.^n./div1;
        sum2 = k.^n./div2;
        pa(j,i) = p1*(1 + 4*sum(sum1) - 2*sum(sum2));
    end
end

figure(2)
loglog(A,pa,'LineWidth',2)%,'LineWidth',2,'Marker','x')
title({'Perfil de Resistividad',['\rho_a=10\Omega m     ', ...
    '\rho_b=200\Omega m']})
xlabel('Electrode Spacing a [m]')
ylabel('\rho_a[\Omega m]')
legend('z=5m','z=10m','z=20m')
grid on
print('Geoelectrica_P2','-dpng')
%figure(3)
% Profundidad
%Z = 3*A/2;


%%
%{
J. C.
Noviembre de 2015
Funciona sin errores
%}