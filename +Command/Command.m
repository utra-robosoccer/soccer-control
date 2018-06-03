classdef Command < handle
    %COMMAND Control of the entire robot movement
    
    properties
        % High-level actions and idealized path
        actions
        
        % Body physical parameters
        hip_height = 0.16;
        hip_width = 0.04;
        dh = [
            0.0250     -pi/2         0      pi/2
                 0      pi/2         0     -pi/2
                 0         0    0.0890         0
                 0         0    0.0825         0
                 0         0         0      pi/2
                 0         0    0.0370         0
        ];
        
        % Movement timing parameters
        swing_time = 0.5;
        stance_time = 1.5;
        cycle_time = 2;
        hold_time = 0.0; % TODO implement
        
        % Movement physical parameters
        step_height = 0.05;
        angles = zeros(2,6);
        %%% TODO separate into left and right, fix timing
        footsteps
        foot_pos
        %%%
        body_pose = Pose(0, -0.0, 0, 0, 0);
        cur_angles = zeros(2,6);
        
        % Trajectories
        foot_traj_l
        foot_traj_r
        body_traj
    end
    
    methods (Hidden)
        %TODO this is not the right place for this function
        function traj = buildBodyTraj(obj, init_time, ...
                init_step, fin_step, duration)
        %BUILDBODYTRAJ builds body trajectory between footsteps
        %   TRAJ = BUILDBODYTRAJ(OBJ, INIT_TIME, INIT_STEP, ...
        %       FIN_STEP, DURATION)
        %
        %   BUILDBODYTRAJ constructs a smoothed trajectory for the body to
        %   follow between footsteps. This is done with bezier curves,
        %   allowing trajectory to precisely match foot tajectory when
        %   needed.
        %
        %
        %   Arguments
        %
        %   INIT_TIME = [1 x 1] 
        %       How far into the future from the current time to construct
        %       the body trajectory.
        %
        %   INIT_STEP = [1 x 1] Pose
        %       The initial position of the body.
        %
        %   FIN_STEP = [1 x 1] Pose
        %       The final position of the body.
        %
        %   DURATION = [1 x 1]
        %       How long the trajectory should take.
        %
        %
        %   Outputs
        %
        %   TRAJ = [1 x 1] Trajectories.Trajectory(dim=2)
        %       The two-dimensional body trajectory.
            init_pos = [init_step.x init_step.y] - ...
                obj.actions.positionAtTime(init_time);
            fin_pos = [fin_step.x fin_step.y] - ...
                obj.actions.positionAtTime(init_time + duration);
            init_speed = -obj.actions.speedAtTime(init_time);
            fin_speed = -obj.actions.speedAtTime(init_time + duration);
            traj = Trajectories.Trajectory();
            traj.dim = 2;
            % TODO Generalize speed to 3d
            traj.data = {
                Trajectories.BezierTrajectory(duration, ...
                    init_pos(1), fin_pos(1), init_speed(1), fin_speed(1));
                Trajectories.BezierTrajectory(duration, ...
                    init_pos(2), fin_pos(2), init_speed(2), init_speed(2))
            };
            traj.duration = duration;
        end
    end
    
    methods
        function obj = Command(start_pose)
        %COMMAND initializes the command object
        %   OBJ = COMMAND(START_POS)
        %
        %   
        %   Arguments
        %
        %   START_POS = [1 x 1] Pose
        %       Where the robot starts.
            obj.body_pose = start_pose;
            
            % Initial Foot Positions
            obj.foot_pos = {Footsteps.Footstep(0, -0.04, 0, Footsteps.Foot.Left, 0),... 
            Footsteps.Footstep(0, 0.04, 0, Footsteps.Foot.Right, 0)}; % L, R
            
            % Initialize queues
            obj.actions = Trajectories.LiveQueue(Command.Action(...
                Command.ActionLabel.Forward,Pose(0,0,0,0,0),Pose(0,0,0,0,0),0));
            obj.footsteps = Trajectories.LiveQueue(Footsteps.Footstep(), false);
            obj.foot_traj_l = Trajectories.LiveQueue(Trajectories.FootCycle(...
                obj.actions, obj.foot_pos{1}, obj.foot_pos{2}, 0, 0, 0));
            obj.foot_traj_r = Trajectories.LiveQueue(Trajectories.FootCycle(...
                obj.actions, obj.foot_pos{1}, obj.foot_pos{2}, 0, 0, 0));
            obj.body_traj = Trajectories.LiveQueue(obj.buildBodyTraj(...
                0, obj.foot_pos{1}, obj.foot_pos{2}, 0));
            
            % Determines the initial joint angle of the robot
            %TODO should not depend on footstep position
            obj.cur_angles(1,3) = 1;
            obj.cur_angles(2,3) = 1;
            obj.cur_angles(1,:) = ikine(obj.dh, obj.foot_pos{1}.x, ...
                obj.foot_pos{1}.y, -obj.hip_height, 0, obj.cur_angles(1,:));
            obj.cur_angles(2,:) = ikine(obj.dh, obj.foot_pos{2}.x, ...
                obj.foot_pos{1}.y, -obj.hip_height, 0, obj.cur_angles(2,:));
        end
        
        function angles = next(obj)
        %NEXT produces the next set of joint angles
        %   ANGLES = NEXT(OBJ)
        %
        %   This is the main method for the COMMAND object. This method
        %   advances time forward and keeps track of all important changes
        %   that result from this. It then determines the current angles
        %   based on this.
        %
        %
        %   Outputs
        %
        %   Angles = [2 x 6]
        %       The 12 angles corresponding to the current desired angular
        %       position.
            obj.actions.next();
            footstep = obj.footsteps.next();
            %TODO Figure out how to remove if statement to reduce repistion
            if footstep.side == Footsteps.Foot.Left && ...
                    footstep ~= obj.foot_pos{1}
                % Build new trajectories for feet to reach next footstep
                obj.foot_traj_l.append(Trajectories.FootCycle( ...
                    obj.actions, obj.foot_pos{1}, footstep, ...
                    obj.step_height, obj.swing_time, footstep.duration ...
                ));
                obj.foot_traj_r.append(Trajectories.FootCycle( ...
                    obj.actions, obj.foot_pos{2}, obj.foot_pos{2}, ...
                    obj.step_height, 0, footstep.duration ...
                ));
                obj.body_traj.append(obj.buildBodyTraj( ...
                    0, obj.foot_pos{2}, ...
                    obj.foot_pos{2}, obj.swing_time ...
                ));
                obj.body_traj.append(obj.buildBodyTraj( ...
                    obj.swing_time, obj.foot_pos{2}, ...
                    footstep, obj.swing_time ...
                ));
                obj.foot_pos{1} = footstep;
            elseif footstep.side == Footsteps.Foot.Right && ...
                    footstep ~= obj.foot_pos{2}
                % Build new trajectories for feet to reach next footstep
                obj.foot_traj_l.append(Trajectories.FootCycle( ...
                    obj.actions, obj.foot_pos{1}, obj.foot_pos{1}, ...
                    obj.step_height, 0, footstep.duration ...
                ));
                obj.foot_traj_r.append(Trajectories.FootCycle( ...
                    obj.actions, obj.foot_pos{2}, footstep, ...
                    obj.step_height, obj.swing_time, footstep.duration ...
                ));
                obj.body_traj.append(obj.buildBodyTraj( ...
                    0, obj.foot_pos{1}, ...
                    obj.foot_pos{1}, obj.swing_time ...
                ));
                obj.body_traj.append(obj.buildBodyTraj( ...
                    obj.swing_time, obj.foot_pos{1}, ...
                    footstep, obj.swing_time ...
                ));
                obj.foot_pos{2} = footstep;
            end
            ftl = obj.foot_traj_l.next();
            ftr = obj.foot_traj_r.next();
            bp = obj.body_traj.next();
            obj.cur_angles(1,:) = ikine(obj.dh, ftl(1) - bp(1), -bp(2), ...
                ftl(2) - obj.hip_height, 0, obj.cur_angles(1,:) ...
            );
            obj.cur_angles(2,:) = ikine(obj.dh, ftr(1) - bp(1), -bp(2), ...
                ftr(2) - obj.hip_height, 0, obj.cur_angles(2,:) ...
            );
            angles = obj.cur_angles;
