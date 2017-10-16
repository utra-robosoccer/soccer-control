classdef BezierTrajectory < handle
    %BEZIERTRAJECTORY Defines a general purpose 1D bezier trajectory
    
    properties
        order = 0;
        parameters = [];
        duration = 1.0;
        increment = 0.01;
        cur_time = 0.0;
    end
    
    methods
        function obj = BezierTrajectory(duration, varargin)
            %BEZIERTRAJECTORY creates a bezier trajectory between points
            %
            %    OBJ = BEZIERTRAJECTORY(DURATION, INI_POS, FIN_POS, INI_VEL, FIN_VEL)
            %    OBJ = BEZIERTRAJECTORY(DURATION, INI_POS, FIN_POS, INI_VEL, FIN_VEL, HEIGHT)
            if nargin > 0
                obj.order = nargin - 2;
                obj.duration = duration;
                if obj.order == 3
                    obj.parameters = [varargin{1}, ...
                        3*varargin{1} + varargin{3}*duration, ...
                        3*varargin{2} - varargin{4}*duration, ...
                        varargin{2}];
                elseif obj.order == 4
                    obj.parameters = [varargin{1}, ...
                        4*varargin{1} + varargin{3}*duration, ...
                        0 , ...
                        4*varargin{2} - varargin{4}*duration, ...
                        varargin{2}];
                    obj.parameters(3) = (16*varargin{5} - ...
                        obj.parameters(1) - obj.parameters(2) - ...
                        obj.parameters(4) - obj.parameters(5));
                else
                    error(['Undefined Bezier Order: Please check input ' ...
                        'arguments or add a new definition'])
                end
            end
        end
        
        function x = nextPosition(obj)
            %NEXTPOSITION generates the next position of the foot
            if obj.cur_time < obj.duration
                x = obj.positionAtTime(obj.cur_time);
            else
                %TODO: How to properly handle out of bounds exceptions?
                error('Out of Bounds');
            end
            obj.cur_time = obj.cur_time + obj.increment;
        end
        
        function x = positionAtTime(obj, t)
            %POSITIONATTIME returns the position at time t
            if isempty(t)
                x = 0;
                return
            elseif min(t) < 0
                error('Invalid time supplied');
            end
            x = 0;
            for i = 0:obj.order
                x = x + obj.parameters(i+1) * ...
                (obj.duration - t).^(obj.order-i) .* t.^i;
            end
            x = x ./ obj.duration^obj.order;
        end
        
        function v = speedAtTime(obj, t)
            %SPEEDATTIME returns the speed at time t
            tp = min(t + obj.increment, obj.duration);
            tm = max(t - obj.increment, 0);
            v = (obj.positionAtTime(tp) - obj.positionAtTime(tm))./(tp - tm);
        end
        
        function b = isComplete(obj)
            %ISCOMPLETE returns true when the trejectory is at its end
            b = obj.cur_time - obj.duration < 1e-10;
        end
    end
end

