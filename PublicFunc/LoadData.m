function HRES = LoadData()
load wind_pv_temp.txt;
load Load.txt;
WG=wind_pv_temp(:,1);
S=wind_pv_temp(:,2);
temp=wind_pv_temp(:,3);

T=8760;                              %total time interval of one year
%% pv model, this model only consider the beam radiation
phi=41.65;    %地理 latitude of zaragoza in Spain, N
lamda=1.02;     %solar ecliptic longitude of zaragoza in Spain, W
I=23.44;       %地轴与轨道面倾角
belta=20;      %待优化变量 PV tilt angle

NCOT=43;                                  %额定电池工作温度
Ki=0.0038;                                %short-circuit current temperature coefficient  unit:A/C
Kv=0.05;                                 %可以再小点
%open-circuit voltage  temperature coefficient  unit:V/C
Vocstc=21;
Iscstc=7;
Vmax=17;
Imax=6.5;                                %额定功率110w
FF=Vmax*Imax/(Vocstc*Iscstc);             %fill factor
%delta:the longitude at the equator,太阳赤纬角，地球赤道面与地日中心线之间的夹角

%% the parameter of wind turbine风机参数
Vc=4;                                        %cut-in speed
Vr=14;                                       %rated wind speed
Vf=20;                                       %cut-off wind velocity
Cp=0.5;                                      %the limit of Cp is 0.593, that is Betz limit
rho=1.29;                                    %density of air  kg per m^3
r=2;                                         %radiur of wind turbine
alpha=0.15;                                  %wind speed power law efficient
Hr=10;                                       %reference height,unit:m
Ht=25;                                       %the height of wind turbine 待优化变量
Pwgr=10000;                                   %rated power 10 kw
Awg=pi*r^2;

%% battery parameter 电池参数
HRES.Cnb=500;                                   %nominal capacity of the battery, unit: Ah
HRES.volt=12;                                  %volatage ,V
HRES.Vbus=48;
HRES.rtc=0.8;                                  %roundtrip efficiency in the charging process
HRES.rtd=1;                                    %roundtrip efficiency in the discharging process
HRES.dod=0.8;
HRES.nbs=HRES.Vbus/HRES.volt;                            %number of batteries in series

%% diesel parameter
HRES.Pndg=2000;                                  %diesel nominal capacity, unit:W
HRES.afdg=0.1;                              %额定功率下燃料消耗参数，unit:l/kwh
HRES.bdg=0.25;                                 %非额定功率下燃料消耗参数
HRES.inverter_dg=0.9;                            %交流发电机逆变器效率

HRES.ef=2.5;                                     %fuel emission factor kg/l

%% power output
PV = zeros(1,T);
PWG = zeros(1,T);
for n=1:365
    delta(n)=I*sin(2*pi*(284+n)/365);
    
    for t=0:23
        i=24*(n-1)+t+1;
        tao=2*pi*(12-t)/24;
        ele(i)=sin(phi*pi/180)*sin(delta(n)*pi/180)+cos(phi*pi/180)*cos(delta(n)*pi/180)*cos(tao);
        %防止出现过小的机器数，设置精度
        if ele(i)<0.01
            ele(i)=0;
        end
        
        h(i)=asind(ele(i));                                        %结果以度表示,太阳高度角  elevation angle
        if h(i)<0||h(i)==0
            St(i)=0;
            Sp(i)=0;
        else
            St(i)=S(i)/ele(i);                                         %入射在斜面上的部分tilt
            Sp(i)=St(i)*sin((h(i)+belta)*pi/180);                               %垂直于斜面的部分，有效部分，pendicular
        end
        Tc(i)=temp(i)+(NCOT-20)*Sp(i)/800;
        Isc(i)=[Iscstc+Ki*(Tc(i)-25)]*Sp(i)/1000;
        Voc(i)=Vocstc-Kv*Tc(i);
        PV(i)=Isc(i)*Voc(i)*FF;                                     %考虑光伏个数之后的总输出功率
        
        %% wind turbine
        V(i)=WG(i)*(Ht/Hr)^alpha;
        if V(i)<Vc
            Pwg(i)=0;
        elseif V(i)>Vc&&V(i)<Vr ||V(i)==Vc
            Pwg(i)=0.5*Cp*rho*Awg*V(i)^3;
        elseif V(i)>Vr&&V(i)<Vf||V(i)==Vr
            Pwg(i)=Pwgr;
        else %V(i)>Vf||V(i)==Vf
            Pwg(i)=0;
        end
        PWG(i)=Pwg(i);                                          %考虑风机个数的总输出功率
    end
end

HRES.Ppv = PV.*2.5;
HRES.Pwg = PWG./2;
HRES.Pload = Load'.*2;