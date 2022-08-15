function [vx, vy, vz] = drawDeltaLeg3(d1, d2, d3, d4, d5, d6, d7, d8, tf, t1, t2, t3, x, y, z)

x0 = 0;
y0 = 0;
z0 = 0;

x1 = 0;
y1 = y0 + d1*cos(t1-pi/2);
z1 = z0 + d1*sin(t1-pi/2);

x2 = 0;
y2 = y1 + d2*cos(t1);
z2 = z1 + d2*sin(t1);

x3 = d3;
y3 = y2;
z3 = z2;

x4 = x2 + d4*cos(t2);
y4 = y2 + d4*cos(t1+pi/2)*sin(t2);
z4 = z2 + d4*sin(t1+pi/2)*sin(t2);

x5 = x3 + d5*cos(t3);
y5 = y3 + d5*cos(t1+pi/2)*sin(t3);
z5 = z3 + d5*sin(t1+pi/2)*sin(t3);

[xp, yp] = getPointsDelta3(d1, d2, d4, d6, d8, tf, x, y, z);
x6 = x0 + xp;
y6 = y2 + yp*cos(t1+pi/2);
z6 = z2 + yp*sin(t1+pi/2);

vx = [x0, x1, x2, x3, x5, x6, x, x6, x4, x2];
vy = [y0, y1, y2, y3, y5, y6, y, y6, y4, y2];
vz = [z0, z1, z2, z3, z5, z6, z, z6, z4, z2];

s1 = sqrt((x0-x1)^2+(y0-y1)^2+(z0-z1)^2) - d1; %sprawdzenie
s2 = sqrt((x1-x2)^2+(y1-y2)^2+(z1-z2)^2) - d2;
s3 = sqrt((x2-x3)^2+(y2-y3)^2+(z2-z3)^2) - d3;
s4 = sqrt((x3-x5)^2+(y3-y5)^2+(z3-z5)^2) - d5;
s5 = sqrt((x5-x6)^2+(y5-y6)^2+(z5-z6)^2) - d7;
s6 = sqrt((x6-x)^2+(y6-y)^2+(z6-z)^2) - d8;
s7 = sqrt((x6-x4)^2+(y6-y4)^2+(z6-z4)^2) - d6;
s8 = sqrt((x4-x2)^2+(y4-y2)^2+(z4-z2)^2) - d4;

spr = s1+s2+s3+s4+s5+s6+s7+s8;

