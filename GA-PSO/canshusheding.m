function [sudu,aerfa1 , aerfa2 , cap , v_num,alpha , beta2 , beltaearly , beltalate , MaxVTraT , MaxVTraD , fuelV ,priceV , MaintenanceV , TWPeriods,NIND ,  Pc , Pm , GGAP , c1 , c2 , Vmax , Vmin, julikuodabeishu ] = canshusheding
sudu =30;
aerfa1 = 0.95;
aerfa2 = 0.05;
cap = 200;                                                      
v_num = 30;                                                       
alpha = 1000000;                                                       
beta2 = alpha;                                                       
beltaearly = 20;                                                     
beltalate =30;                                                      
sudu = sudu;                                                  
MaxVTraT = 16;                                          
MaxVTraD = 100;                                           
fuelV = 0.06;                                                             
priceV = 6.4;                                                     
MaintenanceV = 20000;                                  
TWPeriods=365;                                              
julikuodabeishu =1.37;                                   
NIND=100;                                                       
Pc=0.9;                                                         
Pm=0.05;                                                        
GGAP=0.9;                                                       
c1 = 1.5 ;      c2 = 1.5 ;    
Vmax = 1;            Vmin = -1 ;            
end

