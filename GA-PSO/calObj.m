function [ObjV,bsv]=calObj(Chrom,beta2,cusnum,cap,demands,customertimeWindows1,customertimeWindows2,L,customerServicetime,SDdist,SDdist0 , DC,alpha,beltaearly,beltalate,fuelV,priceV,MaintenanceV,TWPeriods,sudu,NV, F , shifouhezuo)
% 
% route=1:cusnum;
% G= part_length(route,dist);               
NIND=size(Chrom,1);                        
ObjV=zeros(NIND,1);                        
G=1000;                                      
for i=1:NIND
%         [VC,NV,TD,violate_num,violate_cus]=decode(Chrom(i,:),cusnum,cap,demands,a,b,L,s,dist);

[bsv,VC,NV,TD,TTT,WT,Wl,TTC,violate_num,violate_cus]=decode(beta2,Chrom(i,:),cusnum,cap,demands,customertimeWindows1,customertimeWindows2,L,customerServicetime,SDdist,SDdist0,DC , sudu,MaintenanceV,TWPeriods,fuelV,priceV,beltaearly,beltalate , F , shifouhezuo);      

% costF=costFuction(violate_num,beta2,VC,customertimeWindows1,customertimeWindows2,customerServicetime,L,SDdist,demands,cap,alpha,beltaearly,beltalate,NV,fuelV,priceV,MaintenanceV,TWPeriods,sudu,SDdist0,DC);
%ObjV(i)=costF;
     ObjV(i)=TTC;
end
end

