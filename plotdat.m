figure
% load wind_pv_temp.txt;
% load Load.txt;
% WG=wind_pv_temp(:,1);
% S=wind_pv_temp(:,2);
% temp=wind_pv_temp(:,3);
% subplot(4,1,1)
% plot(WG(1:24*7))
% xlabel('时间 / 小时')
% ylabel('风�?? / m/s')
% xlim([1,24*7])
% 
% subplot(4,1,2)
% plot(S(1:24*7))
% xlabel('时间/小时')
% ylabel('光照强度 / Wh/m^2')
% xlim([1,24*7])
% 
% subplot(4,1,3)
% plot(temp(1:24*7))
% xlabel('时间/小时')
% ylabel('温度 / ^oC')
% xlim([1,24*7])
% 
% subplot(4,1,4)
% plot(Load(1:24*7))
% xlabel('时间/小时')
% ylabel('负载 / W')
% xlim([1,24*7])
% 
% set(gcf, 'PaperSize', [14 11],'Renderer','painters')
% saveas(gcf,'data.pdf')
% 
% return
close all
% figure(1)
c=1;
day=3;
index=[1585,8257,6265,3841];
for i=1:4
    figure
%     subplot(4,1,i)
    c=c+1;
sol=Population(1);
% sol=CalObjs(sol);
% sol=Arc(i);

x=index(i);

plot(sol.Pwg(x:x+24*day-1),'-o','linewidth',1)
hold on
plot(sol.Ppv(x:x+24*day-1),'-*','linewidth',1)
plot(sol.Pdg(x:x+24*day-1),'-d','linewidth',1)
plot(HRES.Pload(x:x+24*day-1),'-s','linewidth',1)

Pbat=zeros(1,8760);
for j=1:length(sol.Cbat)-1
   Pbat(j) =  (sol.Cbat(j+1)-sol.Cbat(j))*48/HRES.rtc;
end
plot(Pbat(x:x+24*day-1),'-h','linewidth',1)

ylim([-12000,22000])
xlim([1,24*day-1])

xlabel('ʱ�� / Сʱ')
ylabel('���� / W')
grid on

% xticks([])

set (gcf,'unit','normalized','position',[0.2,0.2,0.4,0.2] );
% if i==1
% legend('Wind Turbine','Photovoltaic','Diesel Generator','User Load','Battery','location','southoutside', ...
% 'NumColumns',5,'fontsize',10)
% end
set(gcf, 'PaperSize', [18 6])
saveas(gcf,['all' num2str(i) '.pdf'])
end
% xticks([0:2:day*24])
% figure(1)
% legend('Wind Turbine','Photovoltaic','Diesel Generator','User Load','Battery','location','southoutside','NumColumns',5,'fontsize',16)