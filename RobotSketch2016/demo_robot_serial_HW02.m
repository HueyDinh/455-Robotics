%% SCRIPT demo_robot_serial                                                     
%
% Drexel MEM455 - Introduction to Robotics
% Fall 2021
%--------------------------------------------------------------------------
% DESCRIPTION:
%       Draws a serial robot from the data file specified by dh_robot_data
%
% INPUTS: (read in as a file)
%       dh_robot_data = specifies SCRIPT containing Denavit-Hartenberg parameters and options 
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

  dh_robot_data = 'data_RRR_lab';                                               %load dh parameters and options from data file (SCRIPT)
% dh_robot_data = 'data_RRR_lab_modified';                                      %load dh parameters and options from data file (SCRIPT)

eval(dh_robot_data);                                                            %default dh parameters and options
%END{USER DATA}----------------------------------------------------------------                                   
%% BEGIN{NEW FIGURE}************************************************************
figure                                                                          %open new window
hold on                                                                         %keep open to plot multiple links, joints, frames, etc.
axis equal                                                                      %maintain realistic dimensions
grid                                                                            %looks good
%view(3)                                                                         %usually a good 3D viewpoint
view(2)                                                                         %x-y planar view
%END{NEW FIGURE}---------------------------------------------------------------
%% BEGIN{DRAW ROBOT}************************************************************
draw_robot_serial(dh.t,dh.d,dh.f,dh.a,dh.joint.type,dh.frame.type,dh.joint.centered,dh.part.edges)
%END{DRAW ROBOT}---------------------------------------------------------------
%% BEGIN{FIGURE LIGHTING}*******************************************************
lighting phong                                                                  %smooth lighting (use Gouraud for speed)
material shiny                                                                  %also try default, dull, metal
lightangle(12,48);                                                              %good light angle for view(2) and view(3)
alpha(dh.part.alpha)                                                            %transparency (0 to 1)
%END{FIGURE LIGHTING}----------------------------------------------------------