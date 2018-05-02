classdef FootCycle < Trajectories.GeneralizedTrajectory
    %FOOTCYCLE A full cycle (stance - swing) for one foot
    % TODO Replace all usage with direct LiveQueue <- identical use
    
    properties (Hidden)
        stance = Trajectories.Trajectory.empty();
        swing = Trajectories.Trajectory.empty();
        trans_time;
    end
    
    methods
        function obj = FootCycle(body_traj, last_step, next_step, ...
                step_height, trans_time, duration)
        %FOOTCYCLE Constructor
        %   OBJ = FOOTCYCLE(BODY_TRAJ, LAST_STEP, NEXT_STEP, STEP_HEIGHT,
        %       CUR_TIME, TRANS_TIME, DURATION)
        %
        %   Combines the stance and swing phases for one cycle for ease
        %
        %
        %   Arguments
        %
        %   BODY_TRAJ = Trajectory
        %       The idealized path that the body will follow
        %
        %   LAST_STEP, NEXT_STEP = Footstep
        %       The initial and final position for the foot
        %
        %   STEP_HEIGHT = [1 x 1]
        %       The peak height of the step
        %
        %   CUR_TIME, TRANS_TIME, DURATION = [1 x 1]
        %       The current time, the time of transition to stance phase,
        %       and the total duration of this cycle.
        
            obj.trans_time = trans_time;
            obj.duration = duration;
            init_pos    = [last_step.x last_step.y] - body_traj.positionAtTime(0);
            trans_pos   = [next_step.x next_step.y] - body_traj.positionAtTime(trans_time);
            fin_pos     = [next_step.x next_step.y] - body_traj.positionAtTime(duration);
            init_speed  = body_traj.speedAtTime(0);
            trans_speed = body_traj.speedAtTime(trans_time);
            fin_speed   = body_traj.speedAtTime(duration);
            
            %TODO Modify for three dimensional trajectories
            % If there exists a swing phase
            if trans_time > 0
                obj.swing = Trajectories.Trajectory.footTrajectory(trans_time, ...
                    init_pos(1), trans_pos(1), init_speed(1), trans_speed(1), step_height);
            end
            % If there exists a stance phase
            if duration > trans_time
                obj.stance = Trajectories.Trajectory.footTrajectory(duration - trans_time, ...
                    trans_pos(1), fin_pos(1), trans_speed(1), fin_speed(1), 0);
            end
        end
        
        function pos = positionAtTime(obj, t)
        %POSITIONATTIME see BezierTrajectory.positionAtTime
            if t < obj.trans_time
                pos = obj.swing.positionAtTime(t);
            else
                pos = obj.stance.positionAtTime(t - obj.trans_time);
            end
        end
        
        function speed = speedAtTime(obj, t)
        %SPEEDATTIME see BezierTrajectory.speedAtTime
            if t < obj.trans_time
                speed = obj.swing.speedTime(t);
            else
                speed = obj.stance.speedTime(t - obj.trans_time);
            end
        end
    end
    
end

