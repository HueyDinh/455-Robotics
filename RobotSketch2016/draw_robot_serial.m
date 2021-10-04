function draw_robot_serial(t,d,f,a,j_type,frame_type,j_centered,edges)

%DESCRIPTION                                                                    
%   This function draw a serial robot from the Denavit-Hartenberg parameters.
%
% Conventions:
%    joint - refers to revolute(R), prismatic(P) joints
%  g-joint - refers to revolute(R), prismatic(P), base(B), gripper(G), none (N) "generalized" joints 
%  There are n joints. With a base and a gripper there are (n+2) g-joints
%
%INPUT ARGUMENTS
%   t ---------- theta joint angles in radians                   (n+2 vector)
%   d ---------- joint offsets                                   (n+2 vector)
%   f ---------- alpha twist angles in radians                   (n+2 vector)
%   a ---------- common normal link lengths                      (n+2 vector)
%   j_type ----- g-joint type                                    (n+2 character string)
%                'R' revolute joint, 'P' prismatic joint
%                'B' base   g-joint, 'G' gripper g-joint
%                'N' (or any other character) no g-joint
%   frame_type - type of frame axes to draw
%                'F' fancy axes                                  (n+2 character string)
%                'P' plain axes (faster)
%                'N' (or any other character) no axes
%   j_centered - location of g-joint along offset                (n+2 character string)
%                'T' top    of g-joint at o(i)
%                'C' center of g-joint at o(i)
%                'N' (or any other character) centers g-joint along d(i)
%   edges ------ edge drawing options                            (n+2 character string)
%                'E' draws edges on parts
%                'N' (or any other character) no edges on parts (good for transparent parts)
%
%
%
%
%
%
%OUTPUT ARGUMENTS
%   (none)
%
%FUNCTION CALLS 
%   draw_frame
%   draw_part

%PROGRAM

%BEGIN{USER OPTIONS} - DEFAULTS GOOD FOR MOST APPLICATIONS*********************                                    
%options - good for most applications
part_color  = [1.0000 0.6324 0.4027]; %nice part color with lighting (copper)
R_color     = part_color;      %R joint color
P_color     = part_color;      %P joint color
G_color     = part_color;      %Gripper color
B_color     = part_color;      %Base    color
a_color     = part_color;      %common normal color
d_color     = part_color;      %joint  offset color

sides       = 20;              %number of sides of R joints and round links
R_rad_ratio = 35;              %ratio of total link distance             to R joint radius (main robot scale factor)
a_scale     = 9/16;            %ratio of common normal  link (a)  radius to R joint radius
d_scale     = a_scale;         %ratio of   joint offset link (d)  radius to R joint radius
P_scale     = 1.25;            %ratio of P joint (outer)          radius to R joint radius
R_scale     = 3;               %ratio of   joint height                  to R joint radius
B_bot_scale = 2;               %ratio of pedestal base bottom     radius to R joint radius
B_top_scale = 1.75;            %ratio of pedestal base top        radius to R joint radius
B_ht_scale  = 0.25;            %ratio of pedestal base top&bottom height to R joint radius
ax_scale    = 1.0;             %ratio of coordinate axis height to joint height
%END{USER OPTIONS} - DEFAULTS GOOD FOR MOST APPLICATIONS-----------------------                                    

%BEGIN{SET PARAMETERS}*********************************************************







%set g-joint and link parameters
N         = length(t);         %number of BRPG g-joints, frames, and length of vectors logically indexed from 0 instead of 1 
n         = N-2;               %number of R or P joints
R_rad     = sum(abs([d(2:n+1),a(1:n+1)]))/R_rad_ratio; %R joint radius


P_rad     = R_rad*P_scale;                             %P joint radius
G_rad     = R_rad;                                     %G g-joint (gripper) radius
a_rad     = R_rad*a_scale;     %common normal link (a) radius
d_rad     = R_rad*d_scale;     %joint offset  link (d) radius
B_rad_bot = R_rad*B_bot_scale; %base pedestal bottom radius
B_rad_top = R_rad*B_top_scale; %base pedestal top    radius
B_height  = R_rad*B_ht_scale;  %base pedestal top and bottoms heights
G_height  = d_rad;             %gripper height
j_height  = R_scale*R_rad;     %joint height
ax_height = ax_scale*j_height; %height of coordinate axes

%set options for different g-joints
j_sides   = sides*(j_type=='R'|j_type=='G'|j_type=='B')+4*(j_type=='P'); %select number sides for g-joints
s         = (d>=0)-(d<0);      %nonzero sign of d (+/-1),for properly extending the offsets when negative

%set edge options for different g-joints
edge  = (edges=='E'|edges=='Y')*[(j_type=='R'|j_type=='G'|j_type=='B')-(j_type=='P')]; %1/0/-1 for R,G,B edges/no edges/P edges

%set RPG g-joint locations along offsets d(i) for visual effect

for i=1:n+1                                 %i counts RPG g-joints and frame number
    I = i+1;                                %I indexes vectors logically indexed from 0 instead of 1
    if j_centered(I) == 'T'                 %g-joint top at o(i) (better frame visibility)
        j_min(I) = s(I)* -j_height;         %bottom of g-joint
        j_max(I) = s(I)*0;                  %top    of g-joint
    elseif j_centered(I) == 'C'             %g-joint centered about o(i)
        j_min(I) = s(I)*-j_height/2;        %bottom of g-joint
        j_max(I) = s(I)* j_height/2;        %top    of g-joint
    else                                    %g-joint centered about d(i)
        j_min(I) = s(I)*-j_height/2-d(I)/2; %bottom of g-joint
        j_max(I) = s(I)* j_height/2-d(I)/2; %top    of g-joint
    end %if j_centered
