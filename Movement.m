classdef Movement < handle
    %MOVEMENT The movement of the entire robot
    
    properties (Hidden)
        poses = Pose.empty();
        durations = [];
        update_interval = 0.01;
        path = Trajectory.empty();
        
        footsteps = Footstep.empty();
        left_traj = FootCycle.empty();
        right_traj = FootCycle.empty();
        cur_side = Foot.empty();
        
        step_height = 0.02;
        stance_time = 0.75;
        swing_time = 0.25;
        hip_height = 0.15;
        body_height = 0.2;
        link_lengths = [0.089 0.08253 0.037];
        
        smoothing = 0.9;
        look_ahead = 0.1;
        
        body_time = 0;
        left_time = 0;
        right_time = 0;
        
        cur_angles = [ 0 0 0 ; 0 0 0 ];
        cur_pos = 0;
        body_pos = 0;
        cur_left = 0;
        cur_right = 0;
        
        dh = [
            0.0650     -pi/2         0      pi/2
                 0      pi/2         0     -pi/2
                 0         0    0.0890         0
                 0         0    0.0825         0
                 0         0         0      pi/2
                 0         0    0.0370         0
        ];
    end
    
    methods
        
        function obj = Movement(start_pose, next_foot, prev_foot)
            % Initializes the state of the robot
            obj.poses = start_pose;
            obj.footsteps = [next_foot, prev_foot];
            obj.body_height = obj.body_height + obj.hip_height;
            obj.cur_side = next_foot.side;
            
            %TODO should not depend on footstep position
            next_angles = ikine(obj.dh, next_foot.x, -obj.hip_height, ...
                -pi/2, obj.cur_angles(1,:));
            prev_angles = ikine(obj.dh, prev_foot.x, -obj.hip_height, ...
                -pi/2, obj.cur_angles(2,:));
            if next_foot.side == Foot.Left
                obj.cur_angles = [next_angles';  prev_angles'];
            else 
                obj.cur_angles = [prev_angles';  next_angles'];
            end
        end
        
        function addPose(obj, pose, duration)
            % Add a new goal pose
            obj.poses(end+1) = pose;
            obj.durations(end+1) = duration;
            obj.updatePath();
        end
        
        function angles = getNextAngles(obj)
            obj.incrementTime();
            
            % Update the nominal foot positions relative to the path
            if ~isempty(obj.left_traj)
                left_foot = obj.left_traj(1).positionAtTime(obj.left_time);
            else
                x_change = obj.path(1).positionAtTime(obj.body_time) - obj.cur_pos;
                left_foot = obj.cur_left - [x_change, 0];
            end
            if ~isempty(obj.right_traj)
                right_foot = obj.right_traj(1).positionAtTime(obj.right_time);
            else
                x_change = obj.path(1).positionAtTime(obj.body_time) - obj.cur_pos;
                right_foot = obj.cur_right - [x_change, 0];
            end
            obj.cur_left = left_foot;
            obj.cur_right = right_foot;
            obj.cur_pos = obj.path(1).positionAtTime(obj.body_time);
            
            % Update the body position relative to the path
            % If there is nothing, the body stays over the foot
            if isempty(obj.left_traj) && isempty(obj.right_traj)
                new_body_pos = obj.body_pos;
            % If there is one trajectory left, move to the last foot
            elseif isempty(obj.right_traj)
                if obj.left_traj(1).duration - obj.swing_time > obj.left_time + obj.look_ahead
                    new_body_pos = obj.linearInterpolateBody();
                else
                    x_change = obj.path(1).positionAtTime(obj.body_time + obj.look_ahead) - obj.cur_pos;
                    new_body_pos = obj.cur_right - [x_change, 0];
                end
            elseif isempty(obj.left_traj)
                if obj.right_traj(1).duration - obj.swing_time > obj.right_time + obj.look_ahead
                    new_body_pos = obj.linearInterpolateBody();
                else
                    x_change = obj.path(1).positionAtTime(obj.body_time + obj.look_ahead) - obj.cur_pos;
                    new_body_pos = obj.cur_left - [x_change, 0];
                end
            % Linear line to the next foot
            elseif (obj.left_traj(1).duration - obj.swing_time > obj.left_time + obj.look_ahead || ...
                    obj.left_traj(1).duration < obj.left_time + obj.look_ahead) && ...
                   (obj.right_traj(1).duration - obj.swing_time > obj.right_time + obj.look_ahead || ...
                    obj.right_traj(1).duration < obj.right_time + obj.look_ahead)
                new_body_pos = obj.linearInterpolateBody();
            % Match the stance foot
            elseif obj.left_traj(1).duration - obj.swing_time <= obj.left_time + obj.look_ahead
                new_body_pos = obj.right_traj(1).positionAtTime(obj.right_time + obj.look_ahead);
            else
                new_body_pos = obj.left_traj(1).positionAtTime(obj.left_time + obj.look_ahead);
            end
            obj.body_pos = (1 - obj.smoothing) * new_body_pos(1) + obj.smoothing * obj.body_pos; 
            
            % Positions of the toe relative to the body
            rel_left = obj.cur_left - [obj.body_pos obj.hip_height];
            rel_right = obj.cur_right - [obj.body_pos obj.hip_height];
            
            q_left = ikine(obj.dh, rel_left(1), rel_left(2), -pi/2, obj.cur_angles(1, :));
            q_right = ikine(obj.dh, rel_right(1), rel_right(2), -pi/2, obj.cur_angles(2, :));
            
            obj.cur_angles = [q_left'; q_right'];
            angles = [q_left' q_right'];
            
            obj.updatePath();
        end
        
        function in = simulate(obj, poses, durations)
            for i = 1:length(poses)
                obj.addPose(poses(i), durations(i));
            end
            
            q0_left = [0 0 obj.cur_angles(1,:) 0];
            q0_right = [0 0 obj.cur_angles(2,:) 0];
            
            total_time = sum(obj.durations) - obj.body_time;
            total_length = floor(total_time / obj.update_interval);
            angles = zeros(6, total_length);
            for i = 1:total_length + 1
                angles(:, i) = obj.getNextAngles();
            end
            
            in = Simulink.SimulationInput('biped_robot');
            in = in.setModelParameter('StartTime', '0', 'StopTime', num2str(total_time));
            
            angles = [zeros(2, total_length+1); angles(1:3, :); zeros(3, total_length+1); angles(4:6, :); zeros(1, total_length+1)];
            angles_ts = timeseries(angles, 0:obj.update_interval:total_time);
            
            in = in.setVariable('dh', obj.dh, 'Workspace', 'biped_robot');
