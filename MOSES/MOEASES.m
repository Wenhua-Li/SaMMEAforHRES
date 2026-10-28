Population = InitPop(PopSize,bounds);
gen=1;
while gen<MaxGen
    Fitness    = CalFitness2([Population.objs]');
    MatingPool = TournamentSelection(2,PopSize,Fitness);
    Offspring  = GA(Population,bounds);
    [Population,FrontNo] = EnvironmentalSelection([Population,Offspring],PopSize);
    gen = gen + 1;
    printinfo();
end