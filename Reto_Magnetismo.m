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
I = 1;  % Corriente
R = 5;  % Radio del bucle
n = 100;  % Número de puntos en la integral

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
quiver(X, Y, Bx, By);
xlabel('x');
ylabel('y');
tiempoGraf = toc;
% Function definitions

disp("Tiempo total para correr = " + (tiempo + tiempoGraf) + " s");
if(tiempo < tiempoGraf) 
    disp("Graficar consumo el tiempo mas grande de: " + tiempoGraf + " s")
end

function [campo,tiempo] = getCampoMagnetico(I, R, n, x, y, z)
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
        puntoCruz = ds .* (rpunto / rpuntoMagnitudCubica);
        db = ((mu0 * R * I) / (4 * pi)) * puntoCruz;
        B = B + db;
    end

    campo = B;
    tiempo = toc;
end