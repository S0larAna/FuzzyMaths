x=0:0.1:8;
y=trapmf(x, [1 2 4 6]);

plot(x, y);
xlabel('x');
ylabel('\mu');
axis([0 8 0 2])