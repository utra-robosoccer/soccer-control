classdef Movement_Turn < handle
    %MOVEMENT The movement of the entire robot. This is the core class.
    
    properties (Hidden)
        poses = Pose.empty();
        durations = [];
        update_interval = 0.01;
        path = Trajectory.empty();
        
        footsteps = Footstep.empty();
        left_traj = FootCycle.empty();
        right_traj = FootCycle.empty();
        cur_side = Foot.empty();
        
        step_height = 0.04;
        stance_time = 1.5;
        swing_time = 0.5;
        cycle_time = 2;
        hip_height = 0.16;
        body_height = 0.099;
        link_lengths = [0.089 0.08253 0.037];
        
        forw_smoothing = 0.94;
        forw_look_ahead = 0.1;
        side_smoothing = 0.94;
        side_look_ahead = 0.1;
        switch_time = 1.0;
        
        turn = BezierTrajectory.empty();
        l_q = 0;
        r_q = 0;
        dqdt = 0;
        
        body_time = 0;
        left_time = 0;
        right_time = 0;
        turn_time = 0;
        
        cur_angles = zeros(2,6);
        cur_pos = 0;
        body_pos = [0 0];
        cur_left = 1;
        cur_right = 0;
        
        inward = 0.040;
        leg_in = 0.00;
        forward = 0.01;
        
        dh = [
            0.0250     -pi/2         0      pi/2
                 0      pi/2         0     -pi/2
                 0         0    0.0890         0
                 0         0    0.0825         0
                 0         0         0      pi/2
                 0         0    0.0370         0
        ];
    end
    
    methods
        
        function obj = Movement_Turn(start_pose, next_foot, prev_foot)
        %MOVEMENT Constructor
        %   OBJ = MOVEMENT(START_POSE, NEXT_FOOT, PREV_FOOT)
        %
        %   Initializes the starting state of the robot
        %
        %
        %   Arguments
        %
        %   START_POSE = Pose
        %       Staring Pose of the body of the robot
        %
        %   NEXT_FOOT, PREV_FOOT = FootStep
        %       The footstep corresponding to the next swing foot and the
        %       next stance foot, respectively.
        
            % Initializes the state of the robot
            obj.poses = start_pose;
            obj.footsteps = [next_foot, prev_foot];
            obj.body_height = obj.body_height + obj.hip_height;
            obj.cur_side = next_foot.side;
            
            % Determines the initial joint angle of the robot
            %TODO should not depend on footstep position
            obj.cur_angles(1,3) = 1;
            obj.cur_angles(2,3) = 1;
            next_angles = ikine(obj.dh, 0, obj.leg_in, -obj.hip_height, ...
                0, obj.cur_angles(1,:));
            prev_angles = ikine(obj.dh, 0, -obj.leg_in, -obj.hip_height, ...
                0, obj.cur_angles(2,:));
            if next_foot.side == Foot.Left
                obj.cur_angles = [next_angles';  prev_angles'];
            else 
                obj.cur_angles = [prev_angles';  next_angles'];
            end
        end
        
        function configureTunable(obj, parameters)
            obj.forw_smoothing = parameters(1);
            obj.forw_look_ahead = parameters(2);
            obj.side_smoothing = parameters(3);
            obj.side_look_ahead = parameters(4);
            obj.switch_time = parameters(5);
            obj.inward = parameters(6);
            obj.leg_in = parameters(7);
            obj.stance_time = parameters(8);
            obj.swing_time = parameters(9);
            obj.cycle_time = parameters(8) + parameters(9);
        end
        
        function addPose(obj, pose, duration)
        %ADDPOSE Adds a new goal pose
        %   ADDPOSE(OBJ, POSE, DURATION)
        %
        %
        %   Arguments
        %
        %   POSE = Pose
        %       The next goal pose of the robot
        %
        %   DURATION = [1 x 1[
        %       The alloted time to reach the next pose from the previous pose
            obj.poses(end+1) = pose;
            obj.durations(end+1) = duration;
            obj.updatePath();
            Dq = pose.q - obj.poses(1).q;
            n_steps = ceil(obj.path.x.duration/(obj.cycle_time/2));
            dq = Dq / n_steps;
            dt = duration / n_steps;
            obj.dqdt = dq/dt * obj.update_interval* 2;
        end
        
        function angles = getNextAngles(obj)
        %GETNEXTANGLES produces the nest set of joing angles
        %   ANGLES = GETNEXTANGLES(OBJ)
        %
        %
        %   Outputs
        %
        %   ANGLES = [1 x 12]
        %       The joint angles for the next time increment. The first six
        %       correspond to the left leg, the next six correspond to the
        %       right leg.
        
            obj.incrementTime();
            
            % Update the nominal foot positions relative to the path. If
            % trajectory is empty, foot is assumed to be globalley
            % stationary and relative position is changed according to the
            % movemnt of the body.
            if ~isempty(obj.left_traj)
                left_foot = obj.left_traj(1).positionAtTime(obj.left_time);
            else
                x_change = obj.path(1).x.positionAtTime(obj.body_time) - obj.cur_pos;
                left_foot = obj.cur_left - [x_change, 0];
            end
            if ~isempty(obj.right_traj)
                right_foot = obj.right_traj(1).positionAtTime(obj.right_time);
            else
                x_change = obj.path.x(1).positionAtTime(obj.body_time) - obj.cur_pos;
                right_foot = obj.cur_right - [x_change, 0];
            end
            obj.cur_left = left_foot;
            obj.cur_right = right_foot;
            obj.cur_pos = obj.path(1).x.positionAtTime(obj.body_time);
            
            % Update the body position relative to the path
            % If there is nothing, the body stays over the foot
            if isempty(obj.left_traj) && isempty(obj.right_traj)
                new_body_pos(1) = obj.body_pos(1);
                new_body_pos(2) = 0;
            % If there is one trajectory left, move to the last foot
            elseif isempty(obj.right_traj)
                % If stance phase, else swing phse
                if obj.left_traj(1).duration - obj.swing_time > obj.left_time + obj.forw_look_ahead
                    obj.turn_time = 0;
                    new_body_pos = obj.linearInterpolateBody();
                else
                    obj.l_q = max(0, obj.l_q - obj.dqdt);
                    obj.r_q = min(0, obj.r_q + obj.dqdt);
                    x_change = obj.path.x(1).positionAtTime(obj.body_time + obj.forw_look_ahead) - obj.cur_pos;
                    new_body_pos(1) = obj.cur_right(1) - x_change;
                    new_body_pos(2) = -obj.inward;
                end
            elseif isempty(obj.left_traj)
                if obj.right_traj(1).duration - obj.swing_time > obj.right_time + obj.forw_look_ahead
                    obj.turn_time = 0; 
                    new_body_pos = obj.linearInterpolateBody();
                else
                    obj.l_q = max(0, obj.l_q + obj.dqdt);
                    obj.r_q = min(0, obj.r_q - obj.dqdt);
                    x_change = obj.path.x(1).positionAtTime(obj.body_time + obj.forw_look_ahead) - obj.cur_pos;
                    new_body_pos(1) = obj.cur_left(1) - x_change;
                    new_body_pos(2) = obj.inward;
                end
            % Linear line to the next foot if both are in stance phase
            elseif (obj.left_traj(1).duration - obj.swing_time > obj.left_time + obj.forw_look_ahead || ...
                    obj.left_traj(1).duration < obj.left_time + obj.forw_look_ahead) && ...
                   (obj.right_traj(1).duration - obj.swing_time > obj.right_time + obj.forw_look_ahead || ...
                    obj.right_traj(1).duration < obj.right_time + obj.forw_look_ahead)
                new_body_pos = obj.linearInterpolateBody();
                obj.turn_time = 0;
            % Match the stance foot if one foot is in swing
            elseif obj.left_traj(1).duration - obj.swing_time <= obj.left_time + obj.forw_look_ahead
                obj.l_q = max(0, obj.l_q - obj.dqdt);
                obj.r_q = min(0, obj.r_q + obj.dqdt);
                temp = obj.right_traj(1).positionAtTime(obj.right_time + obj.forw_look_ahead);
                new_body_pos(1) = temp(1);
                new_body_pos(2) = -obj.inward;
            else
                obj.l_q = max(0, obj.l_q + obj.dqdt);
                obj.r_q = min(0, obj.r_q - obj.dqdt);
                temp = obj.left_traj(1).positionAtTime(obj.left_time + obj.forw_look_ahead);
                new_body_pos(1) = temp(1);
                new_body_pos(2) = obj.inward;
            end
            % Exponential smoothing of the body movement 
            obj.body_pos(1) = (1 - obj.forw_smoothing) * new_body_pos(1) + obj.forw_smoothing * obj.body_pos(1);
            obj.body_pos(2) = (1 - obj.side_smoothing) * new_body_pos(2) + obj.side_smoothing * obj.body_pos(2); 
            
            % Positions of the toe relative to the body
            rel_left = obj.cur_left - [obj.body_pos(1) obj.hip_height];
            rel_right = obj.cur_right - [obj.body_pos(1) obj.hip_height];
            
%             figure(1)
%             hold on
%             scatter(obj.body_time, obj.l_q, 1);
            
            % Calculate necessary joint angles
            q_left = ikine(obj.dh, 0, obj.leg_in + obj.body_pos(2), ...
                rel_left(2), obj.l_q, obj.cur_angles(1, :));
            q_right = ikine(obj.dh, 0, -obj.leg_in + obj.body_pos(2), ...
                rel_right(2), obj.r_q, obj.cur_angles(2, :));
            
            obj.cur_angles = [q_left'; q_right'];
            angles = [q_left' q_right'];
            
            obj.updatePath();
        end
        
        function [angles, data] = simulate(obj, poses, durations, varargin)
        %SIMULATE runs a simulation of the movement and return angles
        %   ANGLES = SIMULATE(OBJ, POSES, DURATIONS)
        %
        %
        %   Arguments
        %
        %   POSES = [1 x N] Pose
        %       The list of goal positions to reach in the simulation
        %
        %   DURATIONS = [1 x N]
        %       The time allocated to move between each position
        %
        %   
        %   Output
        %
        %   ANGLES = [12 x M]
        %       The joint angles used at each moment in the simulation
            
            p = inputParser();
            p.addParameter('SimulationMode', 'normal');
            p.parse(varargin{:});
            
            % Add all goal poses
            for i = 1:length(poses)
                obj.addPose(poses(i), durations(i));
            end
            
            % Obtain inital joint angles
            q0_left = obj.cur_angles(1,:);
            q0_right = obj.cur_angles(2,:);
            
            % Extract each angle through the time
            total_time = sum(obj.durations) - obj.body_time;
            total_length = floor(total_time / obj.update_interval);
            angles = zeros(12, total_length);
            for i = 1:total_length + 1
                angles(:, i) = obj.getNextAngles();
            end
            
            % Simulate based on these angles
            in = Simulink.SimulationInput('biped_robot');
            in = in.setModelParameter('StartTime', '0', 'StopTime', num2str(total_time));
            in = in.setModelParameter('SimulationMode', p.Results.SimulationMode);
            
            angles_ts = timeseries(angles, 0:obj.update_interval:total_time);
            
            in = in.setVariable('dh', obj.dh, 'Workspace', 'biped_robot');
            in = in.setVariable('q0_left', q0_left, 'Workspace', 'biped_robot');
            in = in.setVariable('q0_right', q0_right, 'Workspace', 'biped_robot');
            in = in.setVariable('angles', angles_ts, 'Workspace', 'biped_robot');
            in = in.setVariable('init_body_height', obj.body_height, 'Workspace', 'biped_robot');
            
            data = sim(in);
        end
        
    end
    
    methods (Hidden)
        
        function incrementTime(obj)
        %INCREMENTTIME advances the time
        %   INCREMENTTIME(OBJ)
            obj.body_time = obj.body_time + obj.update_interval;
            obj.left_time = obj.left_time + obj.update_interval;
            obj.right_time = obj.right_time + obj.update_interval;
            obj.turn_time = obj.turn_time + obj.update_interval; 
        end
        
        function updatePath(obj)
        %UPDATEPATH ensures the path is always up to date
        %   UPDATEPATH(OBJ)
            % Generate body trajectories to the next pose
            if obj.body_time > obj.durations(1)
                obj.body_time = 0;
                if length(obj.path) == 2
                    obj.poses = obj.poses(2:end);
                    obj.durations = obj.durations(2:end);
                    obj.path = obj.path(2);
                elseif ~isempty(obj.path.x)
                    obj.poses = obj.poses(2);
                    obj.durations = 0;
                    obj.path = Trajectory.empty();
                end
            end
            
            if length(obj.path) == 1 && length(obj.poses) >= 3
                obj.path(2) = Trajectory.plannedPath(obj.durations(2), ...
                    obj.poses(2), obj.poses(3));
                obj.footsteps = [obj.footsteps(1:end-2), ...
                    Footstep.generateFootsteps(obj.path(2), obj.cycle_time/2, ...
                    obj.footsteps(end-1), obj.footsteps(end))'];
            elseif isempty(obj.path) && length(obj.poses) >= 2
                obj.path = Trajectory.plannedPath(obj.durations(1), ...
                    obj.poses(1), obj.poses(2));
                obj.footsteps = [obj.footsteps(1:end-2), ...
                    Footstep.generateFootsteps(obj.path, obj.cycle_time/2, ...
                    obj.footsteps(end-1), obj.footsteps(end))'];
                obj.updatePath();
            end
            obj.updateFootTraj();
        end
        
        function updateFootTraj(obj)
        %UPDATEFOOTTRAJ ensures the foot trajectories are always up to date
        %   UPDATEFOOTTRAJ(OBJ)
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
                    obj.left_traj(1) = FootCycle(obj.path.x, obj.footsteps(1), ...
                        obj.footsteps(3), obj.step_height, obj.body_time, ...
                        obj.footsteps(3).time - obj.body_time - obj.swing_time, ...
                        obj.footsteps(3).time - obj.body_time);
                    obj.updateFootTraj();
                elseif length(obj.footsteps) >= 5
                    if obj.footsteps(3).time > obj.body_time
                        obj.left_traj(2) = FootCycle(obj.path(1).x, obj.footsteps(3), ...
                            obj.footsteps(5), obj.step_height, obj.footsteps(3).time, ...
                            obj.stance_time, obj.stance_time + obj.swing_time);
                    else
                        obj.left_traj(2) = FootCycle(obj.path(2).x, obj.footsteps(3), ...
                            obj.footsteps(5), obj.step_height, obj.footsteps(3).time, ...
                            obj.stance_time, obj.stance_time + obj.swing_time);
                    end
                end
                if isempty(obj.right_traj) && length(obj.footsteps) >= 4
                    obj.right_traj(1) = FootCycle(obj.path.x, obj.footsteps(2), ...
                        obj.footsteps(4), obj.step_height, obj.body_time, ...
                        obj.footsteps(4).time - obj.body_time - obj.swing_time, ...
                        obj.footsteps(4).time - obj.body_time);
                    obj.updateFootTraj();
                elseif length(obj.footsteps) >= 6
                    if obj.footsteps(4).time > obj.body_time
                        obj.right_traj(2) = FootCycle(obj.path(1).x, obj.footsteps(4), ...
                            obj.footsteps(6), obj.step_height, obj.footsteps(4).time, ...
                            obj.stance_time, obj.stance_time + obj.swing_time);
                    else
                        obj.right_traj(2) = FootCycle(obj.path(2).x, obj.footsteps(4), ...
                            obj.footsteps(6), obj.step_height, obj.footsteps(4).time, ...
                            obj.stance_time, obj.stance_time + obj.swing_time);
                    end
                end
            else
                if isempty(obj.right_traj) && length(obj.footsteps) >= 3
                    obj.right_traj(1) = FootCycle(obj.path(1).x, obj.footsteps(1), ...
                        obj.footsteps(3), obj.step_height, obj.body_time, ...
                        obj.footsteps(3).time - obj.body_time - obj.swing_time, ...
                        obj.footsteps(3).time - obj.body_time);
                elseif length(obj.footsteps) >= 5
                    obj.right_traj(2) = FootCycle(obj.path(1).x, obj.footsteps(3), ...
                        obj.footsteps(5), obj.step_height, obj.footsteps(3).time, ...
                        obj.stance_time, obj.stance_time + obj.swing_time);
                end
                if isempty(obj.left_traj) && length(obj.footsteps) >= 4
                    obj.left_traj(1) = FootCycle(obj.path(1).x, obj.footsteps(2), ...
                        obj.footsteps(4), obj.step_height, obj.body_time, ...
                        obj.footsteps(4).time - obj.body_time - obj.swing_time, ...
                        obj.footsteps(4).time - obj.body_time);
                elseif length(obj.footsteps) >= 6
                    obj.left_traj(2) = FootCycle(obj.path(1).x, obj.footsteps(4), ...
                        obj.footsteps(6), obj.step_height, obj.footsteps(4).time, ...
                        obj.stance_time, obj.stance_time + obj.swing_time);
                end
            end
            
        end
        
        function pos = linearInterpolateBody(obj)
        %LINEARINTERPOLATEBODY produces a linear interpolation of the
        %   actual body position between the current footstep and the next one
        %   POS = LINEARINTERPOLATEBODY(OBJ)
        %
        %
        %   Output
        %   POS = [2 x 1]
        %       the x and y position of the body along this linear
        %       interpolation.
            start_y = 0; end_y = 0;
            if obj.footsteps(3).time - obj.body_time > obj.swing_time
                start_time = obj.footsteps(2).time;
                end_time = obj.footsteps(3).time - obj.swing_time;
                start_x = obj.footsteps(1).x - obj.path(1).x.positionAtTime(start_time);
                end_x = obj.footsteps(2).x - obj.path(1).x.positionAtTime(end_time);
                if obj.footsteps(3).side == Foot.Left
                    start_y = obj.inward;
                    end_y = -obj.inward;
                else
                    start_y = -obj.inward;
                    end_y = obj.inward;
                end
                cur_time = obj.body_time + obj.forw_look_ahead - obj.footsteps(2).time;
            else
                start_time = obj.footsteps(3).time;
                if length(obj.footsteps) >= 4
                    end_time = obj.footsteps(4).time - obj.swing_time;
                else
                    end_time = start_time + (obj.stance_time - 2*obj.swing_time)/2;
                end
                if end_time < 0
                    keyboard
                end
                start_x = obj.footsteps(2).x - obj.path(1).x.positionAtTime(start_time);
                end_x = obj.footsteps(3).x - obj.path(1).x.positionAtTime(end_time);
                if obj.footsteps(3).side == Foot.Right
                    start_y = obj.inward;
                    end_y = -obj.inward;
                else
                    start_y = -obj.inward;
                    end_y = obj.inward;
                end
                cur_time = obj.body_time + obj.forw_look_ahead - obj.footsteps(3).time;
            end
            if cur_time > obj.switch_time
                pos(1) = end_x;
                pos(2) = -start_y;
            else
                pos(1) = start_x + (end_x - start_x)/obj.switch_time * cur_time;
                pos(2) = - start_y/obj.switch_time * cur_time;
            end
        end
    end
    
end

