%function draw_part(part_type, radius, n, zmin, zmax, edge, T, part_color, varargin)
clear all
x = [0 1 1 0];
y = [0 0 1 1];
part_type='H';
radius = 0.25;
n = 4;
zmin = 0.1;
zmax = -zmin;
edge = 1;
T = eye(4);
part_color = [1.0000 0.6324 0.4027];
%DESCRIPTION
%   This function forms a planar polygon profile,
%   extrudes it into a part along the normal direction, 
%   and displaces the part using a homogenous transformation matrix.
%
%INPUT ARGUMENTS
%   part_type -- 'A' common normal,  'D' offset           (character)
%                'R' revolute joint, 'P' prismatic joint
%                'B' base   g-joint, 'G' gripper g-joint
%   radius ----- cross-sectional radius                   (scalar)
%                (max radius for P joint)
%   n ---------- number of cross-sectional vertices
%   zmin ------- z coordinate of part bottom              (scalar)
%   zmax ------- z coordinate of part top                 (scalar)
%   edge ------- edge drawing options                     (scalar)
%   T ---------- homogeneous transformation matrix        (4x4)
%   part_color - bottom/side/top RGB colors of parts      (3x1 or 3x3)
%
%   varargin:
%   (1) x ------ x coordinates of polygon vertices        (vector)
%   (2) y ------ y coordinates of polygon vertices        (vector)
%
%OUTPUT ARGUMENTS
%   (none)
%
%FUNCTION CALLS 
%   patch_cylinder

%PROGRAM

%BEGIN{INITIALIZATIONS}********************************************************
%if length(varargin) == 2               %x and y polygon coordinates inputted
%    x = varargin(1);                   %x coordinate
%    y = varargin(2);                   %y coordinate
%else                                   %create polygon in local x,y plane
%    t = linspace(0,2*pi,n+1)+(pi/n);   %generate n evenly spaced vertices, offset by 1/2 side
%    x = radius*cos(t);	               %polygon vertex coords
%    y = radius*sin(t);                 %polygon vertex coords
%end %if
%END{INITIALIZATIONS}----------------------------------------------------------

%BEGIN{DRAW PARTS}*************************************************************
%select and draw parts
part_type = upper(part_type);          %part_type change to upper case
switch part_type                       %set up for extrusion along local z axis
    case {'D','A'}                     %common normal a(i) or joint offset d(i)(already along local z axis)
        if part_type == 'A'            %common normal a(i)
            T = T*rot('y',pi/2);       %rotate x into z axis
        end %if part_type   
    case {'R','P','B'}                 %R,P,or B g-joint (already along local z axis)
    case {'G'}                         %move points to create a gripper profile
        n2  = floor(n/4);              %number of points to move in x,y and x,-y quadrants
        ypos = [1:n2];                 %points to move in x, y quadrant
        yneg = [n:-1:n-n2+1];          %points to move in x,-y quadrant

        x(:,ypos) = -x(:,ypos)/2;      %shift x coords to make inside of gripper (x, y quadrant)
        y(:,ypos) =  y(:,ypos)/2;      %shift y coords to make inside of gripper (x, y quadrant)
        x(:,yneg) = -x(:,yneg)/2;      %shift x coords to make inside of gripper (x,-y quadrant)
        y(:,yneg) =  y(:,yneg)/2;      %shift y coords to make inside of gripper (x,-y quadrant)
        x(:,n+1)  =  x(:,1);           %make first and last point the same to close the polygon
        y(:,n+1)  =  y(:,1);           %make first and last point the same to close the polygon
    case {'H'}                         %general polygon link with cutout for gripper
        %add points near gripper to form cutout
        j2g(1,:) = x(n)-x(1:n-1);        %x coord of vectors from joint vertices to gripper vertex
        j2g(2,:) = y(n)-y(1:n-1);        %y coord of vectors from joint vertices to gripper vertex
        dir_j2g  = j2g./repmat(sqrt(dot(j2g,j2g)),2,1);   %normalize vectors
        p = [x(1:n-1);y(1:n-1)]+(j2g-radius/2*dir_j2g);   %n-1 new points to be hidden by gripper
        p = fliplr(p);                                    %reverse order of new points
        x = [x(1:n-1),p(1,:),x(1)];                       %add on new points and close polygon
        y = [y(1:n-1),p(2,:),y(1)];                       %add on new points and close polygon        


end %switch
patch_cylinder(x,y,zmin,zmax,edge,T,part_color); %extrude polygon up into a solid
%END{DRAW PARTS}---------------------------------------------------------------




