function gslight = mk_searchlight(radius)
% defines searchlight coordinates
    gslight = [0,0,0];
    for x = -radius:radius
        for y = -radius:radius
            for z = -radius:radius
                pt = [x y z];
                cdist = pdist([[0 0 0];pt]);
                if (cdist <= radius) && (cdist ~= 0)
                    gslight = [gslight;pt];
                end
            end 
        end 
    end 
