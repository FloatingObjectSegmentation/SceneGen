numScenes = 1000;

for scene = 1:1:numScenes
    generate_scene;
    if fail == 1
       continue 
    end
    save(strcat('data/', string(scene), 'data.mat'), 'data');
    save(strcat('data/', string(scene), 'classes.mat'), 'classes');
end