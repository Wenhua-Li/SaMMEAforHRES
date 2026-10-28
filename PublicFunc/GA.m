function Offspring = GA(Population,bounds)

% GA - Genetic operators for real, binary, and permutation based encodings.
Offspring = Population;
N = length(Population);
nvar = size(Population(1).decs,2);

for i=1:N
    pop1 = Population(i).decs;
    
    if rand > 0.2 %crossover
        pick = i;
        while pick==i
           pick = randperm(N,1); 
        end
        pop2 = Population(pick).decs;
        
        pos = randperm(nvar,2);
        tmp = pop2(pos);
        pop1(pos) = tmp;
        
        Offspring(i).decs = pop1;
    else
        walk = round(10.*rands(1,nvar));
        pop1 = pop1+walk;
        pop1 = min(pop1,bounds(2,:));
        pop1 = max(pop1,bounds(1,:));
        
        Offspring(i).decs = pop1;
    end
    
%     Offspring(i).decs(4) = 5;
end

Offspring = CalObjs(Offspring);
