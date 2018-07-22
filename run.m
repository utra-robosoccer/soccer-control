function angles = run(poseActions)
    command = Command.Command(poseActions{1}.Pose);
    
    [l,~] = size(poseActions);
    totalDuration = 0;
    for i = 1:l
        p = poseActions{i};
        command.append(p.ActionLabel, p.Pose, p.Duration);
        totalDuration = totalDuration + p.Duration;
    end
    
    angles = zeros(12, totalDuration * 200);
    for i = 1:(totalDuration * 200)
        cn = command.next();
        angles(:, i) = [cn(1, :), cn(2, :)]';
    end
    plot((1:totalDuration), angles);
end
