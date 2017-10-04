classdef BezierTrajectory
    %BEZIERTRAJECTORY Defines a general purpose bezier trajectory
    
    properties
        points = zeros(5,1);
        duration = 1;
        increment = 0.01;
        cur_time = 0;
    end
    
    methods
        function obj = BezierTrajectory(varargin)
            if nargin > 0
                obj.duration = floor(varargin{1} / obj.increment) * obj.increment;
                if nargin == 2
                    obj.points = varargin{2};
                else
                    obj.points = cell2mat(varargin{2:6});
                end
            end
        end
        
        function x = nextPosition(obj)
            %NEXTPOSITION generates the next position of the foot
            if obj.cur_time < obj.duration
                obj.speedAtTime(obj.cur_time);
            else
                %TODO: How to properly handle out of bounds exceptions?
                error('Out of Bounds');
            end
            obj.cur_time = obj.cur_time + obj.increment;
        end
        
        function x = positionAtTime(obj, t)
            %POSITIONATTIME returns the position at time t
            
            %TODO: Samee, this function returns the value of the
            %   bezier curve at this time
            
            % Temporary until above is complete
            x = t/10;
        end
        
        function x = speedAtTime(obj, t)
            %POSITIONATTIME returns the speed at time t
            
            %TODO: Samee, this function returns the derivative of the
            %   bezier curve at this time
            
            % Temporary until above is complete
            x = 0.1;
        end
        
        function b = isComplete(obj)
            %ISCOMPLETE returns true when the trejectory is at its end
            b = obj.cur_time == obj.duration;
        end
    end
    
    methods(Static)
        function traj = footTrajectory(duration, cur_foot, next_foot)
           %FOOTTRAJECTORY creates a bezier trajectory between footsteps
           
           %TODO: Samee, this function just creates a memeber of this class
           % and fills in its points with the five bezier parameters
        end
    end
    
end

