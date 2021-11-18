
function flag=Judge(VC,cap,demands,customertimeWindows1,customertimeWindows2,L,customerServicetime,SDdist,sudu)
flag=1;                       
NV=size(VC,1);                  
init_v=vehicle_load(VC,demands);
bsv=begin_s_v(VC,customertimeWindows1,customertimeWindows2,customerServicetime,SDdist,sudu);
violate_INTW=Judge_TW(VC,bsv,customertimeWindows1,customertimeWindows2,L);
for i=1:NV
    find1=find(violate_INTW{i}==1,1,'first');     
    if init_v(i)>cap || ~isempty(find1)
        flag=0;
        break
    end
end
end

