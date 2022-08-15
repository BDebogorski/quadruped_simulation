classdef Leg < handle
    
    properties (Constant)
        d1 = 0; %pionowe
        d2 = 9.6;
        d3 = 0;
        d4 = 12.5;
        d5 = 12.5;
        d6 = 20;
        d7 = 20;
        d8 = 6;
        rf = 3;
        tf = pi;
    end
    
    properties
        
        x0 = 0;
        y0 = 0;
        z0 = 0;
        
        last_x;
        last_y;
        last_z;
        
        P;
        legType = string;
    end    
    
    methods
        
        function obj = Leg(type, x, y, z)
            obj.legType = type;
            obj.x0 = x;
            obj.y0 = y;
            obj.z0 = z;
        end
        
        function obj = setMountPosition(obj, x, y, z)
            obj.x0 = x;
            obj.y0 = y;
            obj.z0 = z;
        end
        
        function [vx, vy, vz] = getPoints(obj, x, y, z)
            
            if obj.legType == "RF" || obj.legType == "RB"
                y = -y;
            end
            
            [t1, t2, t3] = deltaKinematics3(obj.d1, obj.d2, obj.d3, obj.d4, obj.d5, obj.d6, obj.d7, obj.d8, obj.tf, x, y, z);
            [vx, vy, vz] = drawDeltaLeg3(obj.d1, obj.d2, obj.d3, obj.d4, obj.d5, obj.d6, obj.d7, obj.d8, obj.tf, t1, t2, t3, x, y, z);
            
            if obj.legType == "RF" || obj.legType == "RB"
                y = -y;
            end
            
            obj.last_x = x;
            obj.last_y = y;
            obj.last_z = z;
            
            if obj.legType == "LF"
                vx = vx+obj.x0;
                vy = -vy+obj.y0;
                vz = vz+obj.z0;
            end
            
            if obj.legType == "RF"  
                vx = vx+obj.x0;
                vy = vy+obj.y0;
                vz = vz+obj.z0;
            end
            
            if obj.legType == "LB"
                vx = vx+obj.x0;
                vy = -vy+obj.y0;
                vz = vz+obj.z0;
            end
            
            if obj.legType == "RB"                
                vx = vx+obj.x0;
                vy = vy+obj.y0;
                vz = vz+obj.z0;
            end
        end
        
        function obj = draw(obj, x, y, z, yaw)
            [vx, vy, vz] = obj.getPoints(x, y, z);
            obj.P = plot3(vx.*cos(yaw)-vy.*sin(yaw), vx.*sin(yaw)+vy.*cos(yaw), vz, 'b');
            set(obj.P,{'LineWidth'},{3});
        end
        
        function obj = update(obj, x, y, z, yaw, xp, yp)
            [vx, vy, vz] = obj.getPoints(x, y, z);
            
            xg = vx.*cos(yaw)-vy.*sin(yaw);
            yg = vx.*sin(yaw)+vy.*cos(yaw);

            set(obj.P,'XData',xg+xp,'YData',yg+yp, 'ZData',vz);
        end
        
        function [x, y, z] = getPosition(obj)
            x = obj.last_x;
            y = obj.last_y;
            z = obj.last_z;
        end
        
        function [x, y, z] = getMountingPosition(obj)
            x = obj.x0;
            y = obj.y0;
            z = obj.z0;
        end
    end
end