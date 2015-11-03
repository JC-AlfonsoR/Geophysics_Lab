%% Geofisica Lab - Magnetometria
clear; close all; clc
% Recomendaciones
%{
Retro-alimentacion Taller 1
Entrega de talleres -> solo documentos. Evitar archivos muy pesados
Leyendas en los mapas *

Modelado de Anomalias Magneticas
Para comparar entre si anomalias de diferentes magnitudes, se puede 
normalizar los datos a 1
* Incluir imagen del objeto que esta enterrado para que se vea mejor
%}

%% Modelamiento de anomalias gravimetricas

% Grilla
L = 8e3; %      m       Lado de la grilla
dx = 200; %     m       Delta de la grilla
x = -L:dx:L;
y = -L:dx:L;
[X,Y] = meshgrid(x,y);
R = (X.^2+Y.^2).^0.5;       % Distancia

% Propiedades Terreno
rho_terreno = 2.6/1000*1e6;     % kg/m^3
G = 6.67384e-11;                % Nm^2/kg^2
k0_terreno = 1e-4;              % Suseptibilidad magnetica [SI]

% ======================================================
% Anomalia de la esfera
z = 2e3;                        % m     profundidad de la esfera
rho_esfera = 3/1000*1e6;        % densidad (kg/m^3)
r_esfera = 1e3;                 % radio de la esfera
Drho_esfera = rho_esfera-rho_terreno;

% Calculo en 2d y 1d
G_esfera = 4/3*pi*G*Drho_esfera*r_esfera^3/z^2*(1./(1+(R/z).^2)).^1.5;
g_esfera = 4/3*pi*G*Drho_esfera*r_esfera^3/z^2*(1./(1+(x/z).^2)).^1.5;
G_esfera_n = G_esfera/max(max(G_esfera));
g_esfera_n = g_esfera/max(g_esfera);
%{
d1 = (dg_esfera(2:end)-dg_esfera(1:end-1))/dx;
d2 = (d1(2:end)-d1(1:end-1))/dx;
d2 = d2/(max(abs(d2)));
% Calculo la segunda derivada con diferencias finitas para verificar las
magnitudes
%}
%{
% Calculo las derivadas en x
d2_dg_esfera = -4*pi*G*(Drho_esfera*r_esfera^3) * (z^2-4*x.^2)./...
    ((z^2+x.^2).^3.*((x/z).^2+1).^0.5);
d2_dg_esfera_n = d2_dg_esfera/max(abs(d2_dg_esfera));
%}
% Calculo las derivadas en z
d2_dg_esfera = 4/3*pi*G*Drho_esfera*r_esfera^3*(6*z^3-9*z*x.^2)./...
                                        (z^2+x.^2).^(7/2);
d2_dg_esfera_n = d2_dg_esfera/max(abs(d2_dg_esfera));

% ======================================================
% Anomalia del cilindro
z = 2e3;                        % m    profundidad del cilindro
rho_cilindro = 3/1000*1e6;      % densidad (kg/m^3)
r_cilindro = 1e3;               % radio del cilindro
Drho_cilindro = rho_cilindro-rho_terreno;

DG_cilindro = 2*pi*G*Drho_cilindro*r_cilindro^2/z*(1./(1+(X/z).^2));
dg_cilindro = 2*pi*G*Drho_cilindro*r_cilindro^2/z*(1./(1+(x/z).^2));
DG_cilindro_n = DG_cilindro/(max(max(DG_cilindro)));
dg_cilindro_n = dg_cilindro/max(dg_cilindro);
%{
% Calcular derivadas en x
d2_dg_cilindro = -4*pi*G*Drho_cilindro*r_cilindro^2*z * (z^2-3*x.^2)./...
    (x.^2+z^2).^3;
d2_dg_cilindro_n = d2_dg_cilindro/max(abs(d2_dg_cilindro));
%}
d2_dg_cilindro = 2*pi*G*Drho_cilindro*r_cilindro^2*(2*z^3-6*z*x.^2)./...
                                                    (x.^2+z^2).^3;
d2_dg_cilindro_n = d2_dg_cilindro/max(abs(d2_dg_cilindro));

%% Modelamiento de Anomalias Magneticas
R = 1000;         % Radio [m]
dk = 1e-1 - 1e-4; % Suceptibilidad Magnetica
Mu0 = 4*pi*1e-7;  % Permeabilidad magnetica en el vacio [SI]
z = 1000;         % Profundidad [m]

Dbz_esfera = 1/3*Mu0*R^3*dk*(2*z^2-x.^2)./(z^2+x.^2).^(5/2);
Dbz_esfera_n = Dbz_esfera/max(abs(Dbz_esfera)); % Normalizar curva

Dbz_cilindro = 1/2*Mu0*R^2*dk*(z^2-x.^2)./(z^2+x.^2).^2;
Dbz_cilindro_n = Dbz_cilindro/max(abs(Dbz_cilindro));

%% Graficas
y = [-0.3,1];
Lw = 2;
Fs = 12;
co = [         0    0.4470    0.7410;
    0.8500    0.3250    0.0980;
    0.9290    0.6940    0.1250;
    0.4940    0.1840    0.5560;
    0.4660    0.6740    0.1880;
    0.3010    0.7450    0.9330;
    0.6350    0.0780    0.1840];
%set(groot,'defaultAxesColorOrder',co)

figure(1) % Graficas planas de Esfera
plot(x*1e-3,g_esfera_n,'LineWidth',Lw,'Color',co(1,:))
hold all
plot(x*1e-3,d2_dg_esfera_n,'LineWidth',Lw,'Color',co(2,:))
plot(x*1e-3,Dbz_esfera_n,'LineWidth',Lw,'Color',co(3,:))
%title({'Anomalias de Esfera',...
%    'Magnitudes normalizadass en corte vertical'})
xlabel('x[km]'); ylabel('Amplitud Normalizada')
legend_esfera = legend('$\Delta g_z$',...
    '$\frac{\delta^2}{\delta z^2}(\Delta g_z)$',...
    '$\Delta B_z$');
set(legend_esfera,'Interpreter','latex','FontSize',Fs)
ylim(y);
grid on
saveas(gcf,'Esfera.png')

figure(2) % Graficas planas de Cilindro
plot(x*1e-3,dg_cilindro_n,'LineWidth',Lw,'Color',co(1,:))
hold all
plot(x*1e-3,d2_dg_cilindro_n,'LineWidth',Lw,'Color',co(2,:))
plot(x*1e-3,Dbz_esfera_n,'LineWidth',Lw,'Color',co(3,:))
%title({'Anomalias de Cilindro horizontal',...
%    'Magnitudes normalizadass en corte vertical'})
xlabel('x[m]'); ylabel('Amplitud Normalizada')
legend_cilindro = legend('$\Delta g_z$',...
    '$\frac{\delta^2}{\delta z^2}(\Delta g_z)$',...
    '$\Delta B_z$');
set(legend_cilindro,'Interpreter','latex','FontSize',Fs)
ylim(y);
grid on
saveas(gcf,'Cilindro.png')