classdef Trajectory
    %Trajectory Defines a Bezier trajectory through space
    
    properties
        x
        y
    end
    
    methods
        function [x,y] = nextPosition(obj)
            x = obj.x.nextPosition();
            y = obj.y.nextPosition();
        end
        
        function b = isComplete(obj)
            b = obj.x.isComplete() && obj.y.isComplete();
        end
    end
    
    methods(Static)
        function obj = footTrajectory(duration, update_interval, ...
                prev_pos, next_pos, prev_speed, next_speed, height)
            if prev_foot.side ~= next_foot.side
                error('Footstep mismatch');
            end
            obj = Trajectory();
            obj.x = BezierTrajectory(duration, update_interval, ...
                prev_pos, next_pos, -prev_speed, -next_speed);
            obj.y = BezierTrajectory(duration, update_interval, ...
                0, 0, 0, 0, height);
        end
        
        function obj = plannedPath(duration, update_interval, prev_pose, next_pose)
            obj = Trajectory();
            obj.x = BezierTrajectory(duration, update_interval, prev_pose.x, next_pose.x, ...
                prev_pose.v*cos(prev_pose.q), next_pose.v*cos(next_pose.q));
            obj.y = BezierTrajectory(duration, update_interval, prev_pose.y, next_pose.y, ...
                prev_pose.v*sin(prev_pose.q), next_pose.v*sin(next_pose.q));
        end
    end
    
end

