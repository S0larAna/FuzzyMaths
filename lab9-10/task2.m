x1=linspace(0,8,100);
x2=linspace(0,8,100);

z1=trimf(x1,[1 3 7]);
z2=trapmf(x2, [1 2 4 6]);

[X,Y]=meshgrid(x1,x2);
Z = min(trimf(X,[1 3 7]), trapmf(Y, [1 2 4 6]));

figure
subplot(2, 1, 1);
plot(x1,z1);
ylim([-0.05 1.05]);
title("Первая функция принадлежности");

subplot(2,1,2);
plot(x2,z2);
ylim([-0.05 1.05]);
title("Вторая функция принадлежности");

figure
surf(X,Y,Z);
title('Импликация (Мамдани)');

