classdef Trajectory
    %Trajectory Defines a Bezier trajectory through space
    
    properties
        x
        y
    end
    
    methods(Static)
        function obj = FootTrajectory(duration, prev_foot, next_foot, height)
            if prev_foot.side ~= next_foot.side
                error('Footstep mismatch');
            end
            obj = Trajectory();
            obj.x = BezierTrajectory(duration, prev_foot.x, next_foot.x, 0, 0);
            obj.y = BezierTrajectory(duration, 0, 0, 0, 0, height);
        end
        
        function obj = PlannedPath(duration, prev_pose, next_pose)
            obj = Trajectory();
            obj.x = BezierTrajectory(duration, prev_pose.x, next_pose.x, ...
                prev_pose.v*cos(prev_pose.q), next_pose.v*cos(next_pose.q));
            obj.y = BezierTrajectory(duration, prev_pose.y, next_pose.y, ...
                prev_pose.v*sin(prev_pose.q), next_pose.v*sin(next_pose.q));
        end
    end
    
end

