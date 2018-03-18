classdef FootCycle < Trajectories.GeneralizedTrajectory
    %FOOTCYCLE A full cycle (stance - swing) for one foot
    
    properties (Hidden)
        stance = Trajectories.Trajectory.empty();
        swing = Trajectories.Trajectory.empty();
        trans_time;
        duration;
    end
    
    methods
        function obj = FootCycle(body_traj, last_step, next_step, ...
                step_height, cur_time, trans_time, duration)
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
        %   STEP_HEIGHT = [1 x 1]%
        %       The peak height of the step
        %
        %   CUR_TIME, TRANS_TIME, DURATION = [1 x 1]
        %       The current time, the time of transition to swing phase,
        %       and the total duration of this cycle.
        
            obj.trans_time = trans_time;
            obj.duration = duration;
            init_pos    = last_step.x - body_traj.positionAtTime(cur_time);
            trans_pos   = last_step.x - body_traj.positionAtTime(cur_time + trans_time);
            fin_pos     = next_step.x - body_traj.positionAtTime(cur_time + duration);
            init_speed  = body_traj.speedAtTime(cur_time);
            trans_speed = body_traj.speedAtTime(cur_time + trans_time);
            fin_speed   = body_traj.speedAtTime(cur_time + duration);
            
            % If there exists a stance phase
            if trans_time > 0
                obj.stance = Trajectories.Trajectory.footTrajectory(trans_time, ...
                    init_pos, trans_pos, init_speed, trans_speed, 0);
            end
            % If there exists a swing phase
            if duration > trans_time
                obj.swing = Trajectories.Trajectory.footTrajectory(duration - trans_time, ...
                    trans_pos, fin_pos, trans_speed, fin_speed, step_height);
            end
        end
        
        function pos = positionAtTime(obj, t)
        %POSITIONATTIME see BezierTrajectory.positionAtTime
            if t < obj.trans_time
                pos = obj.stance.positionAtTime(t);
            else
                pos = obj.swing.positionAtTime(t - obj.trans_time);
            end
        end
        
        function speed = speedAtTime(obj, t)
        %SPEEDATTIME see BezierTrajectory.speedAtTime
            if t < obj.trans_time
                speed = obj.stance.speedTime(t);
            else
                speed = obj.speed.positionAtTime(t - obj.trans_time);
            end
        end
    end
    
end

