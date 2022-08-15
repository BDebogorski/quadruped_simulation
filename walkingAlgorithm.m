classdef walkingAlgorithm < handle
    
    properties
        pair = 1;
        
        Lx;
        Ly;
        fi;
        H;
        h;
        n;
    end
    
    methods
        
        function obj = setParam(obj, Lx, Ly, fi, n, H, h)
            obj.Lx = Lx;
            obj.Ly = Ly;
            obj.fi = fi;
            obj.H = H;
            obj.h = h;
            obj.n = n;
        end
        
        function [x, y, z] = calcDownLegs(obj, i, xs, ys, xm, ym)
            fi_r = -i*obj.fi/obj.n;
            xt = xs-obj.Lx*i/obj.n;
            yt = ys-obj.Ly*i/obj.n;
      
            x = (xt+xm)*cos(fi_r)-(yt+ym)*sin(fi_r)-xm;
            y = (xt+xm)*sin(fi_r)+(yt+ym)*cos(fi_r)-ym;
            z = obj.H;
        end
        
        function [x, y, z] = calcUpLegs(obj, i, xs, ys, xm, ym)
            xe = -obj.Lx/2+(xm+obj.Lx)*cos(obj.fi/2)-(ym+obj.Ly)*sin(obj.fi/2)-xm;
            ye = -obj.Ly/2+(xm+obj.Lx)*sin(obj.fi/2)+(ym+obj.Ly)*cos(obj.fi/2)-ym;
            
            x = xs+(xe-xs)*i/obj.n;
            y = ys+(ye-ys)*i/obj.n;
            z = obj.H+obj.h*sin(pi*i/obj.n);
        end
        
        function [x, y, z] = walk(obj, type, xs, ys, xm, ym, i)
            
            if obj.pair == 1
                if type == "LF" || type == "RB"
                    [x, y, z] = obj.calcUpLegs(i, xs, ys, xm, ym);
                else
                    [x, y, z] = obj.calcDownLegs(i, xs, ys, xm, ym);
                end
            else
                if type == "LF" || type == "RB"
                    [x, y, z] = obj.calcDownLegs(i, xs, ys, xm, ym);
                else
                    [x, y, z] = obj.calcUpLegs(i, xs, ys, xm, ym);
                end
            end
        end
    end
end