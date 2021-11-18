
function SDisttance= SDisJZCTD( customers, depots  )
a = 6378.14 ;           
   f = 1/298.257;            
n = size(customers , 1);
m = size(depots , 1);
SDisttance = [ ];
for i=1:n   
    for j = 1:m  
   FF = (customers(i , 3)+depots(j , 3))/2;      
   GG = (customers(i , 3)-depots(j , 3))/2;          
   ramda = (customers(i , 2)-depots(j , 2))/2;        
   SS = (sin(GG*pi/180)^2)*(cos(ramda*pi/180)^2)+ (cos(FF*pi/180)^2)*(sin(ramda*pi/180)^2);
   CC = (cos(GG*pi/180)^2)*(cos(ramda*pi/180)^2)+ (sin(FF*pi/180)^2)*(sin(ramda*pi/180)^2);
   omega = atan(sqrt(SS/CC));
   R = sqrt(SS*CC)/omega;
   DD = 2*omega*a;
   H1 = (3*R-1)/(2*CC);
   H2 = (3*R+1)/(2*SS);
   SDisttance(i , j) = DD*(1 +  f * H1*(sin(FF*pi/180)^2)* (cos(GG*pi/180)^2)- f * H2*(cos(FF*pi/180)^2)* (sin(GG*pi/180)^2));
    end
end
end
   
