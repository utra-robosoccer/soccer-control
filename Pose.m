classdef Pose
    %POSE the orientation, position, and velocity
    
    properties
        x = 0;
        y = 0;
        z = 0;
        q = 0;
        v = 0;
    end
    
    methods
        function obj = Pose(x, y, z, q, v)
            obj.x = x;
            obj.y = y;
            obj.z = z;
            obj.q = q;
            obj.v = v;
        end
    end
    
end

