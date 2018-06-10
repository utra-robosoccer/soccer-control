%% Initialization Parameters
dh = [
            0.0250     -pi/2         0      pi/2
                 0      pi/2         0     -pi/2
                 0         0    0.0890         0
                 0         0    0.0825         0
                 0         0         0      pi/2
                 0         0    0.0370         0
        ];
body_height = 0.099 + 0.16;

%% Generate Angles
start_pose = Pose(0, 0, 0, 0, 0.0);
mid1_pose = Pose(0.1, 0, 0, 0, 0.04);
top_pose = Pose(0.4, 0.2, 0, 0, 0.04);
bot_pose = Pose(0.4, -0.2, 0, -pi, 0.04);
mid2_pose = Pose(0.1, 0, 0, -pi, 0.04);
end_pose = Pose(0, 0, 0, 0, 0.0);
command = Command.Command(start_pose);
q0_left = command.cur_angles(1,:);
q0_right = command.cur_angles(2,:);
command.append(Command.ActionLabel.Forward, mid1_pose, 2);
command.append(Command.ActionLabel.Strafe, top_pose, 5);
command.append(Command.ActionLabel.Forward, bot_pose, 7);
command.append(Command.ActionLabel.Forward, mid2_pose, 5);
command.append(Command.ActionLabel.Turn, end_pose, 2);
angles = zeros(12, 2100);
for i = 1:2100
    cn = command.next();
    angles(:, i) = [cn(1, :), cn(2, :)]';
end
plot((1:2100), angles);

%% Simulate based on these angles
load_system('biped_robot');
in = Simulink.SimulationInput('biped_robot');
in = in.setModelParameter('StartTime', '0', 'StopTime', num2str(22));
in = in.setModelParameter('SimulationMode', 'Normal');

angles_ts = timeseries(angles, (0:2099)*0.01);

in = in.setVariable('dh', dh, 'Workspace', 'biped_robot');
in = in.setVariable('q0_left', q0_left, 'Workspace', 'biped_robot');
in = in.setVariable('q0_right', q0_right, 'Workspace', 'biped_robot');
in = in.setVariable('angles', angles_ts, 'Workspace', 'biped_robot');
in = in.setVariable('init_body_height', body_height, 'Workspace', 'biped_robot');
in = in.setVariable('init_angle', start_pose.q, 'Workspace', 'biped_robot');

out = sim(in);