%             angles = [ftl, ftr, bp];
        end
        
        function append(obj, label, goal, duration)
        %APPEND adds a new action to the action queue
        %   APPEND(OBJ, LABEL, GOAL, DURATION)
        %
        %   Construct a new action based on the provided inputs and appends
        %   it to the queue. Also update other parameters as needed.
        %
        %
        %   Arguments
        %
        %   LABEL = [1 x 1] Command.ActionLabel
        %       The desired type of action.
        %
        %   GOAL = [1 x 1] Pose
        %       The desired final position
        %
        %   DURATION = [1 x 1]
        %       The desired duration of the action.
            if ~isempty(obj.actions)
                action = Command.Action( ...
                    label, obj.actions.data{obj.actions.length}.goal, ...
                    goal, duration ...
                );
            else
                action = Command.Action( ...
                    label, obj.body_pose, goal, duration ...
                );
            end
            obj.body_pose = goal;
            obj.actions.append(action);
            
            if ~isempty(obj.footsteps)
                [new_footsteps, n_steps] = Footsteps.generateFootsteps(...
                    action, obj.cycle_time/2, ...
                    obj.footsteps.data{obj.footsteps.length}, ...
                    obj.footsteps.data{obj.footsteps.length - 1}, ...
                    obj.hip_width ...
                );
            else
                [new_footsteps, n_steps] = Footsteps.generateFootsteps(...
                    action, obj.cycle_time/2, ...
                    obj.foot_pos{1}, obj.foot_pos{2}, obj.hip_width ...
                );
            end
            %TODO MAJOR FIX associated with generate footsteps
            for i = 3:(n_steps + 2)
                obj.footsteps.append(new_footsteps{i});
            end
        end
    end
    
end

