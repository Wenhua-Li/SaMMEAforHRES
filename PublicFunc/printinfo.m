
if ~mod(gen,10) || gen==MaxGen
    Arc = UpdateArc(Population,[]);
    disp(['迭代次数:' num2str(gen) ' 解个数:' num2str(length(Arc))])
    objs = [Population.objs];
    plot3(objs(1,:),objs(2,:),objs(3,:),'.')
    grid on
    pause(0.01)
    view([30,30])
end