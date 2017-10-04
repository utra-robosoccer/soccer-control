function q_traj = ikine(dh, x3_traj, z3_traj, psi3_traj, q0)
% Function: q_traj = invkin(dh, x3_traj, z3_traj, psi3_traj, q0)
% 
% Description: Generates the joint angle trajectories from the given end
% effector trajectories and initial state information
%
% Parameters:
%   dh : The Denavit-Hartenburg matrix for the leg
%   x3_traj : The x-coordinate in the frame {0} over time
%   z3_traj : The z-coordinate in the frame {0} over time
%   psi3_traj : The orientation of the last link in the frame {0} over time
%   q0 : The initial angle of the joints at AEP
% 
% Return:
%   q_traj : The joint angles of the leg's trajectory
%
%   TODO: Change title block format to match others

    % lengths of joints and simulation runtime
    l1 = dh(1, 3); l2 = dh(2, 3); l3 = dh(3, 3);
    steps = length(x3_traj);
    
    % set up initial conditions
    q_traj = zeros(3, steps);
    q_traj(:, 1) = q0;
    
    for i = 2:steps
        xi = x3_traj(i); zi = z3_traj(i); psii = psi3_traj(i);
        % find the position of the ankle
        x2 = xi - l3*cos(psii);
        z2 = zi - l3*sin(psii);
        dist0_2 = norm([x2 z2]);
        % is this position possible
        if (dist0_2 < l1 - l2 || dist0_2 > l1 + l2)
            q_traj = [];
            break
        end
        % use cosine  law to solve angles of triangle
        C1 = (l1^2 + dist0_2^2 - l2^2)/(2*l1*dist0_2);
        t1 = atan2(sqrt(1 - C1^2), C1);
        C2 = (l1^2 + l2^2 - dist0_2^2)/(2*l1*l2);
        t2 = atan2(sqrt(1 - C2^2), C2);
        t3 = pi - t1 - t2;
        
        % construct the two possible q from data available
        ang0_2 = atan2(z2, x2);
        q_a = [ ang0_2 - t1; pi - t2; psii - t3 - ang0_2 ];
        q_b = [ ang0_2 + t1; t2 - pi; psii + t3 - ang0_2 ];
        
        % choose the option closest to the previous answer
        if (norm(q_a - q_traj(:, i-1)) < norm(q_b - q_traj(:, i-1)))
            q_traj(:, i) = q_a;
        else
            q_traj(:, i) = q_b;
        end
    end
    
end