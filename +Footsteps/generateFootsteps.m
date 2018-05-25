function [footsteps, n_steps] = generateFootsteps(path, airtime, next_foot, cur_foot, step_width)
%GENERATEFOOTSTEPS produces footsteps along a body path
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

%TODO: Major Cleanup and port to Footstep. Generate one at a time option?
% should be based around trajectory at point, with offset

    n_steps = ceil(path.data{1}.duration/airtime);
    footsteps = {
        Footsteps.Footstep(0,0,0,Footsteps.Foot.Left,0); Footsteps.Footstep(0,0,0,Footsteps.Foot.Left,0); Footsteps.Footstep(0,0,0,Footsteps.Foot.Left,0);
        Footsteps.Footstep(0,0,0,Footsteps.Foot.Left,0); Footsteps.Footstep(0,0,0,Footsteps.Foot.Left,0); Footsteps.Footstep(0,0,0,Footsteps.Foot.Left,0);
        Footsteps.Footstep(0,0,0,Footsteps.Foot.Left,0); Footsteps.Footstep(0,0,0,Footsteps.Foot.Left,0); Footsteps.Footstep(0,0,0,Footsteps.Foot.Left,0);
        Footsteps.Footstep(0,0,0,Footsteps.Foot.Left,0); Footsteps.Footstep(0,0,0,Footsteps.Foot.Left,0); Footsteps.Footstep(0,0,0,Footsteps.Foot.Left,0);
    };
    footsteps{1} = cur_foot; footsteps{2} = next_foot;

    for i = 1:n_steps
        x_m = path.data{1}.positionAtTime((i+0.5)*airtime);
        y_m = path.data{2}.positionAtTime((i+0.5)*airtime);
        x_m1 = path.data{1}.positionAtTime((i+0.5)*airtime + path.data{1}.secant_size);
        y_m1 = path.data{2}.positionAtTime((i+0.5)*airtime + path.data{2}.secant_size);
        x_m2 = path.data{1}.positionAtTime((i+0.5)*airtime + 2*path.data{1}.secant_size);
        y_m2 = path.data{2}.positionAtTime((i+0.5)*airtime + 2*path.data{2}.secant_size);

        delta_x = x_m1 - x_m;
        delta_y = y_m1 - y_m;

        %finding curvature
        dydx = delta_y/delta_x;
        dydx_inc = (y_m2 - y_m1)/(x_m2 - x_m1);
        ddydxx = (dydx_inc - dydx)/(x_m1 - x_m);
        curv = abs(ddydxx/(1+dydx^2)^(3/2));

        %d is required distance from path the next foot must be
        %a, b, and c can be changed, make d a function of curvature.
        a = -step_width;                                     
        b = 0.0;
        c = 0;
        d = a + b*curv + c*curv^2; 

        %Find normal, and flip the direction depending on step side
        if delta_x > 0
            normalv = [-delta_y, delta_x];
        else
            normalv = [delta_y, -delta_x];
        end
        next_side = footsteps{i}.side;
        if next_side == Footsteps.Foot.Right
            normalv = -normalv;
        end

        %Find position of next footstep based on normal and d
        next_step = [x_m y_m] + normalv/norm(normalv) * d;
        %Angle q of the nextfootstep
        next_q = atan2(delta_y, delta_x);

        footsteps{i+2}.x = next_step(1);
        footsteps{i+2}.y = next_step(2);
        footsteps{i+2}.q = next_q;
        footsteps{i+2}.side = next_side;
        footsteps{i+2}.duration = airtime;
        if isnan(footsteps{i+2}.x)
            footsteps{i+2}.x = 0;
        end
    end
end