/*
Icosahedron from a cube. 
The icosahedron has the arists divided
The faces have the faces divided

*/                                                                

//used libraries
#include	"colors.inc"		
#include	"textures.inc"	
#include	"shapes.inc"

//set camera and background
camera{                                             
location <-0,0,-10>   
look_at <-1,0,-1>}

light_source {
<100,100, -100>
color	White} 

// Set a color of the background (sky)
background { color rgb< 1, 1, 1> }
                       

//This is the golden ratio. It is used for each point in a icosahedron. 
#declare GR=(1+sqrt(5))/2;


//Icosahedron's parameters
#declare a=3;   //The size of the icosahedron's arist   

//In this file I gonna save ALL THE POINTS 
#fopen all_points "all_points_vertices_arists_faces.txt" write 



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



//****************************************************
//generate icosahedron with spheres
#fopen ico_positions "icosahedron_positions.txt" write   //File with the icosahedron
                                                         //positions saved   
                                                         
                                                         
#declare i=0;
#while(i<n) 
    sphere{Pos_ico[i], 0.1 texture{tc1} finish{phong 1}}
    #write(ico_positions,"C"," " ,vstr(3,Pos_ico[i]," ",5,7),"\n")
    #declare i=i+1;
#end    
#fclose ico_positions
                  
//yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy

//generate icosahedron divisions on arists
//Two points are taking using two loops    
#fopen leght_arist "distances_between_points.txt" write   //File for checking arists length 

#write(leght_arist,"Point A", "     ","Point B", "      ","Distance", "\n")

#declare i=0;                              
#while(i<n-1) 
    //j so we do not take the same point for i
    #declare j=i+1;
    #while(j<n)
        //Distance   
        #declare distancia=VDist(Pos_ico[i],Pos_ico[j]);
        //Vector parallel to the arist 
        #declare vector1[i][j]=Pos_ico[j]-Pos_ico[i];
        //Conditional for distance between points
        #if(distancia<Dmax)
            //Third loop for find points ON the arist.
            //saving the distances for checking if they are equal 
            #write(leght_arist,"   ",i+1, "            ", j+1, "          ", distancia, "\n")                                                                          
            cylinder{Pos_ico[i],Pos_ico[j],Rc texture {tc} finish{phong 1}}
        #end
        #declare j=j+1;
    #end 
    #declare i=i+1;
#end
#fclose vertex_and_arists 
#fclose leght_arist


                                             