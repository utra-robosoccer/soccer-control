classdef Movement < handle
    %MOVEMENT The movement of the entire robot
    
    properties (Hidden)
        poses = Pose.empty();
        durations = [];
        path = Trajectory.empty();
        body_pos = 0;
        
        footsteps = Footstep.empty();
        left_traj = Trajectory.empty();
        right_traj = Trajectory.empty();
        cur_side = Foot.empty();
        
        step_height = 0.02;
        swing_prop = 0.25;
        air_time = 0.5;
        update_interval = 0.001;
        hip_height = 0.15;
        body_height = 0.105;
        a = [0.089 0.08253 0.037];
        
        smoothing = 0.25;
        
        cur_angles = [ 0 0 0 ; 0 0 0 ];
        body_time = 0;
        left_time = 0;
        right_time = 0;
    end
    
    methods
        
        function obj = Movement(start_pose, next_foot, prev_foot)
            % Initializes the state of the robot
            obj.poses = start_pose;
            obj.footsteps = [next_foot, prev_foot];
            obj.body_height = obj.body_height + obj.hip_height;
            obj.cur_side = next_foot.side;
            obj.body_pos = start_pose.x;
        end
        
        function addPose(obj, pose, duration)
            % Add a new goal pose
            obj.poses(end+1) = pose;
            obj.durations(end+1) = duration;
            obj.toNextPose(false);
        end
        
        function angles = getNextAngles(obj)
            if obj.foot_time >= obj.smoothing / 2 && ...
                    obj.foot_time < obj.air_time - obj.smoothing / 2
                if obj.cur_side = Foot.Left
                    body_next_pos = obj.left_traj.x.positionAtTime(obj.foot_time + obj.smoothing / 2
                else
                    
                end
            else
                
            end
        end
        
    end
    
    methods (Hidden)
        
        function updatePath(obj)
            % Generate body trajectories to the next pose
            if obj.body_time > obj.durations(1)
                obj.body_time = 0;
                if length(obj.path) == 2
                    obj.poses = obj.poses(2:end);
                    obj.durations = obj.durations(2:end);
                    obj.path = obj.path(2);
                elseif ~isempty(obj.path)
                    obj.poses = obj.poses(2);
                    obj.durations = 0;
                    obj.path = Trajectory.empty();
                end
            end
            
            if length(obj.path) == 1 && length(obj.poses) >= 3
                obj.path(2) = Trajectory.plannedPath(obj.durations(2), ...
                    obj.update_interval, obj.poses(2), obj.poses(3)).x;
            elseif isempty(obj.path) && length(obj.poses) >= 2
                obj.path = Trajectory.plannedPath(obj.durations(1), ...
                    obj.update_interval, obj.poses(1), obj.poses(2)).x;
                obj.updatePath();
            end
            obj.footsteps = [obj.footsteps(1:end-2), ...
                Footstep.generateFootsteps(obj.path, ...
                obj.footsteps(end-1), obj.footsteps(end))];
            obj.updateFootTraj();
        end
        
        function updateFootTraj(obj, shift)
            % Generate new foot trajectories to the next footsteps
            if ~isempty(obj.left_traj) && obj.left_time > obj.left_traj.x.duration
                obj.left_time = 0;
                obj.footsteps = obj.footsteps(2:end);
                obj.cur_side = obj.footsteps(1).side;
                if length(obj.left_traj) == 2
                    obj.left_traj = obj.left_traj(2);
                else
                    obj.left_traj = Trajectory.empty();
                end
            end
            if ~isempty(obj.right_traj) && obj.right_time > obj.right_traj.x.duration
                obj.right_time = 0;
                obj.footsteps = obj.footsteps(2:end);
                obj.cur_side = obj.footsteps(1).side;
                if length(obj.right_traj) == 2
                    obj.right_traj = obj.right_traj(2);
                else
                    obj.right_traj = Trajectory.empty();
                end
            end
            if length(obj.footsteps) == 2
                return
            end
            
            if leng
            
            start_time   = obj.body_time;
            end_time     = obj.body_time + obj.air_time;
            start_swing  = obj.footsteps(1).x - obj.path.positionAtTime(start_time);
            end_swing    = obj.footsteps(3).x - obj.path.positionAtTime(end_time);
            start_stance = obj.footsteps(2).x - obj.path.positionAtTime(start_time);
            end_stance   = obj.footsteps(2).x - obj.path.positionAtTime(end_time);
            start_speed  = obj.path.speedAtTime(start_time);
            end_speed    = obj.path.speedAtTime(end_time);
            
            swing_traj = Trajectory.FootTrajectory(obj.air_time, obj.update_interval, ...
                start_swing, end_swing, start_speed, end_speed, obj.step_height);
            stance_traj = Trajectory.FootTrajectory(obj.air_time, obj.update_interval, ...
                start_stance, end_stance, start_speed, end_speed, 0);
            
            if obj.cur_side == Foot.Left
                obj.left_traj = swing_traj;
                obj.right_traj = stance_traj;
            else
                obj.right_traj = swing_traj;
                obj.left_traj = stance_traj;
            end
        end
        
    end
    
end

