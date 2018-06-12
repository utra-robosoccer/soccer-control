function [footsteps, n_steps] = generateFootsteps(obj, action, step_duration, next_foot, cur_foot, step_width)
%GENERATEFOOTSTEPS produces footsteps along a body path, Following very out
%of date
%   [FOOTSTEPS, N_STEPS] = GENERATEFOOTSTEPS(PATH, NEXT_FOOT, CUR_FOOT)
%
%   Produces a list of foot steps to travel along the body path
%   provided, starting with the feet given
%
%
%   Arguments
%
%   PATH = Trajectory
%       The idealized path the the body should travel along
%
%   NEXT_FOOT, CUR_FOOT = FootStep
%       The footstep corresponding to the next swing foot and the
%       next stance foot, respectively.
%
%
%   Outputs
%
%   FOOTSTEPS = [N x 1] Footstep
%       The footsteps that the robot should follow
%
%   N_STEPS = [1 x 1]
%       Number of calculated steps

%TODO: Major Cleanup and port to Footstep (Command?). Generate one at a time option?
% should be based around trajectory at point, with offset

    n_steps = ceil(action.path.data{1}.duration/step_duration);
    footsteps = {
        Footsteps.Footstep(0,0,0,Footsteps.Foot.Left,0); Footsteps.Footstep(0,0,0,Footsteps.Foot.Left,0); Footsteps.Footstep(0,0,0,Footsteps.Foot.Left,0);
        Footsteps.Footstep(0,0,0,Footsteps.Foot.Left,0); Footsteps.Footstep(0,0,0,Footsteps.Foot.Left,0); Footsteps.Footstep(0,0,0,Footsteps.Foot.Left,0);
        Footsteps.Footstep(0,0,0,Footsteps.Foot.Left,0); Footsteps.Footstep(0,0,0,Footsteps.Foot.Left,0); Footsteps.Footstep(0,0,0,Footsteps.Foot.Left,0);
        Footsteps.Footstep(0,0,0,Footsteps.Foot.Left,0); Footsteps.Footstep(0,0,0,Footsteps.Foot.Left,0); Footsteps.Footstep(0,0,0,Footsteps.Foot.Left,0);
        Footsteps.Footstep(0,0,0,Footsteps.Foot.Left,0); Footsteps.Footstep(0,0,0,Footsteps.Foot.Left,0); Footsteps.Footstep(0,0,0,Footsteps.Foot.Left,0);
        Footsteps.Footstep(0,0,0,Footsteps.Foot.Left,0); Footsteps.Footstep(0,0,0,Footsteps.Foot.Left,0); Footsteps.Footstep(0,0,0,Footsteps.Foot.Left,0);
    };
    footsteps{1} = cur_foot; footsteps{2} = next_foot;
    if action.label == Command.ActionLabel.Forward || ...
            action.label == Command.ActionLabel.Backward
        for i = 1:n_steps
            x_m = action.path.data{1}.positionAtTime(i*step_duration);
            y_m = action.path.data{2}.positionAtTime(i*step_duration);
            x_m1 = action.path.data{1}.positionAtTime(i*step_duration + action.path.data{1}.secant_size);
            y_m1 = action.path.data{2}.positionAtTime(i*step_duration + action.path.data{2}.secant_size);

            delta_x = x_m1 - x_m;
            delta_y = y_m1 - y_m;

            %Find normal, and flip the direction depending on step side
            normalv = [-delta_y, delta_x];
            next_side = footsteps{i}.side;
            if xor(next_side == Footsteps.Foot.Left, ...
                    action.label == Command.ActionLabel.Backward)
                normalv = -normalv;
            end

            %Find position of next footstep based on normal and d
            next_step = [x_m y_m] - normalv/norm(normalv) * step_width;
            %Angle q of the nextfootstep
            next_q = atan2(delta_y, delta_x);
            if action.label == Command.ActionLabel.Backward
                next_q = mod(next_q + pi, 2 * pi);
            end
            
            % Create the footstep
            footsteps{i+2}.x = next_step(1);
            footsteps{i+2}.y = next_step(2);
            footsteps{i+2}.q = next_q;
            footsteps{i+2}.side = next_side;
            footsteps{i+2}.duration = step_duration;
        end
    elseif action.label == Command.ActionLabel.Strafe
        % Find how much turn is needed
        init_pose = action.path.positionAtTime(0);
        fin_pose = action.path.positionAtTime(action.duration);
        dq = getTurnSpeed(init_pose, fin_pose, n_steps);
        for i = 1:n_steps
            % Body position
            x_m = action.path.data{1}.positionAtTime(i*step_duration);
            y_m = action.path.data{2}.positionAtTime(i*step_duration);
            next_q = init_pose.q  + dq * i;
            
            % Calculate the footposition (offset)
            normalv = [-sin(next_q) cos(next_q)];
            next_side = footsteps{i}.side;
            if next_side == Footsteps.Foot.Left
                normalv = -normalv;
            end
            next_step = [x_m y_m] - normalv/norm(normalv) * step_width;
            
            % Create the footsteps
            footsteps{i+2}.x = next_step(1);
            footsteps{i+2}.y = next_step(2);
            footsteps{i+2}.q = next_q;
            footsteps{i+2}.side = next_side;
            footsteps{i+2}.duration = step_duration;
        end
    elseif action.label == Command.ActionLabel.Turn
        % Find how much turn is needed
        init_pose = action.path.positionAtTime(0);
        fin_pose = action.path.positionAtTime(action.duration);
        dq = getTurnSpeed(init_pose, fin_pose, n_steps);
        
        for i = 1:n_steps
            % Body position
            next_q = init_pose.q  + dq * i;
            
            % Calculate the footposition (offset)
            normalv = [-sin(next_q) cos(next_q)];
            next_side = footsteps{i}.side;
            if next_side == Footsteps.Foot.Left
                normalv = -normalv;
            end
            next_step = [init_pose.x init_pose.y] - normalv/norm(normalv) * step_width;
            
            % Create the footsteps
            footsteps{i+2}.x = next_step(1);
            footsteps{i+2}.y = next_step(2);
            footsteps{i+2}.q = next_q;
            footsteps{i+2}.side = next_side;
            footsteps{i+2}.duration = step_duration;
        end
    else
        n_steps = ceil(action.path.data{1}.duration/obj.swing_time);
        for i = 1:n_steps
            footsteps{i+2}.x = footsteps{i}.x;
            footsteps{i+2}.y = footsteps{i}.y;
            footsteps{i+2}.q = footsteps{i}.q;
            footsteps{i+2}.side = footsteps{i}.side;
            footsteps{i+2}.duration = obj.swing_time;
        end
    end
end

function dq = getTurnSpeed(init_pose, fin_pose, n_steps)
    if mod(fin_pose.q - init_pose.q, 2*pi) > mod(init_pose.q - fin_pose.q, 2*pi)
        dq = (fin_pose.q - init_pose.q) / n_steps;
    else
        dq = (init_pose.q - fin_pose.q) / n_steps;
    end
end