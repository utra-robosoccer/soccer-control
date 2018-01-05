classdef Pose
    %POSE a general location on the field
    
    properties
        % Position
        x = 0;
        y = 0;
        z = 0;
        % Angle in the x-y plane measured ccw from positive x
        q = 0;
        % Velocity along q
        v = 0;
    end
    
    methods
        function obj = Pose(x, y, z, q, v)
        %POSE Constructor
        %   OBJ = POSE()
        %   OBJ = POSE(X, Y, Z, Q, V)
        %
        %
        %   Arguments
        %   
        %   X, Y, Z = [1 x 1]
        %       The coordinates on the field
        %
        %   Q = [1 x 1]
        %       The angle in the x-y plane ccw from positive x
        %
        %   V = [1 x 1]
        %       The veloicty along the line denoted by q
        
            obj.x = x;
            obj.y = y;
            obj.z = z;
            obj.q = q;
            obj.v = v;
        end
    end
    
end

