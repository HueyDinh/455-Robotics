function [B] = DHtrans(length,twist,offset,theta)

%DESCRIPTION
%   This function outputs the Denavit-Hartenberg 4x4 homogeneous
%   transformation matrix for a link using the proximal (Craig-like) convention
%   where the frame is at the beginning of a link.
%
%INPUT ARGUMENTS
%   length ----- common normal link length (scalar)
%   twist  ----- twist angle in radians    (scalar)
%   offset ----- joint offset length       (scalar)
%   theta  ----- joint angle in radians    (scalar)
%
%OUTPUT ARGUMENTS
%   B ---------- homogeneous transformation matrix (4x4)
%
%SUBPROGRAM CALLS 
%   (none)

%PROGRAM

% Form homogeneous transformation matrix for proximal convention
% B = trans(length,0,0) * rot('X',twist) * trans(0,0,offset) * rot('Z',theta);
B = [ cos(theta)            -sin(theta)                 0       length;
      sin(theta)*cos(twist)  cos(theta)*cos(twist) -sin(twist) -offset*sin(twist);
      sin(theta)*sin(twist)  cos(theta)*sin(twist)  cos(twist)  offset*cos(twist);
          0                      0                      0             1           ];
