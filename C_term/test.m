x = 1:5;
y = 1:5;
z = rand(5, 5);

surf(padarray(x, [0, 1], 'pre'), padarray(y, [0, 1], 'pre'), padarray(z, [1, 1], 'pre'))