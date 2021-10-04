function [B] = rot(dir,angle)

%DESCRIPTION
%   This function outputs a 4x4 homogeneous transformation matrix 
%   for a rotation about the x,y, or z directions,
%   {or about an arbitrary axis (to be implemented).}
%
%INPUT ARGUMENTS
%   dir -------- 'X', 'Y', 'Z' directions               (character)
%                {or directional coordinates of an axis (vector) - to be implemented}
%   ang -------- angle of rotation in radians           (scalar)
%
%OUTPUT ARGUMENTS
%   B - homogeneous transformation matrix (4x4)
%
%SUBPROGRAM CALLS 
%   (none)

%PROGRAM

%select axis of rotation and form homogeneous transformation matrix
if ischar(dir)                                  %rotation about x, y, or z axes
    dir = upper(dir);                           %change to upper case
    switch dir                                  %select x, y, or z axis
        
        case{'X'}                               %x axis
            B = ...                             %transformation matrix
                [ 1 0           0          0 ;
                  0 cos(angle) -sin(angle) 0 ;
                  0 sin(angle)  cos(angle) 0 ;
                  0 0           0          1 ];
              
        case{'Y'}                               %y axis
            B = ...                             %transformation matrix
                [ cos(angle)  0 sin(angle) 0 ;
                  0           1 0          0 ;
                 -sin(angle)  0 cos(angle) 0 ;
                  0           0 0          1 ];
              
        case{'Z'}                               %z axis
            B = ...                             %transformation matrix
                [ cos(angle) -sin(angle) 0 0 ; 
                  sin(angle)  cos(angle) 0 0 ;    
                  0           0          1 0 ;     
                  0           0          0 1 ];
    end %switch dir
else                                           %rotation about axis given by dir
            B = eye(4)                         %dummy - code to be added
end %if ischar


