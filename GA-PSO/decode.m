function [bsv,VC,NV,TD,TTT,We,Wl,TTC,violate_num,violate_cus]=decode(beta2,chrom,cusnum,cap,demands,customertimeWindows1,customertimeWindows2,L,customerServicetime,SDdist,SDdist0,DC , sudu,MaintenanceV,TWPeriods,fuelV,priceV,beltaearly,beltalate,F,shifouhezuo)
violate_num=0;                                      
violate_cus=0;                                     
violate_waitingtime = 0;                          
VC=cell(cusnum,1);                                  
count=1;                                            
location0=find(chrom>cusnum);                       
for i=1:length(location0)
    if i==1                                         
        route=chrom(1:location0(i));                
        route(route==chrom(location0(i)))=[];       
    else
        route=chrom(location0(i-1):location0(i));   
        route(route==chrom(location0(i-1)))=[];     
        route(route==chrom(location0(i)))=[];       
    end
    VC{count}=route;                                
    count=count+1;                                  
end

route=chrom(location0(end):end);                    
route(route==chrom(location0(end)))=[];             
VC{count}=route;                                    
[VC,NV]=deal_vehicles_customer(VC);                 
for j=1:NV
    route=cell(1,1);                               
    route{1}=VC{j};
    flag=Judge(route,cap,demands,customertimeWindows1,customertimeWindows2,L,customerServicetime,SDdist,sudu);    
    if flag==0
        violate_cus=violate_cus+length(route{1});  
        violate_num=violate_num+1;                  
    end
end
[sumTD,everyTD]=travel_distance(VC , SDdist , DC , SDdist0);                        
[bsv,bsv0cd , we,wl]=violateTW(VC,customertimeWindows1,customertimeWindows2,customerServicetime,L,SDdist,sudu);

%  [sumWT,everyWT]=waitingtime(VC,SDdist,SDdist0,DC ,sudu,customertimeWindows1,customertimeWindows2);
TD = sumTD;
We = we/60;
Wl = wl/60;
TTT = 0;
for r = 1:NV
   at = bsv0cd{r};
   TTT =  TTT+(at(end) - at(1) )/60;%Ð¡Ê±»¯
end
TTC =(F(DC , 10)+   shifouhezuo*F(DC , 11)  -  shifouhezuo*F(DC , 12)   +  TD*fuelV*priceV+beltaearly*We +beltalate*Wl + NV*MaintenanceV/TWPeriods+violate_num* beta2   )*(floor(TWPeriods/52));
end

