// Libraries containing color, texture, vector operations
#include "colors.inc"
#include "shapes.inc"
#include "math.inc"
                   
                   
light_source {
<1000,0, 0>
color	White}
  
light_source {
<0,1000, -1000>
color	White} 

// Set a color of the background (sky)
//Scenario definition
camera {location <3,2,-6> look_at <0,0,0>}
background{color White}
light_source{<1000,1000,-1000> color White}



//Macro used for "drawing" the cube's vertices
#macro PrintSphere (Final,Arr,Radio,Kolor)
 #declare i=0; 
 //The coords are in a array
 #while (i<Final)  
  sphere{Arr[i],Radio texture {pigment{color Kolor}} finish{phong 1}}
  #declare i=i+1; 
 #end 
#end 

//Macro used for "drawing" the cube's arists
#macro HacerCilindros (Final,Arr,Dmax,Radio,Kolor)
 #declare i=0;        
 //two loops for Pi and Pf in the arists
 #while(i<Final-1)   
    //Avoiding repeath the vertex of i
   #declare j=i+1;
   #while (j<Final)
	 #declare Distan=VDist(Arr[i],Arr[j]);   
	 //conditional for avoiding put diagonals in faces and body
	 #if(Distan<Dmax)  
	  //cylinder of POV-Ray, read the bibliography
	  cylinder{Arr[i],Arr[j],Radio texture {pigment {color Kolor}} finish {phong 1}}
	 #end
	 #declare j=j+1;
	#end
  #declare i=i+1;
 #end 
#end 

//cube's positions
#declare a=3;        //cube's edge size
#declare L=a+0.1;
#declare Pos= array [8];
#declare Pos[0]=<a/2,  a/2,  a/2>;
#declare Pos[1]=<-a/2,  -a/2,  -a/2>;
#declare Pos[2]=<-a/2,  -a/2,  a/2>;
#declare Pos[3]=<-a/2,  a/2,  -a/2>;
#declare Pos[4]=<a/2, -a/2,  -a/2>;
#declare Pos[5]=<a/2,  -a/2,  a/2>;
#declare Pos[6]=<-a/2,  a/2,  a/2>;
#declare Pos[7]=<a/2,  a/2,  -a/2>;


// This block is to define the vertices as spheres
PrintSphere(8,Pos,0.4,Blue)

//This block is to calculate the distances among vertices and define edges
HacerCilindros(8,Pos,L,0.1,Green)  






      