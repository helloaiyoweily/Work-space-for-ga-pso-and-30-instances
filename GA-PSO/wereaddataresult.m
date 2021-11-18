
function [E , L , vertexs , customer , cusnum , demands , customertimeWindows1 , customertimeWindows2 , customerServicetime   ] = wereaddataresult(data)
E=data(1,6);                                                   
L=data(1,7);                                                    
vertexs=data(:,2:3);                                          
customer=vertexs(2:end,:);                                       
cusnum=size(customer,1);                                        
demands=data(2:end,4:5);    
customertimeWindows1=data(2:end,6);                                              
customertimeWindows2=data(2:end,7);                                                
customerServicetime=data(2:end,9);                                              
end





























