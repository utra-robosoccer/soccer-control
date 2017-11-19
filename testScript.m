step_height = 0.02;
swing_prop = 0.25;
airtime = 0.5;
update_interval = 0.01;
hip_height = 0.18;
init_body_height = hip_height + 0.105;
duration = 10;
smoothing = 0.25;
a = [0.089 0.08253 0.037];

% Define path
start = Pose(0, 0, 0, 0);
final = Pose(1, 0, 0, 0);
body_traj = Trajectory.plannedPath(duration, start, final).x;
stepl = Footstep(0, Foot.Left, 0);
stepr = Footstep(0, Foot.Right, 0);

% Make footsteps
footsteps = Footstep.generateFootsteps(body_traj, stepl, stepr);
left_steps = footsteps([footsteps.side] == Foot.Left);
right_steps = footsteps([footsteps.side] == Foot.Right);

n = floor(duration/update_interval)+1;
psi_traj = ones(n,1)*-pi/2;
left_toe.x = zeros(n,1);
left_toe.y = zeros(n,1);
right_toe.x = zeros(n,1);
right_toe.y = zeros(n,1);
body_x = zeros(n,1);

% Toe trajectories for left leg
next_time = 0;
cur_time = 0;
end_x = 0;

for i = 1:length(left_steps)
    % Stance trajectories
    start_x = left_steps(i).x - body_traj.positionAtTime(cur_time);
    end_x = left_steps(i).x - body_traj.positionAtTime(next_time);
    start_vx = -body_traj.speedAtTime(cur_time);
    end_vx = -body_traj.speedAtTime(next_time);
    x = BezierTrajectory(next_time-cur_time, start_x, end_x, start_vx, end_vx);
    left_toe.x(floor(cur_time/update_interval)+1:floor(next_time/update_interval)+1) = ...
        x.positionAtTime(0:update_interval:next_time-cur_time);
    cur_time = next_time;
    next_time = next_time + swing_prop;
    
    if i == length(left_steps)
        break
    end
    
    % Swing trajectories
    start_x = left_steps(i).x - body_traj.positionAtTime(cur_time);
    end_x = left_steps(i+1).x - body_traj.positionAtTime(next_time);
    start_vx = -body_traj.speedAtTime(cur_time);
    end_vx = -body_traj.speedAtTime(next_time);
    x = BezierTrajectory(next_time-cur_time, start_x, end_x, start_vx, end_vx);
    y = BezierTrajectory(next_time-cur_time, 0, 0, 0, 0, step_height);
    left_toe.x(floor(cur_time/update_interval)+1:floor(next_time/update_interval)+1) = ...
        x.positionAtTime(0:update_interval:next_time-cur_time);
    left_toe.y(floor(cur_time/update_interval)+1:floor(next_time/update_interval)+1) = ...
        y.positionAtTime(0:update_interval:next_time-cur_time);
    cur_time = next_time;
    next_time = next_time + (1 - swing_prop);
end
left_toe.x = left_toe.x(1:n);
left_toe.y = left_toe.y(1:n);

% Toe trajectories for right leg
next_time = 0.5;
cur_time = 0;
ens_x = 0;

for i = 1:length(right_steps)
    % Stance trajectories
    start_x = right_steps(i).x - body_traj.positionAtTime(cur_time);
    end_x = right_steps(i).x - body_traj.positionAtTime(next_time);
    start_vx = -body_traj.speedAtTime(cur_time);
    end_vx = -body_traj.speedAtTime(next_time);
    x = BezierTrajectory(next_time-cur_time, start_x, end_x, start_vx, end_vx);
    right_toe.x(floor(cur_time/update_interval)+1:floor(next_time/update_interval)+1) = ...
        x.positionAtTime(0:update_interval:next_time-cur_time);
    cur_time = next_time;
    next_time = next_time + swing_prop;
    
    if i == length(right_steps)
        break
    end
    
    % Swing trajectories
    start_x = right_steps(i).x - body_traj.positionAtTime(cur_time);
    end_x = right_steps(i+1).x - body_traj.positionAtTime(next_time);
    start_vx = -body_traj.speedAtTime(cur_time);
    end_vx = -body_traj.speedAtTime(next_time);
    x = BezierTrajectory(next_time-cur_time, start_x, end_x, start_vx, end_vx);
    y = BezierTrajectory(next_time-cur_time, 0, 0, 0, 0, step_height);
    right_toe.x(floor(cur_time/update_interval)+1:floor(next_time/update_interval)+1) = ...
        x.positionAtTime(0:update_interval:next_time-cur_time);
    right_toe.y(floor(cur_time/update_interval)+1:floor(next_time/update_interval)+1) = ...
        y.positionAtTime(0:update_interval:next_time-cur_time);
    cur_time = next_time;
    next_time = next_time + (1 - swing_prop);
end
right_toe.x = right_toe.x(1:n);
right_toe.y = right_toe.y(1:n);

for i = 1:length(footsteps)-2
    cur_index = floor((i-1)*airtime/update_interval) + 1;
    next_index = cur_index + floor(swing_prop/update_interval);
    if mod(i, 2) == 1
        body_x(cur_index:next_index) = right_toe.x(cur_index:next_index);
    else
        body_x(cur_index:next_index) = left_toe.x(cur_index:next_index);
    end
end
for i = 1:length(footsteps)-2
    cur_index = floor((i-1)*airtime/update_interval) + floor(swing_prop/update_interval) + 1;
    next_index = cur_index + floor(swing_prop/update_interval);
    body_x(cur_index:next_index) = linspace(body_x(cur_index), body_x(next_index), length(cur_index:next_index));
end
body_x = smooth(body_x, smoothing/update_interval)';
left_toe.x = left_toe.x - body_x';
right_toe.x = right_toe.x - body_x';
left_toe.y = left_toe.y - hip_height;
right_toe.y = right_toe.y - hip_height;

dh_left = zeros(3, 4);
dh_left(:,3) = a';
q_left = ikine(dh_left, left_toe.x, left_toe.y, psi_traj, [0 0 0]);
q0_left = q_left(:,2);
q_left(:,1) = q0_left;
dh_left(:,2) = q0_left;

dh_right = zeros(3, 4);
dh_right(:,3) = a';
q_right = ikine(dh_right, right_toe.x, right_toe.y, psi_traj, [0 0 0]);
q0_right = q_right(:,2);
q_right(:,1) = q0_right;
dh_right(:,2) = q0_right;

q_l_ts = timeseries(q_left', 0:update_interval:body_traj.duration);
q_r_ts = timeseries(q_right', 0:update_interval:body_traj.duration);

sim biped_robot.slx StartTime 0 StopTime duration