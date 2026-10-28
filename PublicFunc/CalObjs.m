function Population = CalObjs(Population)

global HRES
N = length(Population);
Ht=20;
lod = HRES.Pload;
for j=1:N
    Pdg=zeros(1,8760);
    Npv = Population(j).decs(1);
    Nwg = Population(j).decs(2);
    Nbat = Population(j).decs(3);
    Ndg = Population(j).decs(4);
    T=8760;                              %total time interval of one year
    count=0;                             %计数未满足负载  
    Cn1=HRES.Cnb*Nbat/HRES.nbs;                              %available capacity of the battery bank.    除以nbs,需要重新运行程序
    Dp=Ndg*HRES.Pndg*HRES.inverter_dg;
    ef=2.5;                                     %fuel emission factor kg/l
    PV = HRES.Ppv .* Npv;
    PWG = HRES.Pwg .* Nwg;
    %% power output
    fuel=0;
    for n=1:365
        for t=0:23
            i=24*(n-1)+t+1;
            %% battery charging
            Cn(1)=Cn1;                                            %电池组初始容量，待定
            deltat=1;                                             %时间间隔
            deltap(i)=PV(i)+PWG(i)-lod(i);
            if deltap(i)==0
                Cn(i+1)=Cn(i);
            elseif deltap(i)>0
                Cn(i+1)=Cn(i)+HRES.rtc*deltat*deltap(i)/HRES.Vbus;           %充电
                if Cn(i+1)>Cn1
                    Cn(i+1)=Cn1;
                end
            else%if deltap(i)<0                                       %discharging
                Cn(i+1)=Cn(i)+HRES.rtd*deltat*deltap(i)/HRES.Vbus;
                if Cn(i+1)<Cn1*(1-HRES.dod)
                    Cn(i+1)=Cn1*(1-HRES.dod);
                    E(i)=abs((Cn(i)-Cn1*(1-HRES.dod))*deltat*HRES.Vbus+deltap(i));               %风光电池不能满足负载的差额，取绝对值,由柴油发电机供电
                    if Ndg==0
                        fuel=0;
                        count=count+1;
                    else
                        if  E(i)>Dp                                                        %按照dufo的公式计算燃料消耗
                            Pdg(i) = Dp;
                            fuel(i)=HRES.afdg*Dp/1000+HRES.bdg*Dp/1000;
                            count=count+1;                                                 %计数，计算LPSP
                        else
                            Pdg(i) = E(i);
                            fuel(i)=HRES.afdg*Dp/1000+HRES.bdg*E(i)/1000;
                        end
                    end
                end
            end
        end
    end
    
    y=zeros(1,3);
    total_fuel=sum(fuel);                           %总的燃料消耗
    emission=ef*total_fuel;                          %二氧化碳排放，kg,一个优化目标
    y(1)=emission;                                %第一个目标
    LPSP=count/T*100;                                   %loss of power supply probability, 百分比
    y(2)=LPSP;
    
    Tdg=size(find(fuel>0),2);                       %柴油发电机工作时间，h
    
    %% cost of components
    Cappv=5000;                                   %Capital (acquisition) cost of PV, unit:$
    Capwg=3000;
    Captow=250;                                   %initial capital cost of wind turbine tower,unit:$/m
    Capbat=500;                                   %1032 dufo中
    Capdg=1500;
    OMpv=30;                                      %unit:$/year
    OMwg=50;
    OMtow=2.5;                                    %tower maintenance cost  $/m
    OMbat=1.25;
    OMdg=0.15;                                    %unit: $/h 每小时
    REPbat=125;                                   %replacement of battery
    fuel_price=1.5;                               %燃料价格
    i_n=0.0375;                                   %nominal interest rate
    inf_=0.015;                                    %inflation rate
    Lifet=25;                                     %the component lifetime
    Lbat=5;                                       %the battery lifetime     改为5年运行程序
    
    i_real=(i_n-inf_)/(1+inf_);                     %the annual real interest
    crf=i_real*(1+i_real)^Lifet/((1+i_real)^Lifet-1);                      %CRF-capital recovery factor
    sff=i_real/((1+i_real)^Lbat-1);                                        %SFF-sinking fund factor
    Cacap=Npv*Cappv*crf+Nwg*(Capwg+Captow*Ht)*crf+Nbat*Capbat*crf+Ndg*Capdg*crf;                      %年度资本成本
    Carep=Nbat*REPbat*sff;                                                                %替换成本，只考虑电池有替换
    Camain=Npv*OMpv+Nwg*(OMwg+OMtow*Ht)+Nbat*OMbat+Ndg*OMdg*Tdg+total_fuel*fuel_price;                                     %maintenance cost
    ACS=Cacap+Carep+Camain;                                                              %总的年度成本
    y(3)=ACS;
    
    Population(j).objs = y([1,2,3])';
    Population(j).Pdg = Pdg;
    Population(j).Pwg = PWG;
    
    Population(j).Ppv = PV;
    Population(j).Cbat = Cn;
    
    if y(2)>10
        Population(j).cons = 0;
        Population(j).objs = Population(j).objs + (y(2)-10)*1e20;
    else
        Population(j).cons = 0;
    end
    
end