classdef Footstep < Pose
    %FOOTSTEP defines the position and orientation of a footstep
    
    properties
        side = Foot.Left;
        time = 0;
    end
    
    methods
        function obj = Footstep(x, y, q, side, time)
            if nargin == 0
                x = 0; y = 0; q = 0; side = Foot.Left; time = 0;
            end
            obj@Pose(x, y, 0, q, 0);
            obj.side = side;
            obj.time = time;
        end
    end
    
    methods(Static)
        function footsteps = generateFootsteps(path, next_foot, cur_foot)
            airtime = 0.5;
            n_steps = path.x.duration/airtime;
            footsteps = repmat(Footstep(), ceil(n_steps)+2, 1);
            footsteps(1:2) = [cur_foot, next_foot];

            for i = 1:floor(n_steps)
                x_m = path.x.positionAtTime((i+0.5)*airtime);
                y_m = path.y.positionAtTime((i+0.5)*airtime);
                x_m1 = path.x.positionAtTime((i+0.5)*airtime + path.x.secant_size);
                y_m1 = path.y.positionAtTime((i+0.5)*airtime + path.y.secant_size);
                x_m2 = path.x.positionAtTime((i+0.5)*airtime + 2*path.x.secant_size);
                y_m2 = path.y.positionAtTime((i+0.5)*airtime + 2*path.y.secant_size);

                delta_x = x_m1 - x_m;
                delta_y = y_m1 - y_m;

                %finding curvature
                dydx = delta_y/delta_x;
                dydx_inc = (y_m2 - y_m1)/(x_m2 - x_m1);
                ddydxx = (dydx_inc - dydx)/(x_m1 - x_m);
                curv = abs(ddydxx/(1+dydx^2)^(3/2));

                %d is required distance from path the next foot must be
                %a, b, and c can be changed, make d a function of curvature.
                a = 0.1;                                     
                b = 0.01;
                c = 0;
                d = a + b*curv + c*curv^2; 

                %Find normal, and flip the direction depending on step side
                normalv = [-delta_y, delta_x];
                next_side = footsteps(i).side;
                if next_side == Foot.Right
                    normalv = -normalv;
                end

                %Find position of next footstep based on normal and d
                next_step = [x_m, y_m] + normalv/norm(normalv)*d;
                %Angle q of the nextfootstep
                next_q = atan2(delta_y, delta_x);

                footsteps(i+2) = Footstep(next_step(1), next_step(2), next_q, next_side, airtime*i);

            end
        end
    end
end