%% 
clear all; clc ; close all; tic

%% data input
F = xlsread('data.xls.lnk','F');
data1 = xlsread('data.xls.lnk','1');
data2 = xlsread('data.xls.lnk','2');
data3 = xlsread('data.xls.lnk','3');
data4 = xlsread('data.xls.lnk','4');
data5 = xlsread('data.xls.lnk','5');
data6 = xlsread('data.xls.lnk','6');
TCD = xlsread('data.xls.lnk','TCD');
TCP = xlsread('data.xls.lnk','TCP');


 %% parameters setting
sudu = 35;
aerfa1 = 0.8;
aerfa2 = 0.2;

%% clustering for three member
a = [1,2,3];
TCdata1 = [data1 ; data2 ; data3 ];
TCdata1(:,2) = [];
Fdata = F;
[DTDassignments1 ,datan1,datan2,datan3] = P3__STdcclustering(Fdata,TCdata1,a,sudu,aerfa1 , aerfa2);
save datan1 ; save  datan2;  save  datan3;













































