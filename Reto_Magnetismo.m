%Entregable 1_ Reto electromagnetismo
%-Pseudocodigo
%Definimos variables generales (n,theta,R,I,miu 0).
%Crear la funcion de campo magnetico.
%Definir vector ds y r-rq/(r-rq)^3.
%Resolver producto cruz entre ambos vectores.
%Ponerlos en un for para hacer la suma de la integración. 
%Programar la funcion y ponerle casos de prueba.
% Parámetros de entrada
n = 5;
f1 = @(x) (x.^2);

a1 = -1;
b1 = 1;

f2 = @(x) sin(x);

a2 = 0;
b2 = 2*pi;

I = 1;
R = 5;
x = 0;
y = 0;
z = 0;

[campo,tiempo] = getCampoMagnetico(I, R, n, x, y, z);
disp("Valor de Campo Magnético B = " + campo(1) + "i " + campo(2) + "j " + campo(3) + "k");

tic
% Parámetros de entrada
I = 4;  % Corriente
R = 9;  % Radio del bucle
n = 100;  % Número de puntos en la integral
mu0 = 4 * pi * 10^(-7);

% Valores de x, y, z para los que se calculará el campo magnético
x = linspace(-10, 10, 40);
y = linspace(-10, 10, 40);
z = linspace(-10, 10, 40);

% Crear una cuadrícula de puntos (x, y, z)
[X, Y, Z] = meshgrid(x, y, z);

% Inicializar matrices para almacenar los valores del campo magnético en cada punto
Bx = zeros(size(X));
By = zeros(size(Y));
Bz = zeros(size(Z));

% Calcular el campo magnético en cada punto de la cuadrícula
for i = 1:numel(X)
    campo_i = getCampoMagnetico(I, R, n, X(i), Y(i), Z(i));
    Bx(i) = campo_i(1);
    By(i) = campo_i(2);
    Bz(i) = campo_i(3);
end

% Graficar el campo magnético en un gráfico bidimensional
subplot(2, 2, 4);
quiver(Y, Z, By, Bz);
xlabel('y');
ylabel('z');
title('Campo Magnético en el plano y-z');

% Integración de la fuerza magnética a lo largo del eje z
fuerza_magnetica = @(z) (3/2) * I * campo(3) * mu0 * R^2 * (z ./ (R^2 + z.^2).^(5/2));
resultado = integral(fuerza_magnetica, 0, 2*pi);

% Gráfico de la fuerza magnética en función de z
subplot(2, 2, 3);
z_values = linspace(0, 2*pi, 100);
fuerza_values = fuerza_magnetica(z_values);
plot(z_values, fuerza_values);
xlabel('z');
ylabel('Fuerza Magnética');
title('Fuerza Magnética en función de z');

% ecuacion de movimiento
I = 4; % Corriente
miu = 1; % Constante
mu0 = 4*pi*10^(-7); % Permeabilidad magnética del vacío
R = 9; % Radio del bucle
m = 1; % Masa de la góndola
g = 9.8; % Aceleración debido a la gravedad

% Parámetros de integración
dt = 0.01; % Paso de tiempo
t_final = 10; %
% Tiempo final

% Condiciones iniciales
z0 = 1; % Posición inicial
v0 = 0; % Velocidad inicial

% Vectores para almacenar los resultados
t = 0:dt:t_final;
z = zeros(size(t));
v = zeros(size(t));

% Iteración del método del punto medio
for i = 1:numel(t)
    % Actualizar la velocidad a medio paso
    v_half = v0 + aceleracion(z0, I, miu, mu0, R, m, g) * (dt / 2);
    
    % Actualizar la posición
    z1 = z0 + v_half * dt;
    
    % Actualizar la aceleración en el nuevo punto
    a1 = aceleracion(z1, I, miu, mu0, R, m, g);
    
    % Actualizar la velocidad
    v1 = v_half + a1 * (dt / 2);
    
    % Almacenar los resultados
    z(i) = z1;
    v(i) = v1;
    
    % Actualizar las condiciones iniciales para la siguiente iteración
    z0 = z1;
    v0 = v1;
end

% Gráficas
subplot(2, 2, 1);
plot(t, z);
xlabel('Tiempo');
ylabel('Posición');
title('Movimiento de la góndola: Posición vs Tiempo');

subplot(2, 2, 2);
plot(t, v);
xlabel('Tiempo');
ylabel('Velocidad');
title('Movimiento de la góndola: Velocidad vs Tiempo');
tiempograf = toc;

disp("Tiempo total para correr = " + (tiempo + tiempoGraf) + " s");
if(tiempo < tiempoGraf) 
    disp("Graficar consume el tiempo más grande de: " + tiempoGraf + " s")
end

% Función para calcular la aceleración en un punto dado
function a = aceleracion(z, I, miu, mu0, R, m, g)
    a = ((3 * I * miu * mu0 * R^2) / (2 * m)) * (z / (R^2 + z^2)^(5/2)) - g;
end

% Función para calcular el campo magnético en un punto dado
function [campo, tiempo] = getCampoMagnetico(I, R, n, x, y, z)
    tic
    a = 0;
    b = 2 * pi;
    lim = linspace(a, b, n);

    mu0 = 4 * pi * 10^(-7);
    B = zeros(3, 1);

    for i = 1:n
        rpunto = [x - R * cos(lim(i)), y - R * sin(lim(i)), z];
        rpuntoMagnitud = norm(rpunto);
        rpuntoMagnitudCubica = rpuntoMagnitud^3;
        ds = [-sin(lim(i)), cos(lim(i)), 0];
        puntoCruz = ds .* (rpunto ./ rpuntoMagnitudCubica);
        db = ((mu0 * R * I) / (4 * pi)) * puntoCruz;
        B = B + db;
    end

    campo = B;
    tiempo = toc;
end
