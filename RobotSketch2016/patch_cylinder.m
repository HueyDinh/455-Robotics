function patch_cylinder(x,y,zmin,zmax,edge,T,bst_colors)

%DESCRIPTION
%   This function takes an planar polygon profile,
%   extrudes it into a cylinder along the normal direction, 
%   and displaces the cylinder using a homogenous transformation matrix.
%
%   Uses the "patch" function method by specifying the coordinates of each unique vertex and a
%   matrix that specifies how to connect these vertices to form the faces.
%
%INPUT ARGUMENTS
%   x ---------- x coordinates of polygon vertices (vector)
%   y ---------- y coordinates of polygon vertices (vector)
%   zmin ------- z coordinate of cylinder bottom   (scalar)
%   zmax ------- z coordinate of cylinder top      (scalar)
%   T ---------- homogeneous transformation matrix (4x4)
%   edge ------- edge drawing options (scalar)
%   bst_colors - bottom/side/top RGB colors of cylinders (3x1 or 3x3)
%
%OUTPUT ARGUMENTS
%   (none)
%
%SUBPROGRAM CALLS 
%   (none)

%PROGRAM

%BEGIN{INITIALIZATIONS}********************************************************
%set colors
if  size(bst_colors) == [3 3];           %separate colors for bottom, side, and top of extrusion
    bottom_color = bst_colors(1,:);      %color for bottom of extrusion
    side_color   = bst_colors(2,:);      %color for side   of extrusion
    top_color    = bst_colors(3,:);      %color for top    of extrusion
else                                     %one color       for bottom, side, and top of extrusion    
    bottom_color = bst_colors;           %color for bottom of extrusion
    side_color   = bst_colors;           %color for side   of extrusion
    top_color    = bst_colors;           %color for top    of extrusion
end %if size(bst_colors)
    
%set edges (default is black)
if edge == 1                             %draw  top and bottom edges only (R joint w/edges)
    t_edgecol = 'k';                     %black top    edges
    s_edgecol = 'none';                  %no    side   edges
    b_edgecol = 'k';                     %black bottom edges
elseif edge == 0                         %draw  no     edges (good for partial transparency)
    t_edgecol = 'none';                  %no    top    edges
    s_edgecol = 'none';                  %no    side   edges
    b_edgecol = 'none';                  %no    bottom edges
else                                     %draw  all    edges (P joint w/edges)
    t_edgecol = 'k';                     %black top    edges
    s_edgecol = 'k';                     %black side   edges
    b_edgecol = 'k';                     %black bottom edges
end %if edge
    
%reshape polygon data
n = length(x);                           %number of vertices
x = reshape(x,n,1);                      %make x a column vector
y = reshape(y,n,1);                      %make y a column vector
zbottom(1:n,:) = zmin;                   %make z coords for extrusion bottom
ztop(1:n,:)    = zmax;                   %make z coords for extrusion top

%extract rotation and translation
Rt = T(1:3,1:3)';                        %rotation matrix transposed
pt = repmat(T(1:3,4)',[n,1]);            %position vector transposed and replicated n times
%END{INITIALIZATIONS}----------------------------------------------------------

%BEGIN{DRAW CYLINDER PATCHES}**************************************************
%create vertices for top and bottom of extrusion
vertex_matrix_bottom = [x,y,zbottom]*Rt+pt;     %all bottom vertices
vertex_matrix_top    = [x,y,ztop]   *Rt+pt;     %all top vertices

%create face matrix for top and bottom of extrusion
face_matrix_bottom   = 1:n;                     %bottom is a single patch
face_matrix_top      = 1:n;                     %top    is a single patch

%draw bottom face
patch('Vertices',vertex_matrix_bottom,...
      'Faces'            ,face_matrix_bottom,...
      'FaceVertexCData'  ,repmat(bottom_color,[length(face_matrix_bottom),1]),...
      'FaceColor'        ,'interp',...
      'EdgeColor'        ,b_edgecol...
      ) %end patch

%draw top face
patch('Vertices'         ,vertex_matrix_top,...
      'Faces'            ,face_matrix_top,...
      'FaceVertexCData'  ,repmat(bottom_color,[length(face_matrix_top),1]),...
      'FaceColor'        ,'interp',...
      'EdgeColor'        ,t_edgecol...
      ) %end patch

%create vertex matrix (2n x 3) for sides of extrusion (n rectangular patches)
vertex_matrix_side   = [vertex_matrix_bottom; vertex_matrix_top];

%create face matrix for sides of extrusion (n rectangular patches)
face_matrix_side     = [face_matrix_bottom;              %bottom vertices (unshifted)
                        face_matrix_bottom(:,[2:n,1]);   %bottom vertices shifted by one
                        face_matrix_top(:,[2:n,1])+n;    %top vertices above the bottom vertices shifted by one
                        face_matrix_top+n]';             %top vertices above the bottom vertices (unshifted)
                
%draw side faces
patch('Vertices'         ,vertex_matrix_side,...
      'Faces'            ,face_matrix_side,...
      'FaceVertexCData'  ,repmat(side_color,[length(vertex_matrix_side),1]),...
      'FaceColor'        ,'interp',...
      'EdgeColor'        ,s_edgecol...
      ) %end patch
%END{DRAW CYLINDER PATCHES}----------------------------------------------------

               
