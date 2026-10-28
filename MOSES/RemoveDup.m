function Population = RemoveDup(Population)
n = length(Population);
del = [];

for i=1:n-1
    if find(i==del)
        continue;
    end
    for j=i+1:n
        if all(Population(i).decs==Population(j).decs)
            del = [del j];
        end
    end
end
Population(del) = [];