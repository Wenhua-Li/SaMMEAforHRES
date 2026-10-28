% parpool(10)
tt=tic;
bounds=[0 0 0 0;30 20 30 10];

dataset=zeros(31*21*31*11,4);
empty.decs = [];
Population = repmat(empty,1,size(dataset,1));
count=0;
for i=0:30
    for j=0:20
        for k=0:30
            for l=0:10
                count = count+1;
                dataset(count,:) = [i,j,k,l];
                Population(count).decs = [i,j,k,l];
            end
        end
    end
end

'wu, jieshule'
Population = CalObjs(Population);
'suanhaole'
pf=UpdateArc(Population,[]);
objs=[pf.objs];
plot3(objs(1,:),objs(2,:),objs(3,:),'.')
tt=toc(tt)
