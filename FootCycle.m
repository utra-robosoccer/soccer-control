classdef FootCycle
    %FOOTCYCLE A full cycle (stance - swing) for one foot
    
    properties (Hidden)
        stance = Trajectory.empty();
        swing = Trajectory.empty();
        trans_time;
        duration;
    end
    
    methods
        function obj = FootCycle(body_traj, last_step, next_step, ...
                step_height, cur_time, trans_time, duration)
            obj.trans_time = trans_time;
            obj.duration = duration;
            init_pos    = last_step.x - body_traj.position(cur_time);
            trans_pos   = last_step.x - body_traj.position(cur_time + trans_time);
            fin_pos     = next_step.x - body_traj.position(cur_time + duration);
            init_speed  = body_traj.speedAtTime(cur_time);
            trans_speed = body_traj.speedAtTime(cur_time + trans_time);
            fin_speed   = body_traj.speedAtTime(cur_time + duration);
            if trans_time > 0
                obj.stance = Trajectory.footTrajectory(trans_time, ...
                    init_pos, trans_pos, -init_speed, -trans_speed, 0);
            end
            if duration > trans_time
                obj.swing = Trajectory.footTrajectory(duration - trans_time, ...
                    trans_pos, fin_pos, -trans_speed, -fin_speed, step_height);
            end
        end
        
        function pos = positionAtTime(obj, t)
            if t < obj.trans_time
                pos = obj.stance.positionAtTime(t);
            else
                pos = obj.swing.positionAtTime(t - obj.trans_time);
            end
        end
        
        function speed = speedAtTime(obj, t)
            if t < obj.trans_time
                speed = obj.stance.speedTime(t);
            else
                speed = obj.speed.positionAtTime(t - obj.trans_time);
            end
        end
    end
    
end

