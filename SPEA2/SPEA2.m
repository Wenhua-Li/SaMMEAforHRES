Population = InitPop(PopSize,bounds);
Fitness    = CalFitness2([Population.objs]');
gen=1;
while gen<MaxGen
    MatingPool = TournamentSelection(2,PopSize,Fitness);
    Offspring  = GA(Population(MatingPool),bounds);
    [Population,Fitness] = EnvironmentalSelection3([Population,Offspring],PopSize);
    printinfo();
    
    gen = gen+1;
end