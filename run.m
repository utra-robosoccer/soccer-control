function angles = run(poseActions)
    command = Command.Command(poseActions{1}.Pose);
    
    l = length(poseActions);
    totalDuration = 0;
    for i = 1:l
        p = poseActions{i};
        command.append(p.ActionLabel, p.Pose, p.Duration);
        totalDuration = totalDuration + p.Duration;
    end
    totalSteps = int16(totalDuration * 100) + 100; % 1 second to rebalance itself
    
    angles = zeros(12, totalSteps);
    for i = 1:(totalSteps)
        cn = command.next();
        angles(:, i) = [cn(1, :), cn(2, :)]';
    end
    plot((1:totalSteps), angles);
end
