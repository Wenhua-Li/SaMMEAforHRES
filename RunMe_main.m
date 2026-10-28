clc
clear
close all
addpath(genpath(pwd));

global HRES

%% 运行参数设置
run_time = tic;

PopSize = 100;
MaxGen = 15;
bounds=[0 0 0 0;30 20 30 10];   

%% 数据预处理
HRES = LoadData();

% return
%% 优化开始，以下算法可以选择
% NSGAII();
% SPEA2();
% IBEA();
% MOEAD();
MOEASES();

%% 提取最终的Pareto前沿
Arc = UpdateArc(Population,[]);

run_time = toc(run_time);
disp(['解个数：' num2str(length(Arc)) ' 用时:' num2str(run_time)])
load('truePF.mat')
objs=[pf.objs]';
decs=[];
for i=1:length(pf)
    decs=[decs; pf(i).decs];
end
% decs=[pf.decs]';
soldec = [];
for i=1:length(Population)
   soldec=[soldec;  Population(i).decs];
end

igd=IGD([Population.objs]',objs);
igdx=IGD(soldec,decs);
disp(['IGD：' num2str(igd) ' IGDX:' num2str(igdx)])

%% 保存数据
