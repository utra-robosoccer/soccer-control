classdef (Abstract) GeneralizedTrajectory < handle
    %GENERALIZEDTRAJECTORY Abstract representation of a trajectory
    %   Detailed explanation goes here
    
    methods
        pos = positionAtTime(obj, t)
        speed = speedAtTime(obj, t)
    end
    
end

