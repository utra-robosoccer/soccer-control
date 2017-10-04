step_length = 15;
step_height = 2;
speed = 15;
swing_prop = 0.25;
update_interval = 0.001;
body_height = 19;
num_steps = 6;
a = [8.9 8.25 8.06];

stride_duration = round(step_length / speed / (1-swing_prop), 3);
t_swing = 0:update_interval:round(swing_prop*stride_duration, 3)-update_interval;
t_stance = 0:update_interval:round((1-swing_prop)*stride_duration, 3)-update_interval;

bez_y_sw = new_bezier_order4(0, 0, 0, 0, step_height, t_swing);
bez_x_sw = new_bezier_order4(-step_length/2, step_length/2, -speed, -speed, 0, t_swing);
bez_y_st = new_bezier_order4(0, 0, 0, 0, 0, t_stance);
bez_x_st = new_bezier_order4(step_length/2, -step_length/2, -speed, -speed, 0, t_stance);
left_traj_x = [bez_x_st(floor(end/2)+1:end) bez_x_sw bez_x_st(1:floor(end/2))];
left_traj_y = [bez_y_st(floor(end/2)+1:end) bez_y_sw bez_y_st(1:floor(end/2))] - body_height;
right_traj_x = [bez_x_sw(floor(end/2)+1:end) bez_x_st bez_x_sw(1:floor(end/2))];
right_traj_y = [bez_y_sw(floor(end/2)+1:end) bez_y_st bez_y_sw(1:floor(end/2))] - body_height;
psi_traj = ones(1, length(left_traj_x))*-pi/2;

start_l = length(bez_x_st(floor(end/2)+1:end));
end_l = length(left_traj_x) - length(bez_x_st(1:floor(end/2)));
start_r = length(right_traj_x) - length(bez_x_sw(1:floor(end/2)));
end_r = length(bez_x_sw(floor(end/2)+1:end));
body_x = [left_traj_x(1:end_r) ...
    linspace(left_traj_x(end_r+1), right_traj_x(start_l), start_l-end_r) ...
    right_traj_x(start_l+1:end_l) ...
    linspace(right_traj_x(end_l+1), left_traj_x(start_r), start_r-end_l) ...
    left_traj_x(start_r+1:end)];
body_x = smooth(body_x, 250)';
left_traj_x = left_traj_x-body_x;
right_traj_x = right_traj_x-body_x;

q_left = ikine(dh, left_traj_x, left_traj_y, psi_traj, [0 0 0]);
q0_left = q_left(:,2);
q_left(:,1) = q0_left;
dh_left = zeros(3, 4);
dh_left(:,2) = q0_left;
dh_left(:,3) = a';

q_right = ikine(dh, right_traj_x, right_traj_y, psi_traj, [0 0 0]);
q0_right = q_right(:,2);
q_right(:,1) = q0_right;
dh_right = zeros(3, 4);
dh_right(:,2) = q0_right;
dh_right(:,3) = a;

q_left = repmat(q_left, [1 num_steps]);
q_right = repmat(q_right, [1 num_steps]);
q_l_ts = timeseries(q_left', 0:0.001:num_steps*stride_duration-update_interval);
q_r_ts = timeseries(q_right', 0:0.001:num_steps*stride_duration-update_interval);