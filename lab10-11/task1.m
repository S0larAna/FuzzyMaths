step=0.1;
n=4/step+1;
x1=-2:step:2;
x2=-2:step:2;
Input=zeros(2, n*n);
Target=zeros(1, n*n);
y=zeros(n,n);
s=0;
Input=zeros(2,25);
Target=zeros(1,25);
for j=1:n
    for i=1:n
        y(j, i)=(x1(j)^2 + x2(i)^2 + 2*x1(j)*x2(i));
        s=s+1;
        Input(1,s)=x1(j);
        Input(2,s)=x2(i);
        Target(1,s)=y(i,j);
    end;
end;
Input
Target
surf(x1, x2, y);
xlabel('x1');
ylabel('x2');
zlabel('y');
title('Target');

