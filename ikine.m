function q = ikine(dh, x3, z3, psi3, q0)
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
    l1 = dh(3, 3); l2 = dh(4, 3); l3 = dh(6, 3);
    
        % find the position of the ankle
    x2 = x3 - l3*cos(psi3);
    z2 = z3 - l3*sin(psi3);
    dist0_2 = norm([x2 z2]);
    % is this position possible
    if (dist0_2 < l1 - l2 || dist0_2 > l1 + l2)
        q = [];
        return
    end
    % use cosine  law to solve angles of triangle
    C1 = (l1^2 + dist0_2^2 - l2^2)/(2*l1*dist0_2);
    t1 = atan2(sqrt(1 - C1^2), C1);
    C2 = (l1^2 + l2^2 - dist0_2^2)/(2*l1*l2);
    t2 = atan2(sqrt(1 - C2^2), C2);
    t3 = pi - t1 - t2;

    % construct the two possible q from data available
    ang0_2 = atan2(z2, x2) + pi/2;
    q_a = [ ang0_2 + t1; t2 - pi; -ang0_2 + t3];
    q_b = [ ang0_2 - t1; pi - t2; -ang0_2 - t3];

    % choose the option closest to the previous answer
    if norm(q_a - q0') < norm(q_b - q0)
        q = q_a;
    else
        q = q_b;
    end
    
end