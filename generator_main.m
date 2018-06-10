numScenes = 20;

for scene = 1:1:numScenes
    generate_scene;
    save(strcat('data/', string(scene), 'data.mat'), 'data');
    save(strcat('data/', string(scene), 'classes.mat'), 'classes');
end