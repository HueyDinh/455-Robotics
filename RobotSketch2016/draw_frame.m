function draw_frame(T, L, sub, n, axes_style,edge)

%DESCRIPTION
%   This function draws a coordinate frame 
%   located by a homogeneous transformation matrix T.
%
%INPUT ARGUMENTS
%   T ---------- homogeneous transformation matrix (4x4)
%   L ---------- length of an axis    (scalar)
%   sub -------- subscript            (character string)
%   n ---------- number of cross-sectional vertices for a fancy axis
%   axes_style - 'Fancy' 3D   axes    (character string)
%                'Plain' line axes
%   edge ------- edge drawing options (scalar)
%                1 - some edges, 0 - no edges, other - all edges
%
%OUTPUT ARGUMENTS
%   (none)
%
%FUNCTION CALLS 
%   draw_cylinder
%   draw_cone

%PROGRAM

%BEGIN{INITIALIZATIONS}********************************************************
%extract location data
O3 = repmat(T(1:3,4),1,3);                                     %replicate origin coords into 3 cols
R = T(1:3,1:3);                                                %extract unit vectors in x,y,z directions
%END{INITIALIZATIONS}----------------------------------------------------------

%BEGIN{SELECT STYLE AND DRAW FRAMES}*******************************************
if axes_style == 'F'                                           %Fancy 3D style coordinate axes
    
    %BEGIN{FANCY FRAMES - INITIALIZATIONS}*************************************
    %data - good for most cases
    x_color   = [0 0 1];                                       %x axis color (blue)
    y_color   = [0 1 0];                                       %y axis color (green)
    z_color   = [1 0 0];                                       %z axis color (red)
    
    %set style parameters - good for most cases
    radius_sh =  L/20;                                         %axis shaft radius
    zmin_sh   = -radius_sh;                                    %axis shaft start - extend for better symmetry around origin
    zmax_sh   = L-4*radius_sh;                                 %axis shaft end   - allow space for arrowhead

    radius_ah = 1.60*radius_sh;                                %arrowhead  radius
    zmin_ah   = zmax_sh;                                       %arrowhead  start - at end of axis
    zmax_ah   = zmax_sh+4*radius_sh;                           %arrowhead  end   - at length L
    
    %set arrowhead parameters
    t         = linspace(0,2*pi,n+1)+(pi/n);	               %generate n evenly spaced vertices, offset by 1/2 a side
    x_ah      = radius_ah*cos(t);	                           %arrowhead vertex coords
    y_ah      = radius_ah*sin(t);                              %arrowhead vertex coords
    %END{FANCY FRAMES -  INITIALIZATIONS}---------------------------------------

    %BEGIN{FANCY FRAMES - DRAW AXES}********************************************
    Tx = T*rot('y', pi/2);                                     %rotates x axis into z axis
    Ty = T*rot('x',-pi/2);                                     %rotates y axis into z axis
    draw_cylinder(radius_sh,n,zmin_sh,zmax_sh,edge,Tx,x_color) %plot x axis shaft
    draw_cylinder(radius_sh,n,zmin_sh,zmax_sh,edge,Ty,y_color) %plot y axis shaft                       
    draw_cylinder(radius_sh,n,zmin_sh,zmax_sh,edge,T ,z_color) %plot z axis shaft 
    draw_cone(    radius_ah,n,zmin_ah,zmax_ah,edge,Tx,x_color) %plot x arrowhead
    draw_cone(    radius_ah,n,zmin_ah,zmax_ah,edge,Ty,y_color) %plot y arrowhead                       
    draw_cone(    radius_ah,n,zmin_ah,zmax_ah,edge,T ,z_color) %plot z arrowhead 
    %END{FANCY FRAMES -  DRAW AXES}---------------------------------------------

else                                                           %simple axes using lines
    %BEGIN{PLAIN FRAMES - DRAW AXES}********************************************
    x = [O3(1,:);O3(1,:)+ L*R(1,1:3)];                         %x coords of x,y,z axis lines
    y = [O3(2,:);O3(2,:)+ L*R(2,1:3)];                         %y coords of x,y,z axis lines
    z = [O3(3,:);O3(3,:)+ L*R(3,1:3)];                         %z coords of x,y,z axis lines
    line(x, y, z,'Marker','.','MarkerSize',12,'LineWidth',1)   %plot axes
    plot3(T(1,4),T(2,4),T(3,4),'Marker','.','MarkerSize',12,'Color','k')  %plot origin
    %END{PLAIN FRAMES -  DRAW AXES}---------------------------------------------
    
end %if
%END{SELECT STYLE AND DRAW FRAMES}----------------------------------------------

%BEGIN{PLOT LABELS}*************************************************************
x_l = [O3(1,:)+ L*R(1,1:3)];                                   %x coords of x,y,z axes ends
y_l = [O3(2,:)+ L*R(2,1:3)];                                   %y coords of x,y,z axes ends
z_l = [O3(3,:)+ L*R(3,1:3)];                                   %z coords of x,y,z axes ends
ss  = ['_{',sub,'}'];                                          %add subscript 
text(x_l,y_l,z_l,[['{\it x}',ss];['{\it y}',ss];['{\it z}',ss]]) %plot labels
%END{PLOT LABELS}---------------------------------------------------------------
