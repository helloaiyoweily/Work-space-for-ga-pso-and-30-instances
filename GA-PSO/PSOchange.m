function [V , Chrom] = PSOchange(beta2,alpha,NV,NIND , N , V , Chrom,gbest , zbest,bestIndex,c1,c2,Vmax,Vmin,cusnum,cap,demands,customertimeWindows1,customertimeWindows2,L,customerServicetime,SDdist,SDdist0,DC ,sudu,MaintenanceV,TWPeriods,fuelV,priceV,beltaearly,beltalate, F , shifouhezuo)
     OChrom = Chrom;
    OObjV=calObj(OChrom,beta2,cusnum,cap,demands,customertimeWindows1,customertimeWindows2,L,customerServicetime,SDdist,SDdist0 , DC,alpha,beltaearly,beltalate,fuelV,priceV,MaintenanceV,TWPeriods,sudu,NV, F , shifouhezuo);             %计算种群目标函数值
     [OminObjV,OminInd]=min(OObjV);
for j = 1:NIND 
    V(j,:) = V(j,:) + c1*rand*(gbest(j,:) - Chrom(j,:)) + c2*rand*(zbest - Chrom(j,:));
    V( j , find( V(j , :) > Vmax)) = Vmax;
    V( j , find( V(j , :) < Vmin)) = Vmin ;    
    a = find(Chrom(j , :)<(cusnum+1));
    amax = max(a);
    Vnum =amax - cusnum;
   
    for  s1 = amax+1:N  
        Chrom(j , s1) = Chrom(j , s1);
    end
    m = size(a);
    for s = 1:m 

        if Chrom(j , a(s))<(cusnum+1)  
            Chrom(j , a(s)) = Chrom( j , a(s)) +round( 0.5*V( j , a(s)));   
            while Chrom(j , a(s)) > cusnum
                Chrom(j , a(s)) = Chrom(j , a(s))-1;
            end
            while Chrom(j  ,a(s)) <0
                Chrom(j , a(s)) = Chrom( j , a(s)) +1; 
            end
            while sum(Chrom(j , a(s))==Chrom( j , a(1:(s-1))))~=0
                Chrom(j , a(s)) = Chrom(j , a(s))+round(rand(1)*2-1);
            end 
        end
            if (Chrom(j , a(s))>cusnum && Chrom(j , a(s))<(amax+1))
                Chrom(j ,a(s)) = Chrom(j , a(s));
            end
    end
end
    
for j = 1:NIND
    for i = 1:N
        A = tabulate(Chrom(j , :));
        if sum(find(0==A(:,2)))~=0
            index0 =A(find(0==A(:,2)),1);
            index2 =A( find(A(: , 2)==2),1);
            index3 = find(index2==Chrom(j , :));
            Chrom( j ,index3(round(rand(1)+1))) = index0;
            clear    index0 ;
            clear   index2 ;
            clear  index3 ;
        end
    end
end

    DChrom = Chrom;
    DObjV=calObj(DChrom,beta2,cusnum,cap,demands,customertimeWindows1,customertimeWindows2,L,customerServicetime,SDdist,SDdist0 , DC,alpha,beltaearly,beltalate,fuelV,priceV,MaintenanceV,TWPeriods,sudu,NV, F , shifouhezuo);            
for k = 1:NIND
    if  OObjV(k) < DObjV(k)
        ObjV(k) = OObjV(k);
        Chrom( k , :) = OChrom(k , :);
    else
        ObjV(k) = DObjV(k);
        Chrom(k , :) = DChrom(k , :);
    end  
end

[DDminObjV,DDminInd]=min(ObjV);
if  OminObjV<DDminObjV
     ObjV(DDminInd) = OminObjV;   
    Chrom(DDminInd,:)  = OChrom(OminInd , :);
end
%  Chrom(bestIndex , :) = besthistory ;
end



























