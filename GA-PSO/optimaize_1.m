function [SDdist,bsv,bestVC,bestNV,bestTD,bestTTT,bestWe,bestWl,bestTTC,best_vionum,best_viocus,reviewzbest,bestChrom,flag,DEL, violate_CTW1,DObjV]= optimaize_1(data,DC,F,shifouhezuo,MAXGEN)

[sudu,~ , ~ , cap , v_num,alpha , beta2 , beltaearly , beltalate , ~ , MaxVTraD , fuelV ,priceV , MaintenanceV , TWPeriods,NIND , Pc , Pm , GGAP , c1 , c2 , Vmax , Vmin , julikuodabeishu ] = canshusheding;
v_num =10;

[E , L , vertexs , customer , cusnum , demands , customertimeWindows1 , customertimeWindows2 , customerServicetime   ] = wereaddataresult(data);
SDdist0  =julikuodabeishu.*SDisJZCTD(data(2:end,:) , F(:,:));                        
SDdist  =julikuodabeishu.*SDisJZCTC(data,data);                        

%%  genetic
N=cusnum+v_num-1;     

%% pso
popmax = N ;           popmin = -N ;      
par_num = N;          

%% initialize
  [init_vc,init_vc1,DPLoad] = newinit(cusnum,customertimeWindows1,customerServicetime,demands,cap,data,MaxVTraD , SDdist,SDdist0 ,DC,sudu)
 Chrom=InitPopCW(NIND,N,cusnum,init_vc);
 V = zeros(NIND , N);
for i = 1:NIND
V(i ,:) = rands(1,N);
end

%% out
disp('random')
[bsv,VC,NV,TD,TTT,We,Wl,TTC,violate_num,violate_cus]=decode(beta2,Chrom(1,:),cusnum,cap,demands,customertimeWindows1,customertimeWindows2,L,customerServicetime,SDdist,SDdist0,DC ,sudu,MaintenanceV,TWPeriods,fuelV,priceV,beltaearly,beltalate,F,shifouhezuo);

disp(['vehicle number',num2str(NV),'，vehicle distance：',num2str(TD),'，vehicle working time：',num2str(TTT),'，vehicle wighting time：',num2str(We),'，vehicle lating time：',num2str(Wl),'，travle cost：',num2str(TTC),'，penalty num：',num2str(violate_num),'，penalty customer num：',num2str(violate_cus)]);
disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
%% optimize
gen=1;
figure;
hold on;box on
xlim([0,MAXGEN])
title('optimization process')
xlabel('current i')
ylabel('optimum')

[ObjV,bsv]=calObj(Chrom,beta2,cusnum,cap,demands,customertimeWindows1,customertimeWindows2,L,customerServicetime,SDdist,SDdist0 , DC,alpha,beltaearly,beltalate,fuelV,priceV,MaintenanceV,TWPeriods,sudu,NV, F , shifouhezuo);             %calculate fitness

