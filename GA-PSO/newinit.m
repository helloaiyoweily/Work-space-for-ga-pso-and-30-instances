function [init_vc,init_vc1,DPLoad] = newinit(cusnum,customertimeWindows1,customerServicetime,demands,cap,NDC1C,MaxVTraD , SDdist,SDdist0 ,DC,sudu)
%  r=ceil(rand*cusnum)    
r=1;
 deliveryload = [ ];
pickupload = [ ];
timeworklength  = [];
%             spacedis = [ ];
k=1;       
init_vc=cell(k,1);
if r==1
    seq=1:cusnum;
elseif r==cusnum
    seq=[cusnum,1:r-1];
else   seq1=1:r-1;           seq2=r:cusnum;           seq=[seq2,seq1];
end
route=[];       
dload=0;         
pload = 0;         
timeD = 0;          
maxWorkTime = (23-7)*60;        
i=1;
while i<=cusnum
    if  dload+demands(seq(i),1)<=cap   
        dload=dload+demands(seq(i),1);         
        pload = pload+demands(seq(i) , 2);
        %             elseif i>1 && sd+SDisBL( NDC1C(seq(i) +1, :), NDC1C(seq(i-1) +1 , :)  )<=MaxVTraD 
        %                 sd = sd+SDisBL( NDC1C(seq(i)+1 , :), NDC1C(seq(i-1) +1 , :)  );
        %                 dload=dload+demands(seq(i),1);         
        %                 pload = pload+demands(seq(i) , 2);
        
        %if load+demands(seq(i),1)-demands(seq(i),2)<=cap  
        %  load=load+demands(seq(i),1)-demands(seq(i),2);          
        if isempty(route)
            route=[seq(i)];
            timeD =  (customerServicetime(seq(i)) + 60*SDdist0(seq(i) , DC)/sudu)/60;
        elseif length(route)==1
            if customertimeWindows1(seq(i))<=customertimeWindows1(route(1)) &&  timeD +  (customerServicetime(seq(i-1)) + 60*SDdist(seq(i-1) , seq(i))/sudu)/60<maxWorkTime
                route=[seq(i),route];
                timeD = timeD +  (customerServicetime(seq(i-1)) + 60*SDdist(seq(i-1) , seq(i))/sudu)/60;
            elseif customertimeWindows1(seq(i))>=customertimeWindows1(route(1)) &&  timeD +  (customerServicetime(seq(i-1)) + 60*SDdist(seq(i-1) , seq(i))/sudu)/60<maxWorkTime
                route=[route,seq(i)];
                timeD = timeD +  (customerServicetime(seq(i-1)) + 60*SDdist(seq(i-1) , seq(i))/sudu)/60;
            else route = [ route ];
            end
        else
            lr=length(route);       
            flag=0;                 
            for m=1:lr-1
                if (customertimeWindows1(seq(i))>=customertimeWindows1(route(m)))&&(customertimeWindows1(seq(i))<=customertimeWindows1(route(m+1)))
                    route=[route(1:m),seq(i),route(m+1:end)];
                    flag=1;
                    break
                end
            end
            if flag==0
                route=[route,seq(i)];
            end
        end
        if i==cusnum
            init_vc{k,1}=route;
            break
        end
        i=i+1;
        deliveryload(k)=dload;         
        pickupload(k) =pload;         
        timeworklength(k)  = timeD;      
    else
        init_vc{k,1}=route;
        deliveryload(k)=dload;        
        pickupload(k) =pload;        
         timeworklength(k)  = timeD;     
        route=[];        
        k=k+1;
        dload = 0;
        pload = 0;
        timeD = 0;
    end
end


init_vc1=cell(k,1);
spacedis = [ ];
VN = [ ];
t = size(init_vc,1);
CN=[  ];
jutiC ={ };
init_vc1 = init_vc;

for  i = 1:t
    init_vc1{i ,1}= [NDC1C(1 , 1) ,init_vc{i , :} ];
    L = size(init_vc1{i , 1},2);
    CN(i ) = L;
    VN(i ) = i;
    sd = 0;
    for r = 2:L-1
%         sd =  sd+SDisBL( NDC1C(seq(r+1)+1 , :), NDC1C(seq(r)+1 , :)  );
            sd =  sd+SDisBL(   NDC1C(seq(r-1)+1 , :)   , NDC1C(seq(r)+1 , :)  )   ;
    end
    spacedis(i) =sd;
end

%%
DPLoad = [VN, CN,deliveryload , pickupload, timeworklength , spacedis ]  ;
end