end %for i

%set gripper parameters
G_min = -G_height/2;           %beginning of gripper
G_max =  G_height/2;           %end of gripper at last origin

%alter offset and common normal dimensions for visual effect
%  note: if a(i)=0 or d(i)=0 the parts are not drawn
a_min = 0-a_rad*ones(size(a)); %start of links   (extend by a_rad)
a_max = a+a_rad;               %end   of links   (extend by a_rad)
d_min = -(d+s*d_rad);          %start of offsets (extend by d_rad)
d_max =  (0+s*d_rad);          %end   of offsets (extend by d_rad)
d_min(2) = -d(2);              %don't adjust start of offset i=1   (I=2)
d_max(N) = 0;                  %don't adjust end   of offset i=n+1 (I=N)

%alter offset and common normal dimensions for visual effect due to a gripper
%  this is a bit kludgey but seems to get the most common gripper configurations
if j_type(N) ~= 'G'                                      %no gripper present
    a_max(N-1) =  a(N-1);                                %undo altering end of common normal i=n-1 (I=N-1)
else                                                     %gripper present
    if d(N) == 0                                         %gripper offset is 0, next check if last nonzero link is a(N-1) = a(n)
        if a(N-1) == 0                                   %gripper common normal a(N-1) = a(n) is 0, assume gripper on last joint offset d(N-1)=d(n)
            d_max(N-1) = 0-G_rad*0.75;                   %adjust offset for gripper (retract by 75% of G_rad)
            if d_max(N-1)<j_max(N-1)                     %check if gripper obscured by last joint
                j_max(N-1) = s(N-1)*d_max(N-1);          %shift end   of joint back
                j_min(N-1) = s(N-1)*d_max(N-1)-j_height; %shift start of joint back
            end %if d_max(N)
        else                                             %gripper mounted on the last common normal
            a_max(N-1) = a(N-1)-G_rad*0.75;              %adjust previous offset for gripper (retract by 75% of G_rad)
        end %if a(N-1)
    else                                                 %gripper offset is nonzero
        d_max(N) = -(s(N)*G_height*0.5);                 %adjust last offset for gripper (retract by 50% of G_height)
    end %if d(N)
end %if j_type(N)
%END{SET PARAMETERS}-----------------------------------------------------------

%BEGIN{DRAW FIGURE}************************************************************
%draw base frame and pedestal
Ti = eye(4);                                                                              %base frame     
if (frame_type(1)=='F')|(frame_type(1)=='P');                                             %draw base frame (0th)
     draw_frame(Ti, ax_height,'0', sides, frame_type(1), (edges=='E'));                   %draw it
end %if 
 
if  j_type(1)=='B'                                                                        %draw a base pedestal (0th g-joint)
    draw_part('B', B_rad_bot, j_sides(1),        0,   B_height, edge(1), Ti, B_color)     %draw base pedestal bottom
    draw_part('B', B_rad_top, j_sides(1), B_height, 2*B_height, edge(1), Ti, B_color)     %draw base pedestal top
end %if j_type(1)

%plot robot and frames
for i=1:n+1                                         %i counts the RPG g-joints and frame number beyond base
    I    = i+1;                                     %I indexes vectors logically indexed from 0 instead of 1
    Ti_1 = Ti;                                      %save the previous frame location
    Ti   = Ti_1*DHtrans(a(I-1),f(I-1),d(I),t(I));   %ith frame location

    %draw a(i-1) common normal
    if a(I-1)~=0;                                                                         %don't draw if a(i-1) = 0
        draw_part('a', a_rad, sides, a_min(I-1), a_max(I-1),( edges=='E'), Ti_1, a_color) %draw common normal
    end %if a(I-1)

    %draw d(i) offset
    if d(I)~=0;                                                                           %don't draw if d(i) = 0
        draw_part('d', d_rad, j_sides(I), d_min(I), d_max(I), edge(I), Ti, d_color)       %draw offset
    end %if d(I)
    
    % draw joint(i), gripper(i), or nothing
    if     j_type(I) == 'R'                                                               %R joint
        draw_part(j_type(I), R_rad, j_sides(I), j_min(I), j_max(I), edge(I), Ti, R_color) %draw R joint
    elseif j_type(I) == 'P'                                                               %P joint
        draw_part(j_type(I), P_rad, j_sides(I), j_min(I), j_max(I), edge(I), Ti, P_color) %draw P joint       
    elseif j_type(I) == 'G'                                                               %gripper
        draw_part(j_type(I), G_rad, j_sides(I), G_min,    G_max,    edge(I), Ti, G_color) %draw gripper
    end %j_type
        
    %draw frame(i)
    if (frame_type(I)=='F')|(frame_type(I)=='P');                                         %plot frame(i)
        draw_frame(Ti, ax_height, num2str(i), sides, frame_type(I), (edges=='E'));        %draw frame(i)
    end %if frame_type(i)             
end %for i
%END{DRAW FIGURE}--------------------------------------------------------------
