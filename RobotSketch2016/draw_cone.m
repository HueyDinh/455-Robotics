function draw_cone(radius, n, zmin, zmax, edge, T ,bst_colors)
%DESCRIPTION
%   This function draws a cylinder along the local z axis
%      transforms it to the global position given by T

%STRUCTURE
%   Level 1

%ARGUMENTS
%   radius     - of cylinder (scalar)
%   n          - number of sides (scalar)
%   zmin       - starting height above xy plane (scalar)
%   zmax       - ending height above xy plane (scalar)
%   edge       - if 1 then draw edge
%   T          - 4x4 homogeneous transformation matrix for global location
%   bst_colors - bottom, side, top colors of cylinder

%FUNCTION CALLS [Level]
%   [0] extrude 

%PROGRAM

%Create cylinder
t=linspace(0,2*pi,n+1)+(pi/n);	%generate n evenly spaced vertices, offset by 1/2 a side
x=radius*cos(t);	            %polygon vertex coords
y=radius*sin(t);                %polygon vertex coords

patch_cone(x,y,zmin,zmax,edge,T,bst_colors); %extrude polygon up into a solid

