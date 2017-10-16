classdef Pose
    %POSE the orientation, position, and velocity
    
    properties
        x = 0;
        y = 0;
        q = 0;
        v = 0;
    end
    
    methods
        function obj = Pose(x, y, q, v)
            obj.x = x;
            obj.y = y;
            obj.q = q;
            obj.v = v;
        end
    end
    
end

