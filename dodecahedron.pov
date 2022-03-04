/*
This program makes a dodecahedron finding the center on icosahedron's faces.
*/

//used libraries
#include	"colors.inc"		
#include	"textures.inc"	
#include	"shapes.inc"

//set camera and background
camera{                                             
location <-0,0,-10>   
look_at <-0,0,-0>}

light_source {
<100,100, -100>
color	White} 

// Set a color of the background (sky)
background { color rgb< 1, 1, 1> }
                       

//This is the golden ratio. It is used for each point in a icosahedron. 
#declare GR=(1+sqrt(5))/2;

//Dodecahedron arist size
#declare s=3;


//Icosahedron's parameters
#declare a=s/0.539345;   //The size of the icosahedron's arist    
#declare f=a/(-1+sqrt(5));    //Transformation for make the icosahedron the size we want
         


//Dmax is the limit of distance between the icosahedron coordinates 
//so that the program won't make "arists" inside the icosahedron
#declare Dmax=(-1+sqrt(5))*f+0.01; 
//Array with the icosahedron's vertices 
#declare Pos_ico=array[12];
 #declare Pos_ico[0]=f*<1, 0, 1/GR>;
 #declare Pos_ico[1]=f*<1, 0, -1/GR>;
 #declare Pos_ico[2]=f*<-1, 0, 1/GR>;
 #declare Pos_ico[3]=f*<-1, 0, -1/GR>;
 #declare Pos_ico[4]=f*<1/GR, 1, 0>;
 #declare Pos_ico[5]=f*<-1/GR, 1, 0>;
 #declare Pos_ico[6]=f*<0, 1/GR, 1>;
 #declare Pos_ico[7]=f*<0, -1/GR, 1>;
 #declare Pos_ico[8]=f*<1/GR, -1, 0>;
 #declare Pos_ico[9]=f*<-1/GR, -1, 0>;
 #declare Pos_ico[10]=f*<0, 1/GR, -1>;
 #declare Pos_ico[11]=f*<0, -1/GR, -1>;
 


//arrays for points and making the diagonals
#declare n=12; 
#declare vector1=array[n][n];


//size, thickness, and color of figures  
#declare Rs=0.1;    
#declare Rc=5*0.01;
#declare Rc1=0.03;
#declare ts= texture{ pigment{color Blue}};  
#declare tc= texture{ pigment{color Green}};
#declare tc1= texture{ pigment{color Red}};
             
                     



//center in the icosahedron's faces
#declare cont=0;                  //index for saving dodecahedron positions
#declare Pos_dode=array[20];      //array with dodecahedron positions

//DOCECAHEDRON COORDINATES WRITTEN
#fopen dode_positions_file "dodecahedron.txt" write      

/*Icosahedron and dodecahedron have a relation called duality. 
In summary, you can build one of them if you join the face centers of the other one. 
This is the same for the relation cube-octahedron.
*/ 

/*For finding a face in icosahedron, we take 3 points i,j,k.*/
#declare i=0;
#while(i<n-1) 
    #declare j=i+1;
    #while(j<n)  
        #declare distancia=VDist(Pos_ico[i],Pos_ico[j]); 
        #declare k=j+1;
        #while (k<n)
            #declare distancia1=VDist(Pos_ico[k],Pos_ico[i]); 
            //We need to make the condition distance for checking if we are taking close points between them
            #if(distancia<Dmax & distancia1 <Dmax)
                #declare vector1_ico=Pos_ico[j]-Pos_ico[i];
                #declare vector2_ico=Pos_ico[k]-Pos_ico[i];
                #declare angulo=degrees(acos(vdot(vector1_ico,vector2_ico)/((vlength(vector1_ico))*(vlength(vector2_ico)))));      
                //condition for taking 3 points on a face. we could have taken 3 points but not in the same face
                #if (angulo<63) 
                    /*Find the center of a equilateral triangle is simple. start using a corner of the triangle (point i)
                    then go to a second point (j point) until 1/3 of the path (from i to j). Finally go parallel to the path from the first
                    to the third point (from i to k).*/ 
                    #declare Pos_dode[cont]=Pos_ico[i]+(1/3)*(vector1_ico)+(1/3)*vector2_ico;
                    sphere{Pos_dode[cont], Rs texture {tc1} finish{phong 1}}
                    #write(dode_positions_file,"C"," " ,vstr(3,Pos_dode[cont]," ",5,7),"\n")
                    #declare cont=cont+1;
                #end
            #end
            #declare k=k+1;
        #end 
        #declare j=j+1;
    #end 
    #declare i=i+1;
#end 
#fclose dode_positions_file


//generate icosahedron divisions on arists
//Two points are taking using two loops    
#fopen leght_arist "distances_between_points.txt" write   //File for checking arists length 
#write(leght_arist,"Point A", "     ","Point B", "      ","Distance", "\n")

#declare i=0;                              
#while(i<19) 
    //j so we do not take the same point for i
    #declare j=i+1;
    #while(j<20)
        //Distance   
        #declare distancia=VDist(Pos_dode[i],Pos_dode[j]); 
        //#declare vector1[i][j]=Pos_dode[j]-Pos_dode[i];
        //Conditional for distance between points
        #if(distancia<Dmax/GR)
            //saving the distances for checking if they are equal 
            #write(leght_arist,"   ",i+1, "            ", j+1, "          ", distancia, "\n")                                                                          
            cylinder{Pos_dode[i],Pos_dode[j],Rc texture {tc} finish{phong 1}}
        #end
        #declare j=j+1;
    #end 
    #declare i=i+1;
#end     
#fclose leght_arist           