
row = 0:3;
col = 0:3;
R = [10 10 10 10, 10 5 10 10, 3 10 10 10, 10 10 10 10];

x = repmat(row, [1, 4]);
y = [0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3];


% [M,I] = min(R(:));
% [I_row, I_col] = ind2sub(size(R),I);  

figure
tri = delaunay(x, y, R);
plot3(x, y, R)
% trisurf(tri,x,y,R,'LineWidth',3, 'alpha', 0.3)
% colormap(jet)
% colorbar