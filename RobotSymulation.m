clc;

L = 44.5; %rozstaw nóg
W = 12;

%parametry kroczenia
Lx = 10;
Ly = 0;
fi = 10/180*pi;
n = 20;
H = -30; 
h = 6;

yawBody = pi/8*0; %orientacja korpusu
pitch = pi/20*0;
roll = pi/12*0;

xp = 0; %startowa pozycja w x
yp = 0; %startowa pozycja w y
yaw = 0; %startowa orientacja robota

LF = Leg("LF", L/2, W/2, 0);
RF = Leg("RF", L/2, -W/2, 0);
LB = Leg("LB", -L/2, W/2, 0);
RB = Leg("RB", -L/2, -W/2, 0);
robotBody = body(L, W);

algorithm = walkingAlgorithm;

LF.draw(0, 5, H, yaw); grid on; hold on; axis equal;
xlabel('x'); ylabel('y'); zlabel('z');
set(gca,'Xtick',-100:20:100);
set(gca,'Ytick',-150:20:30);
xlim([-100 100]);
ylim([-150 30]);
zlim([H 30]);

RF.draw(0, -5, H, yaw);
LB.draw(0, 5, H, yaw);
RB.draw(0, -5, H, yaw);

robotBody.drawBody(0, 0, 0, 0, 0, 0);

[LFxm, LFym, LFzm] = LF.getMountingPosition();
[RFxm, RFym, RFzm] = RF.getMountingPosition();
[LBxm, LBym, LBzm] = LB.getMountingPosition();
[RBxm, RBym, RBzm] = RB.getMountingPosition();

LFXoffset = -L/2*cos(pitch)+L/2;
LFYoffset = -W/2*cos(roll)+W/2;
LFZoffset = -W/2*sin(roll)-L/2*sin(pitch);
        
RFXoffset = -L/2*cos(pitch)+L/2;
RFYoffset = -W/2*cos(roll)+W/2;
RFZoffset = W/2*sin(roll)-L/2*sin(pitch);
        
LBXoffset = -L/2*cos(pitch)+L/2;
LBYoffset = -W/2*cos(roll)+W/2;
LBZoffset = -W/2*sin(roll)+L/2*sin(pitch);
        
RBXoffset = -L/2*cos(pitch)+L/2;
RBYoffset = -W/2*cos(roll)+W/2;
RBZoffset = W/2*sin(roll)+L/2*sin(pitch);
        
LFXoffsetp = LFXoffset;
LFYoffsetp = LFYoffset;
        
RFXoffsetp = RFXoffset;
RFYoffsetp = RFYoffset;
        
LBXoffsetp = LBXoffset;
LBYoffsetp = LBYoffset;
        
RBXoffsetp = RBXoffset;
RBYoffsetp = RBYoffset;

xyaw = (LFXoffset)*cos(yawBody)-(LFYoffset)*sin(yawBody);      %obrot korpusu w osi Z (wyświetlanie)
LFYoffset = (LFXoffset)*sin(yawBody)+(LFYoffset)*cos(yawBody);
LFXoffset = xyaw;
        
xyaw = (RFXoffset)*cos(yawBody)-(RFYoffset)*sin(yawBody);
RFYoffset = (RFXoffset)*sin(yawBody)+(RFYoffset)*cos(yawBody);
RFXoffset = xyaw;
        
xyaw = (LBXoffset)*cos(yawBody)-(LBYoffset)*sin(yawBody);
LBYoffset = (LBXoffset)*sin(yawBody)+(LBYoffset)*cos(yawBody);
LBXoffset = xyaw;
        
xyaw = (RBXoffset)*cos(yawBody)-(RBYoffset)*sin(yawBody);
RBYoffset = (RBXoffset)*sin(yawBody)+(RBYoffset)*cos(yawBody);
RBXoffset = xyaw;
        
LF.setMountPosition(L/2-LFXoffset, W/2-LFYoffset, -LFZoffset);
RF.setMountPosition(L/2-RFXoffset, -W/2+RFYoffset, -RFZoffset);
LB.setMountPosition(-L/2+LBXoffset, W/2-LBYoffset, -LBZoffset);
RB.setMountPosition(-L/2+RBXoffset, -W/2+RBYoffset, -RBZoffset);
        
LFXoffset = LFXoffsetp;
LFYoffset = LFYoffsetp;
        
RFXoffset = RFXoffsetp;
RFYoffset = RFYoffsetp;
        
LBXoffset = LBXoffsetp;
LBYoffset = LBYoffsetp;
        
RBXoffset = RBXoffsetp;
RBYoffset = RBYoffsetp;
        