%             in = in.setVariable('q0_left', [0 0 0 0 0 0], 'Workspace', 'biped_robot');
%             in = in.setVariable('q0_right', [0 0 0 0 pi/2 0], 'Workspace', 'biped_robot');
            in = in.setVariable('q0_left', q0_left, 'Workspace', 'biped_robot');
            in = in.setVariable('q0_right', q0_left, 'Workspace', 'biped_robot');
            in = in.setVariable('angles', angles_ts, 'Workspace', 'biped_robot');
            in = in.setVariable('init_body_height', obj.body_height, 'Workspace', 'biped_robot');
            
            sim(in);
        end
        
    end
    
    methods (Hidden)
        
        function incrementTime(obj)
            obj.body_time = obj.body_time + obj.update_interval;
            obj.left_time = obj.left_time + obj.update_interval;
            obj.right_time = obj.right_time + obj.update_interval;
        end
        
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
                obj.footsteps = [obj.footsteps(1:end-2), ...
                    Footstep.generateFootsteps(obj.path, ...
                    obj.footsteps(end-1), obj.footsteps(end))'];
            elseif isempty(obj.path) && length(obj.poses) >= 2
                obj.path = Trajectory.plannedPath(obj.durations(1), ...
                    obj.poses(1), obj.poses(2)).x;
                obj.footsteps = [obj.footsteps(1:end-2), ...
                    Footstep.generateFootsteps(obj.path, ...
                    obj.footsteps(end-1), obj.footsteps(end))'];
                obj.updatePath();
            end
            obj.updateFootTraj();
        end
        
        function updateFootTraj(obj)
        % Update foot trajectories
            % Shift trajectories and footsteps
            if ~isempty(obj.left_traj) && obj.left_time > obj.left_traj(1).duration
                obj.left_time = 0;
                obj.footsteps = obj.footsteps(2:end);
                obj.cur_side = obj.footsteps(1).side;
                if length(obj.left_traj) == 2
                    obj.left_traj = obj.left_traj(2);
                else
                    obj.left_traj = FootCycle.empty();
                end
            end
            if ~isempty(obj.right_traj) && obj.right_time > obj.right_traj(1).duration
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
                    obj.updateFootTraj();
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
                    obj.updateFootTraj();
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
        
        function pos = linearInterpolateBody(obj)
            if obj.footsteps(3).time - obj.body_time > obj.swing_time
                start_time = obj.footsteps(2).time;
                end_time = obj.footsteps(3).time - obj.swing_time;
                start_pos = obj.footsteps(1).x - obj.path(1).positionAtTime(start_time);
                end_pos = obj.footsteps(2).x - obj.path(1).positionAtTime(end_time);
                cur_time = obj.body_time + obj.look_ahead - obj.footsteps(2).time;
            else
                start_time = obj.footsteps(3).time;
                if length(obj.footsteps) >= 4
                    end_time = obj.footsteps(4).time - obj.swing_time;
                else
                    end_time = start_time + (obj.stance_time - 2*obj.swing_time)/2;
                end
                start_pos = obj.footsteps(2).x - obj.path(1).positionAtTime(start_time);
                end_pos = obj.footsteps(3).x - obj.path(1).positionAtTime(end_time);
                cur_time = obj.body_time + obj.look_ahead - obj.footsteps(3).time;
            end
            pos = start_pos + (end_pos - start_pos)/(end_time - start_time) * cur_time;
        end
    end
    
end

