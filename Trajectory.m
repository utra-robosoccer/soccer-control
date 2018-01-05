classdef Trajectory
    %TRAJECTORY Defines a 2D Bezier trajectory through space
    
    properties (Hidden)
        x
        y
    end
    
    methods
        function pos = positionAtTime(obj, t)
        %POSITIONATTIME produces the x and y position at time t
            pos(1) = obj.x.positionAtTime(t);
            pos(2) = obj.y.positionAtTime(t);
        end
        function speed = speedAtTime(obj, t)
        %POSITIONATTIME produces the x and y speed at time t
            speed(1) = obj.x.speedAtTime(t);
            speed(2) = obj.y.speedAtTime(t);
        end
    end
    
    methods(Static)
        function obj = footTrajectory(duration, ...
                prev_pos, next_pos, prev_speed, next_speed, height)
        %FOOTTRAJECTORY Produces a forward an vertical trajectory for foot
        %   OBJ = FOOTTRAJECTORY(DURATION, PREV_POS, NEXT_POS, PREV_SPEED, NEXT_SPEED, HEIGHT)
        %
        %   This produces the path that the foot will follow across one
        %   cycle (stance or swing. A stance cycle will simply have height
        %   of 0. Does not model off-axis movement of the foot.
        %
        %
        %   Arguments
        %
        %   DURATION = [1 x 1]
        %       The time to move between the two positions
        %
        %   PREV_POS, NEXT_POS = [1 x 1]
        %       The starting and ending positions of the foot in the x-axis
        %
        %   PREV_SPEED, NEXT_SPEED = [1 x 1]
        %       The starting and ending speeds of the foot in the x-axis
        %
        %   HEIGHT = [1 x 1]
        %       The peak height during mid-swing of the cycle
        
            obj = Trajectory();
            obj.x = BezierTrajectory(duration, ...
                prev_pos, next_pos, -prev_speed, -next_speed);
            obj.y = BezierTrajectory(duration, ...
                0, 0, 0, 0, height);
        end
        
        function obj = plannedPath(duration, prev_pose, next_pose)
        %PLANNEDPATH Produces a forward an vertical trajectory for body
        %   OBJ = PLANNEDPATH(DURATION, PREV_POS, NEXT_POS)
        %
        %   This produces the path that the body will follow based on an 
        %   inital and final Pose.
        %
        %
        %   Arguments
        %
        %   DURATION = [1 x 1]
        %       The time to move between the two positions
        %
        %   PREV_POS, NEXT_POS = Pose
        %       The starting and ending poses of the body
        
            obj = Trajectory();
            obj.x = BezierTrajectory(duration, prev_pose.x, next_pose.x, ...
                prev_pose.v*cos(prev_pose.q), next_pose.v*cos(next_pose.q));
            obj.y = BezierTrajectory(duration, prev_pose.y, next_pose.y, ...
                prev_pose.v*sin(prev_pose.q), next_pose.v*sin(next_pose.q));
        end
    end
    
end

