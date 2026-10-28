%% 优化开始
Population = InitPop(PopSize,bounds);
[~,FrontNo,CrowdDis] = EnvironmentalSelection2(Population,PopSize);
gen=1;
while gen<MaxGen
    MatingPool = TournamentSelection(2,PopSize,FrontNo,-CrowdDis);
    Offspring  = GA(Population(MatingPool),bounds);
    [Population,FrontNo,CrowdDis] = EnvironmentalSelection2([Population,Offspring],PopSize);
    gen = gen + 1;
%     Arc = UpdateArc(Population,[]);
    printinfo();
end

