function [t1, t2, t3] = deltaKinematics3(d1, d2, d3, d4, d5, d6, d7, d8, tf, x, y, z)

d9 = sqrt(d6^2+d8^2-2*d6*d8*cos(tf)); %const
t5 = acos((d6^2+d9^2-d8^2)/(2*d6*d9)); %const

x6 = x; %zmiana oznaczeń
y6 = (y^2 + z^2 - d2^2)^(1/2) + d1; % wyznaczenie zl
t1 = 2*atan((z - (y^2 + z^2 - d2^2)^(1/2))/(y + d2)); %wyznaczenie pierwszego kąta

l = sqrt(x6^2+y6^2); %lewa strona
xp = (l+(d4^2-d9^2)/l)/2;
yp = sqrt(-xp^2+d4^2);

a = atan2(y6,x6);
x3 = xp*cos(a)-yp*sin(a);
y3 = xp*sin(a)+yp*cos(a);

t7 = atan2((y6-y3),(x6-x3))-t5; %punkt łączenia
x5 = x3+d6*cos(t7);
y5 = y3+d6*sin(t7);

l = sqrt((x5-d3)^2+y5^2); %prawa strona
xp = (l+(d5^2-d7^2)/l)/2;
yp = -sqrt(-xp^2+d5^2);

a = atan2(y5,x5-d3);
x4 = xp*cos(a)-yp*sin(a)+d3;
y4 = xp*sin(a)+yp*cos(a);

t2 = atan2(y3,x3);
t3 = atan2(y4, (x4-d3)); %wyznaczenie kątów
