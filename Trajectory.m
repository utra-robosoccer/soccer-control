classdef Trajectory
    %Trajectory Defines a Bezier trajectory through space
    
    properties (Hidden)
        x
        y
    end
    
    methods
        function pos = positionAtTime(obj, t)
            pos(1) = obj.x.positionAtTime(t);
            pos(2) = obj.y.positionAtTime(t);
        end
        function speed = speedAtTime(obj, t)
            speed(1) = obj.x.speedAtTime(t);
            speed(2) = obj.y.speedAtTime(t);
        end
    end
    
    methods(Static)
        function obj = footTrajectory(duration, ...
                prev_pos, next_pos, prev_speed, next_speed, height)
            obj = Trajectory();
            obj.x = BezierTrajectory(duration, ...
                prev_pos, next_pos, -prev_speed, -next_speed);
            obj.y = BezierTrajectory(duration, ...
                0, 0, 0, 0, height);
        end
        
        function obj = plannedPath(duration, prev_pose, next_pose)
            obj = Trajectory();
            obj.x = BezierTrajectory(duration, prev_pose.x, next_pose.x, ...
                prev_pose.v*cos(prev_pose.q), next_pose.v*cos(next_pose.q));
            obj.y = BezierTrajectory(duration, prev_pose.y, next_pose.y, ...
                prev_pose.v*sin(prev_pose.q), next_pose.v*sin(next_pose.q));
        end
    end
    
end

