classdef Foot
    %FOOT enumerates foot sides
    
    enumeration
        Left
        Right
    end
    
    methods
        
        function obj = not(obj)
        %NOT returns the opposite foot
            if obj == Foot.Left
                obj = Foot.Right;
            else
                obj = Foot.Left;
            end
        end
        
    end
    
end

