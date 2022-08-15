classdef body < handle
    
    properties
        L;
        W;
        b;
    end
    
    methods
         function obj = body(L, W)
             obj.L = L;
             obj.W = W;
         end
         
         function obj = drawBody(obj, x, y, z, yaw, pitch, roll)
            xBody = [obj.L/2, obj.L/2, -obj.L/2, -obj.L/2, obj.L/2];
            yBody = [-obj.W/2, obj.W/2, obj.W/2, -obj.W/2, -obj.W/2];
            zBody = [0, 0, 0, 0,0];
            
            xb = xBody;
            yb = yBody.*cos(roll)-zBody.*sin(roll);
            zb = yBody.*sin(roll)+zBody.*cos(roll);
            
            xBody = xb.*cos(pitch)-zb.*sin(pitch);
            yBody = yb;
            zBody = xb.*sin(pitch)+zb.*cos(pitch);
            
            xb = xBody.*cos(yaw)-yBody.*sin(yaw);
            yb = xBody.*sin(yaw)+yBody.*cos(yaw);
            zb = zBody;
            
            obj.b = plot3(xb+x, yb+y, zBody+z, 'black');
            set(obj.b,{'LineWidth'},{4});
         end
         
         function obj = updateBody(obj, x, y, z, yaw, pitch, roll)
            xBody = [obj.L/2, obj.L/2, -obj.L/2, -obj.L/2, obj.L/2];
            yBody = [-obj.W/2, obj.W/2, obj.W/2, -obj.W/2, -obj.W/2];
            zBody = [0, 0, 0, 0,0];
            
            xb = xBody;
            yb = yBody.*cos(roll)-zBody.*sin(roll);
            zb = yBody.*sin(roll)+zBody.*cos(roll);
            
            xBody = xb.*cos(pitch)-zb.*sin(pitch);
            yBody = yb;
            zBody = xb.*sin(pitch)+zb.*cos(pitch);
            
            xb = xBody.*cos(yaw)-yBody.*sin(yaw);
            yb = xBody.*sin(yaw)+yBody.*cos(yaw);
            zb = zBody;
            
            set(obj.b,'XData',xb+x,'YData',yb+y, 'ZData',zb+z);
         end
    end
end