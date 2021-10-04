function [q] = data_path12_movie(dh)
%% HEADER                                                                       
%
% Drexel MEM455 - Introduction to Robotics
% Fall 2021
%--------------------------------------------------------------------------
% DESCRIPTION:
%       Generates joint angles that simultaneously moves each R joint from
%       Postion 1 to Position 2 (hard-coded in this function, data structure of 
%       data_RRR does not support multiple sets of angle configurations). 
%
% INPUTS*: (read in as a file)
%       dh = structure containing robot and drawing data 
%
% OUTPUTS:
%       q  = array of joint angles, one row for each robot configuration (in this case, # row = #)
%--------------------------------------------------------------------------
% OTHER INFORMATION:
%       n_inc = number of increments for each joint between the starting
%       joint angle and the final joint angle
%--------------------------------------------------------------------------
%
%% BEGIN{GENERATE JOINT DISPLACEMENTS}******************************************
pos1 = [nan, 30, 45, 15, 0]*pi/180;                                             %Vector defining joint angles in pose 1, same convention as dh.t (first element ignored, last element for gripper)
pos2 = [nan, 105, 45, -60, 0]*pi/180;                                           %Vector defining joint angles in pose 2
n_inc  = 10;                                                                    %number increments for ALL joint (i.e. all joints step through the same increment simultaneously)
N = length(dh.t);
q = zeros(n_inc,N);                                                                    %Output initialized as placeholder array with defined dimensions, no data yet
for i = 1:N
    q(:,i) = linspace(pos1(i),pos2(i),n_inc);
end
%END{GENERATE JOINT DISPLACEMENTS}---------------------------------------------

end

