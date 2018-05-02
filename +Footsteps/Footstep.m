classdef Footstep < Pose & Trajectories.GeneralizedTrajectory
    %FOOTSTEP defines the position and orientation of a footstep
    
    properties
        side = Footsteps.Foot.Left;
        time = 0;
    end
    
    methods
        function obj = Footstep(x, y, q, side, time)
        %FOOTSTEP Cconstructor
        %   OBJ = FOOTSTEP()
        %   OBJ = FOOTSTEP(X, Y, Q, SIDE, TIME)
        %
        %   A specific location in the global plane where the foot should
        %   fall at the end of the swing cycle.
        %
        %
        %   Arguments
        %
        %   X, Y = [1 x 1]
        %       The location of the footstep
        %
        %   Q = [1 x 1]
        %       The angle of the footstep in the x-y plane
        %
        %   SIDE = FOOT
        %       Which foot this step corresponds to
        %
        %   TIME = [1 x 1]
        %       When this footstep happens relative in body-trajectory time
        
            if nargin == 0
                x = 0; y = 0; q = 0; side = Footsteps.Foot.Left; time = 0;
            end
            obj@Pose(x, y, 0, q, 0);
            obj.side = side;
            obj.duration = time;
        end
        
        function pos = positionAtTime(obj, t)
            pos = obj;
        end
    end
end