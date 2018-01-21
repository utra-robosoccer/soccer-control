angles = zeros(12, size(coord_in, 2));
offset_y = 0;
offset_zl = 0;
offset_zr = 0;
for i = 1:size(coord_in, 2)
    if coord_in(6, i) ~= coord_in(3, i)
        if coord_in(6, i) < coord_in(3, i)
            offset_y = -0.02 * min((coord_in(3, i) - coord_in(6, i))/0.008, 1);
        elseif coord_in(6, i) < coord_in(3, i)
            offset_y =  0.02 * min((coord_in(3, i) - coord_in(6, i))/0.008, 1);
        end
    else
        offset_y = 0;
    end
    
    angles(:, i) = [ikine(dh, coord_in(1, i) - optimal2(10), coord_in(2, i) + optimal2(5) + offset_y, coord_in(3, i) - 0.19 + offset_zl, 0, q0); 
        ikine(dh, coord_in(4, i) - optimal2(10), coord_in(5, i) + optimal2(5) + offset_y, coord_in(6, i) - 0.19 + offset_zr, 0, q0)];
    
    if coord_in(6, i) ~= coord_in(3, i)
        if coord_in(6, i) < coord_in(3, i)
            angles(2, i) = angles(2, i) + ...
               -deg2rad(4) * min((coord_in(3, i) - coord_in(6, i))/0.008, 1);
            angles(8, i) = angles(8, i) + ...
                deg2rad(12) * min((coord_in(3, i) - coord_in(6, i))/0.008, 1);
            angles(12, i) = angles(12, i) + ...
                deg2rad(1) * min((coord_in(3, i) - coord_in(6, i))/0.008, 1);
        elseif coord_in(6, i) > coord_in(3, i)
            angles(2, i) = angles(2, i) + ...
               -deg2rad(12) * min((coord_in(6, i) - coord_in(3, i))/0.008, 1);
            angles(3, i) = angles(3, i) + ...
                deg2rad(3) * min((coord_in(6, i) - coord_in(3, i))/0.008, 1);
            angles(5, i) = angles(5, i) + ...
                deg2rad(3) * min((coord_in(6, i) - coord_in(3, i))/0.008, 1);
            angles(6, i) = angles(6, i) + ...
               -deg2rad(6) * min((coord_in(6, i) - coord_in(3, i))/0.008, 1);
            angles(8, i) = angles(8, i) + ...
                deg2rad(4) * min((coord_in(6, i) - coord_in(3, i))/0.008, 1);
        end
    end
end