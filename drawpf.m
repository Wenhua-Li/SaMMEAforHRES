close all
load('truePF.mat')
kneepoint = find_knee(pf,2);
pf=[pf.objs]';
plot3(pf(:,1),pf(:,2),pf(:,3),'r.','markersize',4)
grid on
hold on

objs=[Population.objs]';
plot3(objs(:,1),objs(:,2),objs(:,3),'bo','markersize',4)
IGD(objs,pf)


kpobj = [kneepoint.objs]';
% plot3(kpobj(:,1),kpobj(:,2),kpobj(:,3),'gs','MarkerSize',10,'MarkerEdgeColor','b','MarkerFaceColor','g')


legend('True PF','Obtained PF', 'Knee Point','location','north')
% plot3()

% load('spea2.mat')
% objs=[Population.objs]';
% plot3(objs(:,1),objs(:,2),objs(:,3),'g*')

% IGD(objs,pf)

view([70,50])
xlabel('Fuel Emission / kg','rotation',-60)
ylabel('LPSP / %')
zlabel('ACS / $')

xlim([0,6000])
ylim([0,10])
zlim([1e4,2e4])