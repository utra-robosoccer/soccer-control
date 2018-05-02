classdef LiveQueue < Trajectories.GeneralizedTrajectory
    %ACTIONQUEUE Queue storing sequence of trajectories
    %   Manages update and retrieval
    
    properties (Hidden)
        transitions = [] % Transition times between the data
        data = [] % List of data
        current_time = 0 % Time from beggining of first data
        increment = 0.01 % Time step
        last_hold = 0 % Last position expected in data
        speed_enabled = true % Whether or not speed calculation enabled
    end
    
    methods (Hidden)
        function obj = simplify(obj)
            % Keeps only the data after the current time
            if isempty(obj.data)
                obj.current_time = 0;
            elseif obj.current_time > obj.transitions(1)
                % Remove one object and recursively simplify
                obj.current_time = obj.current_time - obj.transitions(1);
                obj.data = obj.data(2:end);
                obj.transitions = obj.transitions(2:end);
                obj.simplify();
            end
            obj.duration = sum(obj.transitions);
        end
        
        function obj = generateHold(obj)
            % Record last position of data
            if length(obj.data) >= 1
                obj.last_hold = obj.data(end).positionAtTime(obj.transitions(end));
            end
        end
        
        function sref = subsref(obj,s)
           % makes obj(i) equivalent to obj.data(i)
           switch s(1).type
              case '.'
                 sref = builtin('subsref', obj, s);
              case '()'
                 if length(s) < 2
                    sref = builtin('subsref', obj.data, s);
                    return
                 else
                    sref = builtin('subsref', obj, s);
                 end
              case '{}'
                 error('LiveQueue:subsref',...
                    'Not a supported subscripted reference')
           end
        end
            
        function ind = end(obj)
           ind = numel(obj.data);
        end
    end
    
    methods
        function obj = LiveQueue(empty_data, speed_enabled)
            % Initialize empty LiveQueue
            if ~isempty(empty_data)
                error('Data array must be empty');
            end
            obj.data = empty_data;
            if nargin == 2
                obj.speed_enabled = speed_enabled;
            end
            obj.simplify();
        end
        
        function position = next(obj)
            obj.current_time = obj.current_time + obj.increment;
            obj.simplify();
            position = obj.positionAtTime(0);
        end
        
        function position = positionAtTime(obj, time)
            % Determine current action (usually 1) and return position
            if isempty(obj) || time >= obj.duration - obj.current_time
                position = obj.last_hold;
                return
            end
            idx = 1;
            while time > obj.transitions(idx) - obj.current_time && ...
                    idx <= length(obj.data)
                time = time - obj.transitions(idx);
                idx = idx + 1;
            end
            position = obj.data(idx).positionAtTime(obj.current_time + time);
        end
        
        function speed = speedAtTime(obj, time)
            % Determine current action (usually 1) and return speed
            if ~obj.speed_enabled
                error('Speed not enabled for this data');
            end
            if isempty(obj) || time >= obj.duration - obj.current_time
                speed = zeros(size(obj.last_hold));
                return
            end
            idx = 1;
            while time > obj.transitions(idx) && idx <= length(obj.data)
                time = time - obj.transitions(idx);
                idx = idx + 1;
            end
            speed = obj.data(idx).speedAtTime(obj.current_time + time);
        end
        
        function empty = isempty(obj)
            empty = isempty(obj.data);
        end
        
        function obj = append(obj, data)
            obj.data(end + 1) = data;
            obj.transitions(end + 1) = data.duration;
            obj.generateHold();
            obj.simplify();
        end
    end
    
end

