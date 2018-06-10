function sample = resample(minx, maxx, miny, maxy, minz, maxz)
    sample = round(rand(1, 3)) .* [maxx - minx, maxy - miny, maxz - minz] + [minx, miny, minz];
end

