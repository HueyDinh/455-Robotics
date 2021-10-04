function [B] = trans(x, y, z)

%DESCRIPTION
%   This function outputs a 4x4 homogeneous transformation matrix 
%   for a given x,y,z translation.
%
%INPUT ARGUMENTS
%   x ---------- x displacement (scalar)
%   y ---------- y displacement (scalar)
%   z ---------- z displacement (scalar)
%
%OUTPUT ARGUMENTS
%   B - homogeneous transformation matrix (4x4)
%
%SUBPROGRAM CALLS 
%   (none)

%PROGRAM

% Form homogeneous transformation matrix [B].
B = ...
[ 1 0  0 x ;
  0 1  0 y ;
  0 0  1 z ; 
  0 0  0 1 ];
