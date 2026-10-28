function Population = InitPop(N,bounds)
nvar = size(bounds,2);
empty.decs = [];
Population = repmat(empty,1,N);

for i=1:N
    
    decs = zeros(1,nvar);
    for j=1:nvar
        decs(j) = randi([bounds(1,j),bounds(2,j)],1);
    end
    Population(i).decs = decs;
end
    
Population = CalObjs(Population);