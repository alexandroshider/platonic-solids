/*
20/12/19
This program generates a octahedron inside a cube computing the 
center on cube's faces.

*/

//used libraries
#include	"colors.inc"		
#include	"textures.inc"	
#include	"shapes.inc"

//set camera and background
camera{
location <2.9,1.25,-1.75>   
look_at <0,-0.25,0>}

light_source {
<1000,0, 0>
color	White}
  
light_source {
<0,1000, -1000>
color	White} 

// Set a color of the background (sky)
background { color rgb< 1, 1, 1> }  


//file with the coords of octahedron saved
#fopen octaep "octaedros.dat" write  
  
  
#declare oct_arist=2;                     //octahedron arist size
#declare a=sqrt(2)*oct_arist;             //Measure of the cube's arist

#declare Dmax=a+0.1;         
#declare edge1=array[8][8];
#declare edge2=array[8][8];
#declare Pos_oct=array[10];
           
//These are cube vertices 
#declare Pos_cube= array [8];              
#declare Pos_cube[0]=<a/2,  a/2,  a/2>;
#declare Pos_cube[1]=<-a/2,  -a/2,  -a/2>;
#declare Pos_cube[2]=<-a/2,  -a/2,  a/2>;
#declare Pos_cube[3]=<-a/2,  a/2,  -a/2>;
#declare Pos_cube[4]=<a/2, -a/2,  -a/2>;
#declare Pos_cube[5]=<a/2,  -a/2,  a/2>;
#declare Pos_cube[6]=<-a/2,  a/2,  a/2>;
#declare Pos_cube[7]=<a/2,  a/2,  -a/2>;


//center in cube's faces (octahedron vertices)
#declare h=0;                                                            
/*
We count only i=0,1 in the array because they are oppos_cubeite vertices 
in our cube that we declared in the Pos_cube array. So with both points 
we can found the six centers going with a triple loop.
I get a error if the vertes 0,1 in a cube are not against each other.
This is that the line that join them go through in the cube.           

The triple loop is for select three vertices of the cube.
*/ 
#declare i=0;              
#while(i<2) 
    #declare j=i+1;   
    #while(j<7)  
        #declare distancia=VDist(Pos_cube[i],Pos_cube[j]);  
        #declare k=j+1;
        #while (k<8)
            #declare distancia1=VDist(Pos_cube[k],Pos_cube[i]); 
            //Conditional for verify that the three joined points
            //are in the same face by checking they are not joined 
            //with a straight line larger that the cube's arist (Dmax).
            #if(distancia<Dmax & distancia1 <Dmax)
                //Vectors of cube's edge
                #declare edge1[i][j]=Pos_cube[j]-Pos_cube[i];
                #declare edge2[i][k]=Pos_cube[k]-Pos_cube[i];   
                /*
                We start in one of the vertices 0 or 1, then we go along one arist until the middle.
                Next we go until middle in the other arist. 
                */
                #declare Pos_oct[h]=Pos_cube[i]+(1/2)*(edge1[i][j])+(1/2)*edge2[i][k];
                sphere{Pos_oct[h], 0.1 texture{pigment {color Red}} finish{phong 1}}  
                //save positions in a data file
                #write (octaep,"H"," ",vstr(3,Pos_oct[h]," ",7,5),"\n") 
                #declare h=h+1;    
            #end
            #declare k=k+1;
        #end 
        #declare j=j+1;
    #end 
    #declare i=i+1;
#end     

//generate octahedron's arists using cilinders 
#declare i=0;        
#while(i<5)
    #declare j=i+1; 
    #while(j<6)
        #declare distan=VDist(Pos_oct[i],Pos_oct[j]); 
        //conditional for avoid cylinders inside the octahedron.
        #if(distan<a/2*sqrt(2)+.1)
            cylinder{Pos_oct[i],Pos_oct[j], 0.05 texture {pigment {color Green}} finish{phong 1}}         
        #end  
        #declare j=j+1;     
    #end  
    #declare i=i+1;   
#end        