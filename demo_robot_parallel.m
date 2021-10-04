%% SCRIPT demo_robot_parallel_lab                                               
%
% Drexel MEM455 - Introduction to Robotics 
% FALL 2021
%--------------------------------------------------------------------------
% DESCRIPTION:
%       Draws a parallel robot from data file specified by dh_robot_data
%
% INPUTS: (read in as a file)
%       dh_robot_data = specifies file containing Denavit-Hartenberg parameters and options, 
%            (see data_3RRR_lab.m for structure format example)
%
% OUTPUTS:
%       None
%--------------------------------------------------------------------------
% OTHER INFORMATION:
%       None
%--------------------------------------------------------------------------
%
%% BEGIN{USER DATA}*************************************************************
%clean up
clear all                                                                       %clear the workspace

%filename for dh parameters and options (SCRIPT)
%dh_robot_data = 'data_3RRR_lab';                                                %3RRR in home pose
dh_robot_data = 'data_3RRR_default';                                            %3RRR in home pose

%input data and set parameters
eval(dh_robot_data);                                                            %input dh parameters and options
%END{USER DATA}----------------------------------------------------------------                                                                                               
%% BEGIN{NEW FIGURE}************************************************************
figure                                                                          %open new window
hold on                                                                         %keep open to plot multiple links, joints, frames, etc.
axis equal                                                                      %maintain realistic dimensions
grid                                                                            %looks good
view(3)                                                                         %usually a good viewpoint
%END{NEW FIGURE}---------------------------------------------------------------
%% BEGIN{DRAW ROBOT}************************************************************
%robot scale parameters
L           = size(dh.t,2);                                                     %number of g-joints
R_rad_ratio = 35;                                                               %ratio of total link distance to R joint radius (main robot scale factor)
R_rad       = sum(abs([dh.d(1,2:L),dh.a(1,1:L-1)]))/R_rad_ratio;                %size R joint radius to overall length estimate

%draw legs
draw_robot_serial4(dh.t(1,:),dh.d(1,:),dh.f(1,:),dh.a(1,:),...                  %draw serial robot 1 (contains platform)
                   dh.joint.type(1,:),dh.frame.type(1,:),dh.joint.centered(1,:),...
                   dh.part.edges,R_rad,dh.T{1},dh.Hx,dh.Hy)                     
draw_robot_serial4(dh.t(2,:),dh.d(2,:),dh.f(2,:),dh.a(2,:),...                  %draw serial robot 2
                   dh.joint.type(2,:),dh.frame.type(2,:),dh.joint.centered(2,:),...
                   dh.part.edges,R_rad,dh.T{2})
draw_robot_serial4(dh.t(3,:),dh.d(3,:),dh.f(3,:),dh.a(3,:),...                  %draw serial robot 3
                   dh.joint.type(3,:),dh.frame.type(3,:),dh.joint.centered(3,:),...
                   dh.part.edges,R_rad,dh.T{3})
%END{DRAW ROBOT}---------------------------------------------------------------
%% BEGIN{FIGURE LIGHTING}*******************************************************
lighting phong                                                                  %smooth lighting (use Gouraud for speed)
material shiny                                                                  %also try default, dull, metal
lightangle(-37.5,30);                                                           %good light angle for view(3)
alpha(dh.part.alpha)                                                            %transparency (0 to 1)
%END{FIGURE LIGHTING}----------------------------------------------------------