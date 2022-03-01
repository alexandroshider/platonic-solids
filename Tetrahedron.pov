// Libraries containing color, texture, vector operations
#include "colors.inc"
#include "shapes.inc"
#include "math.inc"
                   
//Scenario and camera definition                  
light_source {
<1000,0, 0>
color	White}
light_source {
<0,1000, -1000>
color	White} 
camera {location <3,3,-6> look_at <0,0,0>}
background{color White}
light_source{<1000,1000,-1000> color White}
 
//Tetrahedron positions
#declare ari=2;       //artist size
//Tetrahedron is built-in a cube, a is for the arist of that cube
#declare a=ari/sqrt(2);   
#declare L=ari+0.1;
#declare Pos= array [8];
#declare Pos[0]=<a/2,  a/2,  a/2>;
#declare Pos[1]=<-a/2,  -a/2,  a/2>;
#declare Pos[2]=<-a/2,  a/2,  -a/2>;
#declare Pos[3]=<a/2, -a/2,  -a/2>;

// This block is to define the vertices as spheres
#declare i=0;
#while (i<4)
 sphere {Pos[i], 0.3 pigment{color Blue} finish{phong 1}} 
 #declare i=i+1;
#end

//This block is to calculate the distances among vertices and define edges
#declare i=0;            
#while(i<3) 
    #declare j=i+1;
    #while(j<4)  
        #declare distancia=VDist(Pos[i],Pos[j]);        
        cylinder{Pos[i],Pos[j],0.05 texture {pigment {color Green}} finish{phong 1}}            
        #declare j=j+1;
    #end 
    #declare i=i+1;
#end 