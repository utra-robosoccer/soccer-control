classdef Footstep
    %FOOTSTEP defines the position and orientation of a footstep
    
    properties
        x = 0;
        side = Foot.Left;
    end
    
    methods
        function self = Footstep(x)
            if nargin > 0
                self.x = x;
            end
        end
    end
    
    methods(Static)
        function footsteps = generateFootsteps(path)
            %GENERATEFOOTSTEPS generates footsteps to follow the path
            
            %TODO: Jeffery, path is a BezierTrajectory, footsteps is an
            % array of Footstep. You should use the positionAtTime and
            % speedAtTime member function of the BezierTrajectory.
        end
    end
end