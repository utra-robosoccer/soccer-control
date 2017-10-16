classdef Footstep
    %FOOTSTEP defines the position and orientation of a footstep
    
    properties
        x = 0;
        side = Foot.Left;
    end
    
    methods
        function self = Footstep(x)
            if nargin > 0
                self.x = x;
            end
        end
    end
    
    methods(Static)
        function footsteps = generateFootsteps(path, L_init, R_init)
            %GENERATEFOOTSTEPS generates footsteps to follow the path
            
            %Time to take one step, can be adjusted.
            airtime = 0.5;
            n = floor(path.duration/path.increment);

            %Initialize the L and R vectors
            L = ones(1, n)*(NaN);
            R = ones(1, n)*(NaN);
            L(1) = L_init;
            R(1) = R_init;
            
            i_l = 1;                            %index in L vector
            i_r = 1;                            %index in R vector
            x_curr = 0.5*(L(i_l) + R(i_r));     %current position
            
            for i = 1:(n-1)
                t = i*path.increment;
                if x_curr <= positionAtTime(path, t)              %parse through positions until at current position
                    s = 2*speedAtTime(path, t)*airtime;           %determine appropriate step size for velocity based on airtime
                    if (L(i_l) < R(i_r))                        %check whether left or right foot should move
                        L(i_l+1) = R(i_r) + s/2;                %fill in next element of foot positions
                        i_l = i_l + 1;                          %increment index of L/R vector
                    else
                        R(i_r+1) = L(i_l) + s/2;
                        i_r = i_r + 1;
                    end
                    x_curr = 0.5*(L(i_l) + R(i_r));             %update current position
                end
            end
            
            %Adjust the last two elements of the L and R vectors so that the final position
            %matches with the final position
            final_position = positionAtTime(path, path.duration);
            if (L(i_l) > R(i_r))
                R(i_r) = 0.5*(L(i_l-1) + final_position);
                L(i_l) = 2*final_position - R(i_r);
            else
                L(i_l) = 0.5*(R(i_r-1) + final_position);
                R(i_r) = 2*final_position - L(i_l);
            end
            
            %Remove unnecessary elements
            L = L(1:i_l);
            R = R(1:i_r);
            
            %Combine L and R into a single footstep array
            footsteps(1:i_r + i_l) = Footstep;
            if L_init < R_init
                for i = 1:min(i_l, i_r)
                    footsteps(2*i-1).x = L(i);
                    footsteps(2*i-1).side = Foot.Left;
                    footsteps(2*i).x = R(i);
                    footsteps(2*i-1).side = Foot.Right;                    
                end
                if i_l > i_r
                    footsteps(end).x = L(i_l);
                    footsteps(2*i-1).side = Foot.Left;
                end
            else
                for i = 1:min(i_l, i_r)
                    footsteps(2*i-1).x = R(i);
                    footsteps(2*i-1).side = Foot.Right;
                    footsteps(2*i).x = L(i);
                    footsteps(2*i-1).side = Foot.Left;
                end
                if i_r > i_l
                    footsteps(end).x = R(i_r);
                    footsteps(2*i-1).side = Foot.Right;
                    
                end
            end
        end
    end
end