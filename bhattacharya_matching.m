function similarity = bhattacharya_matching(template1, template2)
    sum1 = sum(sum(sum(template1)));
    sum2 = sum(sum(sum(template2)));
    template1 = template1 ./ sum1;
    template2 = template2 ./ sum2;
    bhatsize = size(template1) + size(template2);
    
    bhat1 = zeros(bhatsize);
    lx = round(size(template2, 1) / 2);
    ly = round(size(template2, 2) / 2);
    lz = round(size(template2, 3) / 2);
    rx = lx + size(template1, 1);
    ry = ly + size(template1, 2);
    rz = lz + size(template1, 3);
    bhat1(lx:rx-1,ly:ry-1,lz:rz-1) = template1;
    
    bhat2 = zeros(bhatsize);
    lx = round(size(template1, 1) / 2);
    ly = round(size(template1, 2) / 2);
    lz = round(size(template1, 3) / 2);
    rx = lx + size(template2, 1);
    ry = ly + size(template2, 2);
    rz = lz + size(template2, 3);
    bhat2(lx:rx-1,ly:ry-1,lz:rz-1) = template2;
    
    similarity = sum(sum(sum(sqrt(bhat1 .* bhat2))));
end

