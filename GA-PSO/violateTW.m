
function [bsv,bsv0cd , we,wl]=violateTW(curr_vc,a,b,s,L,dist,sudu)
NV=size(curr_vc,1);                        
we=0;            
wl = 0;             
[bsv , bsv0cd]=begin_s_v(curr_vc,a,b,s,dist,sudu);           
for i=1:NV
    route=curr_vc{i};
    bs=bsv{i};
    l_bs=length(bsv{i});
    for j=1:(l_bs-1)
        if  bs(j) <= a(route(j))
            we=we+a(route(j)) - bs(j);
        end
        if bs(j)>= b(route(j))
            wl=wl+bs(j);
        end
        if (a(route(j)) <=  bs(j) &&  bs(j) <=  b(route(j)) );
            we = we;
            wl = wl;
        end
    end
end

end
 
%     if bs(end)>L
%         wl=wl+bs(end)-L;  
%     end



