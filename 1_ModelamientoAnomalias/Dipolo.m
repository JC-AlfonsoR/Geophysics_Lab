%% Geofisica Lab - Magnetometria
clear; close all; clc

% Modelo de dipolo usando dos monopolos

%% Modelamiento de anomalias Magneticas

% Grilla
L = 8e3; %      m       Lado de la grilla
dx = 200; %     m       Delta de la grilla
x = -L:dx:L;
y = -L:dx:L;
[X,Y] = meshgrid(x,y);
R = (X.^2+Y.^2).^0.5;       % Distancia

% Propiedades Terreno
r = 1000;                       % radio [m]
dk = 1e-1 - 1e-4; % Suceptibilidad Magnetica
Mu0 = 4*pi*1e-7;  % Permeabilidad magnetica en el vacio [SI]

theta = deg2rad(60);    % Inclinacion del objeto en x
l = 4000;               % Longitud del objeto

z1 = 2000;         % Profundidad p-(sur) [m]
x1 = 0;            % coordenadas p- (sur) [m]
R1 = ((X-x1).^2 + (Y-0).^2).^.5; % Distancia horizontal a p- [m]
% Los centros solo van a estar desplazados en x, mantienen el mismo y

z2 = l*sin(theta); % Profundidad p+ (norte) [m]
x2 = l*cos(theta); % coordenadas p+ (norte) [m]
R2 = ((X-x2).^2 + (Y-0).^2).^.5; % Distancia horizonatal a p+ [m]

Dbz1 = 1/3*Mu0*r^3*dk*(2*z1^2-R1.^2)./(z1^2+R1.^2).^(5/2);
Dbz2 = 1/3*Mu0*r^3*dk*(2*z2^2-R2.^2)./(z2^2+R2.^2).^(5/2);

% Dbz = p+ - p-
Dbz = Dbz2 - Dbz1;
Dbz_n =  Dbz/(max(max(abs(Dbz))));

%% Graficar
[sx,sy,sz] = sphere(30);
scl = 1e-3;
xl = [-8,8];

figure(1)
%surf(sx-x1*scl,(sy)*scl,sz-z1*scl)
%hold all
%surf(sx-x2*scl,(sy)*scl,sz-z2*scl)
surf(X*scl,Y*scl,Dbz)
xlabel('x [km]'); ylabel('Y [km]'); zlabel('\Delta B_z/F [SI]');
grid on
box on
xlim([-8,8])
ylim([-8,8])
saveas(gcf,'Dipolo_surf.png')
%hold all
%plot3([x1,x2]*scl,[0,0]*scl,-[z1,z2]*scl,'Marker','o')
%axis square

figure(2)
subplot(3,1,3)
hold all
%plot(x*scl,Dbz_n((length(Dbz)-1)/2,:),'LineWidth',3,'Color', [0.4940    0.1840    0.5560]);
plot([x1,x2]*scl,-[z1,z2]*scl,'LineWidth',5,'Color','black')
plot(x1*scl,-z1*scl,'Marker','o','MarkerSize',30,'Color','red',...,
    'MarkerFaceColor','red')
plot(x2*scl,-z2*scl,'Marker','o','MarkerSize',30,'Color','blue',...
    'markerFaceColor','blue')
grid()
xlabel('X [km]'); ylabel('Profundidad Z [km]')
xlim(xl);

subplot(3,1,1:2)
plot(x*scl,Dbz((length(Dbz)-1)/2,:),'LineWidth',3,'Color', [0.4940    0.1840    0.5560]);
grid()
ylabel('Anomalia Magnetica \Delta Bz/F [SI]')
xlim(xl);
saveas(gcf,'Dipolo_esquema.png')