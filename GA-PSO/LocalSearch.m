
function SelCh=LocalSearch(beta2,SelCh,cusnum,cap,demands,a,b,L,s,SDdist,SDdist0 , DC,alpha,beltaearly,beatalate,fuelV,priceV,MaintenanceV,TWPeriods,sudu,F,shifouhezuo)
D=15;                                                      
toRemove=15;                                               
[row,N]=size(SelCh);
for i=1:row
    [bsv,VC,NV,TD,TTT,WT,TTC,violate_num,violate_cus]=decode(beta2,SelCh(i,:),cusnum,cap,demands,a,b,L,s,SDdist,SDdist0 , DC,sudu,MaintenanceV,TWPeriods,fuelV,priceV,beltaearly,beatalate,F,shifouhezuo);
    % [VC,NV,TD,TTT,WT,violate_num,violate_cus]=decode(chrom,cusnum,cap,demands,customertimeWindows1,customertimeWindows2,L,customerServicetime,SDdist,sudu)

    CF=costFuction(violate_num,beta2,VC,a,b,s,L,SDdist,demands,cap,alpha,beltaearly,beatalate,NV,fuelV,priceV,MaintenanceV,TWPeriods,sudu,SDdist0,DC);
    %Remove
    [removed,rfvc] = Remove(cusnum,toRemove,D,SDdist,SDdist0,DC , VC);
    %Re-inserting
    [ReIfvc,RTD] = Re_inserting(removed,rfvc,L,a,b,s,SDdist,demands,cap,sudu,SDdist0 , DC);
    RCF=costFuction(violate_num,beta2,ReIfvc,a,b,s,L,SDdist,demands,cap,alpha,beltaearly,beatalate,NV,fuelV,priceV,MaintenanceV,TWPeriods,sudu,SDdist0,DC);
    if RCF<CF
        chrom=change(ReIfvc,N,cusnum);
        if length(chrom)~=N
            record=ReIfvc;
            break
        end
        SelCh(i,:)=chrom;
    end
end
