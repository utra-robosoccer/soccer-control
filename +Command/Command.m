classdef Command < handle
    %COMMAND Control of the entire robot movement
    
    properties
        % High-level actions and idealized path
        actions = Trajectories.LiveQueue(Command.Action.empty());
        
        % Body physical parameters
        hip_height = 0.16;
        hip_width = 0.04;
        
        % Movement timing parameters
        swing_time = 0.5;
        stance_time = 1.5;
        cycle_time = 2;
        hold_time = 0.0; % TODO implement
        
        % Movement physical parameters
        step_height = 0.05;
        angles = zeros(2,6);
        %%% TODO separate into left and right, fix timing
        footsteps = Trajectories.LiveQueue(Footsteps.Footstep.empty());
        foot_pos = [Footsteps.Footstep(0, -0.04, 0, Footsteps.Foot.Left, 0),... 
            Footsteps.Footstep(0, 0.04, 0, Footsteps.Foot.Right, 0)]; % L, R
        %%%
        body_pose = Pose(0, -0.0, 0, 0, 0);
        cur_angles = zeros(2,6);
        
        % Trajectories
        foot_traj_l
        foot_traj_r
        body_traj
        
        dh = [
            0.0250     -pi/2         0      pi/2
                 0      pi/2         0     -pi/2
                 0         0    0.0890         0
                 0         0    0.0825         0
                 0         0         0      pi/2
                 0         0    0.0370         0
        ];
        
    end
    
    methods (Hidden)
        function traj = buildBodyTraj(obj, init_time, ...
                init_step, fin_step, duration)
            % Build body trajectory between footsteps
            init_pos = [init_step.x init_step.y] - ...
                obj.actions.positionAtTime(init_time);
            fin_pos = [fin_step.x fin_step.y] - ...
                obj.actions.positionAtTime(init_time + duration);
            init_speed = -obj.actions.speedAtTime(init_time);
            fin_speed = -obj.actions.speedAtTime(init_time + duration);
            traj = Trajectories.Trajectory();
            traj.dim = 2;
            traj.data = Trajectories.BezierTrajectory.empty();
            % TODO Generalize speed to 3d
            traj.data(1) = Trajectories.BezierTrajectory(duration, ...
                init_pos(1), fin_pos(1), init_speed(1), fin_speed(1));
            traj.data(2) = Trajectories.BezierTrajectory(duration, ...
                init_pos(2), fin_pos(2), init_speed(2), init_speed(2));
            traj.duration = duration;
        end
    end
    
    methods
        function obj = Command(start_pose)
            obj.body_pose = start_pose;
            
            % Initialize queues
            obj.actions = Trajectories.LiveQueue(Command.Action.empty());
            obj.footsteps = Trajectories.LiveQueue(...
                Footsteps.Footstep.empty(), false);
            obj.foot_traj_l = Trajectories.LiveQueue(...
                Trajectories.FootCycle.empty());
            obj.foot_traj_r = Trajectories.LiveQueue(...
                Trajectories.FootCycle.empty());
            obj.body_traj = Trajectories.LiveQueue(...
                Trajectories.Trajectory.empty());
            
            % Determines the initial joint angle of the robot
            %TODO should not depend on footstep position
            obj.cur_angles(1,3) = 1;
            obj.cur_angles(2,3) = 1;
            obj.cur_angles(1,:) = ikine(obj.dh, obj.foot_pos(1).x, ...
                obj.foot_pos(1).y, -obj.hip_height, 0, obj.cur_angles(1,:));
            obj.cur_angles(2,:) = ikine(obj.dh, obj.foot_pos(2).x, ...
                obj.foot_pos(1).y, -obj.hip_height, 0, obj.cur_angles(2,:));
        end
        
        function angles = next(obj)
            obj.actions.next();
            footstep = obj.footsteps.next();
            if footstep.side == Footsteps.Foot.Left && ...
                    footstep ~= obj.foot_pos(1)
                % Build new trajectories for feet to reach next footstep
                obj.foot_traj_l.append(Trajectories.FootCycle( ...
                    obj.actions, obj.foot_pos(1), footstep, ...
                    obj.step_height, obj.swing_time, footstep.duration ...
                ));
                obj.foot_traj_r.append(Trajectories.FootCycle( ...
                    obj.actions, obj.foot_pos(2), obj.foot_pos(2), ...
                    obj.step_height, 0, footstep.duration ...
                ));
                obj.body_traj.append(obj.buildBodyTraj( ...
                    0, obj.foot_pos(2), ...
                    obj.foot_pos(2), obj.swing_time ...
                ));
                obj.body_traj.append(obj.buildBodyTraj( ...
                    obj.swing_time, obj.foot_pos(2), ...
                    footstep, obj.swing_time ...
                ));
                obj.foot_pos(1) = footstep;
            elseif footstep.side == Footsteps.Foot.Right && ...
                    footstep ~= obj.foot_pos(2)
                % Build new trajectories for feet to reach next footstep
                obj.foot_traj_l.append(Trajectories.FootCycle( ...
                    obj.actions, obj.foot_pos(1), obj.foot_pos(1), ...
                    obj.step_height, 0, footstep.duration ...
                ));
                obj.foot_traj_r.append(Trajectories.FootCycle( ...
                    obj.actions, obj.foot_pos(2), footstep, ...
                    obj.step_height, obj.swing_time, footstep.duration ...
                ));
                obj.body_traj.append(obj.buildBodyTraj( ...
                    0, obj.foot_pos(1), ...
                    obj.foot_pos(1), obj.swing_time ...
                ));
                obj.body_traj.append(obj.buildBodyTraj( ...
                    obj.swing_time, obj.foot_pos(1), ...
                    footstep, obj.swing_time ...
                ));
                obj.foot_pos(2) = footstep;
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
            if ~isempty(obj.actions)
                action = Command.Action( ...
                    label, obj.actions.data(obj.actions.end).goal, ...
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
                new_footsteps = Footsteps.generateFootsteps(...
                    action.path, obj.cycle_time/2, ...
                    obj.footsteps(obj.footsteps.end), ...
                    obj.footsteps(obj.footsteps.end-1)...
                );
            else
                new_footsteps = Footsteps.generateFootsteps(...
                    action.path, obj.cycle_time/2, ...
                    obj.foot_pos(1), obj.foot_pos(2)...
                );
            end
            for footstep = reshape(new_footsteps(3:end), 1, [])
                obj.footsteps.append(footstep);
            end
        end
    end
    
end

