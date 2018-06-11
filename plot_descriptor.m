function field = plot_descriptor(field)
    field(field > 0.001) = 1;
    voxelPlot(field);
end