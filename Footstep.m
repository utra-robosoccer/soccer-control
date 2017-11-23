classdef Footstep < Pose
    %FOOTSTEP defines the position and orientation of a footstep
    
    properties
        side = Foot.Left;
        time = 0;
    end
    
    methods
        function obj = Footstep(x, y, q, side, time)
            if nargin == 0
                x = 0; y = 0; q = 0; side = Foot.Left; time = 0;
            end
            obj@Pose(x, y, 0, q, 0);
            obj.side = side;
            obj.time = time;
        end
    end
    
    methods(Static)
        function footsteps = generateFootsteps(path, next_foot, cur_foot)
            %GENERATEFOOTSTEPS generates footsteps to follow the path
            
            %Time to take one step, can be adjusted.
            airtime = 0.5;
            swing_prop = 0.25;
            
            n_steps = path.duration/airtime;
            footsteps(ceil(n_steps)+2) = Footstep();
            footsteps(1:2) = [next_foot, cur_foot];
            next_pos = cur_foot.x;
            
            for i = 1:floor(n_steps)
                next_pos = path.positionAtTime(i*airtime) + ...
                    path.speedAtTime(i*airtime)*airtime*(1-swing_prop);
                next_side = footsteps(i).side;
                footsteps(i+2) = Footstep(next_pos, 0, 0, next_side, i*airtime);
            end
            
            if floor(n_steps) < ceil(n_steps)
                next_pos = next_pos + path.speedAtTime(floor(n_steps)*airtime);
                next_side = footsteps(end-2).side;
                footsteps(end) = Footstep(next_pos, next_side);
            end
        end
    end
end