xyaw = (LFXoffset+L/2)*cos(-yawBody)-(LFYoffset+W/2)*sin(-yawBody)-L/2;      %rotacja nog w osi z (algorytm)
LFYoffset = (LFXoffset+L/2)*sin(yawBody)+(LFYoffset+W/2)*cos(yawBody)-W/2;
LFXoffset = xyaw;
        
xyaw = (RFXoffset+L/2)*cos(-yawBody)-(RFYoffset-W/2)*sin(-yawBody)-L/2;
RFYoffset = (RFXoffset+L/2)*sin(yawBody)+(RFYoffset-W/2)*cos(yawBody)+W/2;
RFXoffset = xyaw;
        
xyaw = (LBXoffset-L/2)*cos(-yawBody)-(LBYoffset+W/2)*sin(-yawBody)+L/2;
LBYoffset = (LBXoffset-L/2)*sin(yawBody)+(LBYoffset+W/2)*cos(yawBody)-W/2;
LBXoffset = xyaw;
        
xyaw = (RBXoffset-L/2)*cos(-yawBody)-(RBYoffset-W/2)*sin(-yawBody)+L/2;
RBYoffset = (RBXoffset-L/2)*sin(yawBody)+(RBYoffset-W/2)*cos(yawBody)+W/2;
RBXoffset = xyaw;

algorithm.setParam(Lx, Ly, fi, n, H, h);

for j = 1:200000
    
    [LFxs, LFys, LFzs] = LF.getPosition();
    [RFxs, RFys, RFzs] = RF.getPosition();
    [LBxs, LBys, LBzs] = LB.getPosition();
    [RBxs, RBys, RBzs] = RB.getPosition();
    
    x_t = (LFxs-LFXoffset)*cos(-yawBody)-(LFys-LFYoffset)*sin(-yawBody);
    LFys = (LFxs-LFXoffset)*sin(-yawBody)+(LFys-LFYoffset)*cos(-yawBody);
    LFxs = x_t;
    
    x_t = (RFxs-RFXoffset)*cos(-yawBody)-(RFys-RFYoffset)*sin(-yawBody);
    RFys = (RFxs-RFXoffset)*sin(-yawBody)+(RFys-RFYoffset)*cos(-yawBody);
    RFxs = x_t;
    
    x_t = (LBxs-LBXoffset)*cos(-yawBody)-(LBys-LBYoffset)*sin(-yawBody);
    LBys = (LBxs-LBXoffset)*sin(-yawBody)+(LBys-LBYoffset)*cos(-yawBody);
    LBxs = x_t;
    
    x_t = (RBxs-RBXoffset)*cos(-yawBody)-(RBys-RBYoffset)*sin(-yawBody);
    RBys = (RBxs-RBXoffset)*sin(-yawBody)+(RBys-RBYoffset)*cos(-yawBody);
    RBxs = x_t;
    
    for i = 0:n %n
        
        xp = double(xp) + Lx/n*cos(yaw)+Ly/n*sin(yaw);
        yp = double(yp) + Lx/n*sin(yaw)-Ly/n*cos(yaw);
        yaw = double(yaw) - fi/n;
        
        robotBody.updateBody(xp, yp, 0, yaw+yawBody, pitch, roll);
        
        [x, y, z] = algorithm.walk("LF", LFxs, LFys, LFxm, -LFym, i);
        x_t = x*cos(yawBody)-y*sin(yawBody);
        y = x*sin(yawBody)+y*cos(yawBody);
        x = x_t;
        LF.update(x+LFXoffset, y+LFYoffset, z+LFZoffset, yaw+yawBody, xp, yp);

        [x, y, z] = algorithm.walk("RF", RFxs, RFys, RFxm, -RFym, i);
        x_t = x*cos(yawBody)-y*sin(yawBody);
        y = x*sin(yawBody)+y*cos(yawBody);
        x = x_t;
        RF.update(x+RFXoffset, y+RFYoffset, z+RFZoffset, yaw+yawBody, xp, yp);

        [x, y, z] = algorithm.walk("LB", LBxs, LBys, LBxm, -LBym, i);
        x_t = x*cos(yawBody)-y*sin(yawBody);
        y = x*sin(yawBody)+y*cos(yawBody);
        x = x_t;
        LB.update(x+LBXoffset, y+LBYoffset, z+LBZoffset, yaw+yawBody, xp, yp);

        [x, y, z] = algorithm.walk("RB", RBxs, RBys, RBxm, -RBym, i);
        x_t = x*cos(yawBody)-y*sin(yawBody);
        y = x*sin(yawBody)+y*cos(yawBody);
        x = x_t;
        RB.update(x+RBXoffset, y+RBYoffset, z+RBZoffset, yaw+yawBody, xp, yp);

        pause(0.01);
    end
    
    %pause(0.1);

    algorithm.pair = algorithm.pair * -1;
end