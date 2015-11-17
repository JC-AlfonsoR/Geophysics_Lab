%% Taller 4
clear; close all; clc
%{
Graficar
Encontrar maximos
Buscar parametros en curvas
%}

%% Cargar datos
T1 = load('Tabla1.csv');
T2 = load('Tabla2.csv');

%% Interpolacion con Splines
method = 'spline';
n = 500;
xx1 = linspace(min(T1(:,1)),max(T1(:,1)),n);
T1I_r = interp1(T1(:,1),T1(:,2),xx1,method);
T1I_i = interp1(T1(:,1),T1(:,3),xx1,method);

xx2 = linspace(min(T2(:,1)),max(T2(:,1)),n);
T2I_r = interp1(T2(:,1),T2(:,2),xx2,method);
T2I_i = interp1(T2(:,1),T2(:,3),xx2,method);

%% Picos seleccionados
T1py = [7.962, -18.04, 1.173, 6.751, -15.23, 3.899];
T1px = [115.1, 80.8, 56.11, 115.1, 85.29, 53.55];
T2py = [10.49, -32.55, 10.06, -6.917, -21.13,  -8.453];
T2px = [353.2, 275.3, 130.06, 354.2, 225.7,  101.2];
%% Graficas
desface = 0.4;
figure(1)
plot(T1(:,1),T1(:,2),'o','MarkerFaceColor',[0 0 1])
hold all
plot(xx1,T1I_r,'Color',[0 0 1],'LineWidth',2)
plot(T1(:,1),T1(:,3),'o','Color',[1 0 0],'MarkerFaceColor',[1 0 0])
plot(xx1,T1I_i,'Color',[1 0 0],'LineWidth',2)
plot(T1px,T1py+desface,'v','markerfacecolor',[0 0 0],'Color',[0,0,0])
grid()
title('Medición 1')
xlabel('x [m]'); ylabel('%')
legend('Real','Spline interpolation','Img','Spline interpolation',...
    'Location','SouthWest')
print('tabla1','-dpng')

figure(2)
plot(T2(:,1),T2(:,2),'o','MarkerFaceColor',[0 0 1])
hold all
plot(xx2,T2I_r,'Color',[0 0 1],'LineWidth',2)
plot(T2(:,1),T2(:,3),'o','Color',[1 0 0],'MarkerFaceColor',[1 0 0])
plot(xx2,T2I_i,'Color',[1 0 0],'LineWidth',2)
plot(T2px,T2py+desface,'v','markerfacecolor',[0 0 0],'Color',[0,0,0])
grid()
title('Medición 2')
xlabel('x [m]'); ylabel('%')
legend('Real','Spline interpolation','Img','Spline interpolation',...
    'Location','SouthEast')
print('tabla2','-dpng')