classdef Action < Trajectories.GeneralizedTrajectory
    %ACTION Type and path that a specific action takes
    
    properties
        label
        start
        goal
        path
        stop = false %TODO: allow for specification of full stop
    end
    
    methods
        function obj = Action(label, start, goal, duration, stop)
            obj.label = label;
            obj.start = start;
            obj.goal = goal;
            obj.duration = duration;
            obj.path = Trajectories.Trajectory.plannedPath( ...
                duration, start, goal ...
            );
            if nargin > 4
                obj.stop = stop;
            end
        end
        
        function pos = positionAtTime(obj, t)
            pos = obj.path.positionAtTime(t);
        end
        
        function speed = speedAtTime(obj, t)
            speed = obj.path.speedAtTime(t);
        end
    end  
end

