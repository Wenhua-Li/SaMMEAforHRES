function [Population] = UpdateArc(Population,offspring)
% Update the Archive
%--------------------------------------------------------------------------
% This code uses PlatEMO published in "Ye Tian, Ran Cheng, Xingyi Zhang,
% and Yaochu Jin, PlatEMO: A MATLAB Platform for Evolutionary
% Multi-Objective Optimization [Educational Forum], IEEE Computational
% Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------
joint=[Population offspring];
N = length(joint);

[FrontNo,MaxFNo] = NDSort([joint.objs]',N);
next=FrontNo==1;
Population=joint(next);

% Population = RemoveDup(Population);

objs = [Population.objs];
[~,I] = sortrows(objs');
Population = Population(I);