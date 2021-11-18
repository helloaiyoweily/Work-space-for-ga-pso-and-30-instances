
clear all ; clc ; close all; tic
tic
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
  
%%vehicel routing optimization
  D = 4; data0=[F(D,1:9);data1] ;    shifouhezuo =1;   data1 = newputindata(data0);data2 = data1;data2(:,1)  = [];
  data = data2;
  MAXGEN = 100;  
  [SDdist,bsv,bestVC,bestNV,bestTD,bestTTT,bestWe,bestWl,bestTTC,best_vionum,best_viocus,reviewzbest,bestChrom,flag,DEL, violate_CTW1]= optimaize_1(data,D,F,shifouhezuo,MAXGEN);

%%visualization
format short
vertexs = data0(:,2:3);
draw_Best(data0,bestVC,vertexs);
toc

