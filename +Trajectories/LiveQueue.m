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
            %SIMPLIFY keeps only the data after the current time
            %   OBJ = SIMPLIFY(OBJ)
            %
            %   This is used to reduce the amount of data stored by
            %   removing data that has already passed.
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
            %GENERATEHOLD records last position of data
            %   OBJ = GENERATEHOLD(OBJ)
            %
            %   When queue runs out of data, the hold generated by this
            %   function is output instead.
            if length(obj.data) >= 1
                obj.last_hold = obj.data(end).positionAtTime(obj.transitions(end));
            end
        end
        
        function sref = subsref(obj,s)
           %SUBSREF makes obj(i) equivalent to obj.data(i)
           %
           %    SUBSREF overides the default function of the same name
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
        %END returns the index of the last element in the queue.
        %   IND = END(OBJ)
        %
        %
        %   Outputs
        %
        %   IND = [1 x 1]
        %       The index of the last element
           ind = numel(obj.data);
        end
    end
    
    methods
        function obj = LiveQueue(empty_data, speed_enabled)
        %LIVEQUEUE initializes empty queue
        %   OBJ = LIVEQUEUE(EMPTY_DATA)
        %   OBJ = LIVEQUEUE(EMPTY_DATA, SPEED_ENABLED)
        %
        %   Due to the constraints of differing data types, it is only
        %   possible to initialize an empty queue.
        %   TODO: Initialize non-empty queu?
        %
        %
        %   Arguments
        %
        %   EMPTY_DATA = [0 x 0] Trajectories.GeneralizedTrajectory
        %       Empty array used to stored the queue
        %
        %   SPEED_ENABLED = [1 x 1] Logical : True
        %       Ability to disable speed capture
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
        %NEXT produces the next element in the queue
        %   POSITION = NEXT(OBJ)
        %
        %   This is essentially the pop from the queue
        %
        %   
        %   Outputs
        %
        %   POSTION = [T]
        %       The next output of the trajectory, time varies.
            obj.current_time = obj.current_time + obj.increment;
            obj.simplify();
            position = obj.positionAtTime(0);
        end
        
        function position = positionAtTime(obj, time)
        %POSITIONATTIME returns the position at the given time
        %   X = POSITIONATTIME(OBJ, T)   
        %
        %
        %   Arguments
        %
        %   T = [1 x 1]
        %       The time to retrieve the positon at
        %
        %
        %   Outputs
        %
        %   X = [T]
        %       The position at time T
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
        %SPEEDATTIME returns the speed at the given team
        %   V = SPEEDATTIME(OBJ, T)
        %
        %
        %   Arguments
        %
        %   T = [1 x 1]
        %       The time to retrieve the speed at
        %
        %
        %   Outputs
        %
        %   V = [T]
        %       The speed at time T
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
        %ISEMPTY returns true if the queue has no more data
        %   EMPTY = ISEMPTY(OBJ)
        %
        %
        %   Outputs
        %
        %   EMPTY = [1 x 1] Logical
        %       Whether the queue is empty
            empty = isempty(obj.data);
        end
        
        function obj = append(obj, data)
        %APPEND appends a new piece of data to the queue
        %   OBJ = APPEND(OBJ, DATA)
        %
        %
        %   Arguments
        %
        %   DATA = [1 x 1] Trajectories.GeneralizedTrajectory
        %       The new piece of data to append.
            obj.data(end + 1) = data;
            obj.transitions(end + 1) = data.duration;
            obj.generateHold();
            obj.simplify();
        end
    end
    
end

