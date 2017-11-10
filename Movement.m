classdef Movement < handle
    %MOVEMENT The movement of the entire robot
    
    properties (Hidden)
        poses = Pose.empty();
        durations = [];
        path = Trajectory.empty();
        body_pos = 0;
        
        footsteps = Footstep.empty();
        left_traj = FootCycle.empty();
        right_traj = FootCycle.empty();
        cur_side = Foot.empty();
        
        step_height = 0.02;
        stance_time = 0.75;
        swing_time = 0.25;
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
                    obj.poses(2), obj.poses(3)).x;
            elseif isempty(obj.path) && length(obj.poses) >= 2
                obj.path = Trajectory.plannedPath(obj.durations(1), ...
                    obj.poses(1), obj.poses(2)).x;
                obj.updatePath();
            end
            obj.footsteps = [obj.footsteps(1:end-2), ...
                Footstep.generateFootsteps(obj.path, ...
                obj.footsteps(end-1), obj.footsteps(end))];
            obj.updateFootTraj();
        end
        
        function updateFootTraj(obj)
        % Update foot trajectories
            % Shift trajectories and footsteps
            if ~isempty(obj.left_traj) && obj.left_time > obj.left_traj.x.duration
                obj.left_time = 0;
                obj.footsteps = obj.footsteps(2:end);
                obj.cur_side = obj.footsteps(1).side;
                if length(obj.left_traj) == 2
                    obj.left_traj = obj.left_traj(2);
                else
                    obj.left_traj = FootCycle.empty();
                end
            end
            if ~isempty(obj.right_traj) && obj.right_time > obj.right_traj.x.duration
                obj.right_time = 0;
                obj.footsteps = obj.footsteps(2:end);
                obj.cur_side = obj.footsteps(1).side;
                if length(obj.right_traj) == 2
                    obj.right_traj = obj.right_traj(2);
                else
                    obj.right_traj = FootCycle.empty();
                end
            end
            
            % If there are no more footsteps to plan
            if length(obj.footsteps) - length(obj.right_traj) - length(obj.left_traj) == 2 || ...
                    length(obj.left_traj) == 2 && length(obj.right_traj) == 2
                return
            elseif obj.footsteps(1).side == Foot.Left
                if isempty(obj.left_traj) && length(obj.footsteps) >= 3
                    obj.left_traj(1) = FootCycle(obj.path, obj.footsteps(1), ...
                        obj.footsteps(3), obj.step_height, obj.body_time, ...
                        obj.footsteps(3).time - obj.body_time - obj.swing_time, ...
                        obj.footsteps(3).time - obj.body_time);
                elseif length(obj.footsteps) >= 5
                    obj.left_traj(2) = FootCycle(obj.path, obj.footsteps(3), ...
                        obj.footsteps(5), obj.step_height, obj.footsteps(3).time, ...
                        obj.stance_time, obj.stance_time + obj.swing_time);
                end
                if isempty(obj.right_traj) && length(obj.footsteps) >= 4
                    obj.right_traj(1) = FootCycle(obj.path, obj.footsteps(2), ...
                        obj.footsteps(4), obj.step_height, obj.body_time, ...
                        obj.footsteps(4).time - obj.body_time - obj.swing_time, ...
                        obj.footsteps(4).time - obj.body_time);
                elseif length(obj.footsteps) >= 6
                    obj.right_traj(2) = FootCycle(obj.path, obj.footsteps(4), ...
                        obj.footsteps(6), obj.step_height, obj.footsteps(4).time, ...
                        obj.stance_time, obj.stance_time + obj.swing_time);
                end
            else
                if isempty(obj.right_traj) && length(obj.footsteps) >= 3
                    obj.right_traj(1) = FootCycle(obj.path, obj.footsteps(1), ...
                        obj.footsteps(3), obj.step_height, obj.body_time, ...
                        obj.footsteps(3).time - obj.body_time - obj.swing_time, ...
                        obj.footsteps(3).time - obj.body_time);
                elseif length(obj.footsteps) >= 5
                    obj.right_traj(2) = FootCycle(obj.path, obj.footsteps(3), ...
                        obj.footsteps(5), obj.step_height, obj.footsteps(3).time, ...
                        obj.stance_time, obj.stance_time + obj.swing_time);
                end
                if isempty(obj.left_traj) && length(obj.footsteps) >= 4
                    obj.left_traj(1) = FootCycle(obj.path, obj.footsteps(2), ...
                        obj.footsteps(4), obj.step_height, obj.body_time, ...
                        obj.footsteps(4).time - obj.body_time - obj.swing_time, ...
                        obj.footsteps(4).time - obj.body_time);
                elseif length(obj.footsteps) >= 6
                    obj.left_traj(2) = FootCycle(obj.path, obj.footsteps(4), ...
                        obj.footsteps(6), obj.step_height, obj.footsteps(4).time, ...
                        obj.stance_time, obj.stance_time + obj.swing_time);
                end
            end
            
        end
        
    end
    
end