Chrom1 = Chrom;
%% finding
[preObjV bestindex]=min(ObjV);
zbest = Chrom(bestindex , :) ; %global
gbest = Chrom ; %local
fitnessgbest = ObjV; 
fitnesszbest = preObjV; 
bestIndex = 1;
shangdaibestChromj = [];
reviewzbest = [];
%% iterated
    while gen<=MAXGEN 
    [V , Chrom] = PSOchange(beta2,alpha,NV,NIND , N , V , Chrom,gbest , zbest,bestIndex,c1,c2,Vmax,Vmin,cusnum,cap,demands,customertimeWindows1,customertimeWindows2,L,customerServicetime,SDdist,SDdist0,DC ,sudu,MaintenanceV,TWPeriods,fuelV,priceV,beltaearly,beltalate, F , shifouhezuo);
    
    %% calculate fitness
    [ObjV,bsv]=calObj(Chrom,beta2,cusnum,cap,demands,customertimeWindows1,customertimeWindows2,L,customerServicetime,SDdist,SDdist0 , DC,alpha,beltaearly,beltalate,fuelV,priceV,MaintenanceV,TWPeriods,sudu,NV, F , shifouhezuo);             %calculate poplation

    if gen>=3
    line([gen-1,gen],[preObjV,min(ObjV)]);pause(0.0001)
    end
    %% for comparision
    OChrom = Chrom;
    OObjV = ObjV;
    [OminObjV,OminInd]=min(OObjV);
    
    %% calculation
    preObjV=min(ObjV);
    FitnV=Fitness(ObjV);
    shangdaibestChromj = Chrom( find(preObjV==ObjV) , : );
    %% selection
    SelCh=Select(Chrom,FitnV,GGAP);
    %% crossover
    SelCh=Recombin(SelCh,Pc);
    %% mutation
    SelCh=Mutate(SelCh,Pm);
    %% local search

    SelCh=LocalSearch(beta2,SelCh,cusnum,cap,demands,customertimeWindows1,customertimeWindows2,L,customerServicetime,SDdist,SDdist0 , DC,alpha,beltaearly,beltalate,fuelV,priceV,MaintenanceV,TWPeriods,sudu,F,shifouhezuo);
    %% Reins
    Chrom=Reins(Chrom,SelCh,ObjV);
    %% check
    Chrom=deal_Repeat(Chrom);
    
    %% comparision
    DChrom = Chrom;
    [DObjV,bsv]=calObj(DChrom,beta2,cusnum,cap,demands,customertimeWindows1,customertimeWindows2,L,customerServicetime,SDdist,SDdist0 , DC,alpha,beltaearly,beltalate,fuelV,priceV,MaintenanceV,TWPeriods,sudu,NV, F , shifouhezuo);             %计算种群目标函数值
       for k = 1:NIND
        if  OObjV(k) < DObjV(k)
            ObjV(k ) = OObjV(k );
            Chrom( k , :) = OChrom(k , :);
            gbest(k,:) = OChrom(k , :);
            fitnessgbest( k ) = OObjV(k);
        else
            ObjV(k ) = DObjV(k );
            Chrom(k , :) = DChrom(k , :);
            gbest(k,:) = DChrom(k , :);
            fitnessgbest( k ) = DObjV(k);
        end
    end
    %%  pop best
    [DDminObjV,DDminInd]=min(ObjV);
    if  OminObjV<DDminObjV
        ObjV(DDminInd) = OminObjV;
        Chrom(DDminInd,:)  = OChrom(OminInd , :);
    else
        ObjV(DDminInd) = DDminObjV;
        Chrom(DDminInd,:)  = Chrom(DDminInd , :);
    end
    [minObjV minInd]=min(ObjV);
    zbest = Chrom(minInd , :);
    reviewzbest(gen,:) = zbest;
    bestIndex = minInd;
    fitnesszbest =minObjV;
    %% prinnt
    disp(['No.',num2str(gen),'result'])
    [bsv,bestVC,bestNV,bestTD,bestTTT,bestWe,bestWl,bestTTC,best_vionum,best_viocus]=decode(beta2,Chrom(minInd(1),:),cusnum,cap,demands,customertimeWindows1,customertimeWindows2,L,customerServicetime,SDdist,SDdist0 , DC,sudu,MaintenanceV,TWPeriods,fuelV,priceV,beltaearly,beltalate , F , shifouhezuo);
    NV = bestNV;
    violate_num = best_vionum;
    disp(['vehicle number',num2str(NV),'，vehicle distance：',num2str(TD),'，vehicle working time：',num2str(TTT),'，vehicle wighting time：',num2str(We),'，vehicle lating time：',num2str(Wl),'，travle cost：',num2str(TTC),'，penalty num：',num2str(violate_num),'，penalty customer num：',num2str(violate_cus)]);
    fprintf('\n')
    %% update
    gen=gen+1 ;
    end
     
%% out put
disp('optimum:')
% bestChrom=Chrom(minInd,:);
[bsv,bestVC,bestNV,bestTD,bestTTT,bestWe,bestWl,bestTTC,best_vionum,best_viocus]=decode(beta2,Chrom(minInd(1),:),cusnum,cap,demands,customertimeWindows1,customertimeWindows2,L,customerServicetime,SDdist,SDdist0 , DC,sudu,MaintenanceV,TWPeriods,fuelV,priceV,beltaearly,beltalate , F , shifouhezuo);
bestChrom = Chrom(minInd(1),:);
disp(['vehicle number',num2str(NV),'，vehicle distance：',num2str(TD),'，vehicle working time：',num2str(TTT),'，vehicle wighting time：',num2str(We),'，vehicle lating time：',num2str(Wl),'，travle cost：',num2str(TTC),'，penalty num：',num2str(violate_num),'，penalty customer num：',num2str(violate_cus)]);
disp('-------------------------------------------------------------')
%% check
flag=Judge(bestVC,cap,demands,customertimeWindows1,customertimeWindows2,L,customerServicetime ,SDdist,sudu);
DEL=Judge_Del(bestVC);
violate_CTW1  = Judge_TW( bestVC,bsv,customertimeWindows1,customertimeWindows2,L )

end
