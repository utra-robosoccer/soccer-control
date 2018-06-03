classdef Trajectory < Trajectories.GeneralizedTrajectory
    %TRAJECTORY Defines a ND Bezier trajectory through space
    
    properties (Hidden)
        data
        dim = 0;
    end
    
    methods
        function pos = positionAtTime(obj, t)
        %POSITIONATTIME produces the positions at time t
            pos = zeros(1, obj.dim);
            pos(1) = obj.data{1}.positionAtTime(t);
            pos(2) = obj.data{2}.positionAtTime(t);
        end
        function speed = speedAtTime(obj, t)
        %SPEEDATTIME produces the speeds at time t
            speed = zeros(1, obj.dim);
            speed(1) = obj.data{1}.speedAtTime(t);
            speed(2) = obj.data{2}.speedAtTime(t);
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
        
        % TODO Modify for three dimensional trajectories
            obj = Trajectories.Trajectory();
            obj.dim = 2;
            obj.duration = duration;
            obj.data = {
                Trajectories.BezierTrajectory(duration, ...
                    prev_pos, next_pos, -prev_speed, -next_speed);
                Trajectories.BezierTrajectory(duration, ...
                    0, 0, 0, 0, height)
            };
        end
        
        function obj = plannedPath(duration, prev_pose, next_pose)
        %PLANNEDPATH Produces a planar trajectory for body
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
        
            obj = Trajectories.Trajectory();
            obj.dim = 2;
            obj.duration = duration;
            obj.data = {
                Trajectories.BezierTrajectory(duration, prev_pose.x, next_pose.x, ...
                    prev_pose.v*cos(prev_pose.q), next_pose.v*cos(next_pose.q));
                Trajectories.BezierTrajectory(duration, prev_pose.y, next_pose.y, ...
                    prev_pose.v*sin(prev_pose.q), next_pose.v*sin(next_pose.q))
            };
        end
    end
    
end

