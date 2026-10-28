kappa = 0.05;
Population = InitPop(PopSize,bounds);

gen = 1;
while gen<MaxGen
    MatingPool = TournamentSelection(2,PopSize,-CalFitness([Population.objs]',kappa));
    Offspring  = GA(Population(MatingPool),bounds);
    Population = EnvironmentalSelection4([Population,Offspring],PopSize,kappa);
    gen = gen + 1;
end