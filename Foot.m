classdef Foot
    %FOOT enumerates foot position
    
    enumeration
        Left
        Right
    end
    
    methods
        
        function obj = not(obj)
            if obj == Foot.Left
                obj = Foot.Right;
            else
                obj = Foot.Left;
            end
        end
        
    end
    
end

