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
%       q  = array of joint angles, one row for each robot configuration 
%            (in this case, # row = # traces, # column = # joints)
%--------------------------------------------------------------------------
% OTHER INFORMATION:
%       n_inc = number of increments for each joint between the starting
%       joint angle and the final joint angle
%--------------------------------------------------------------------------
%
%% BEGIN{GENERATE JOINT DISPLACEMENTS}******************************************
pos2 = [nan, 105, 45, -60, 0]*pi/180;                                           % Vector defining joint angles in pose 2, same convention as dh.t (first element ignored, last element for gripper)
pos3 = [nan, 150, -45, -15, 0]*pi/180;                                          % Vector defining joint angles in pose 3
n_inc  = 10;                                                                    % Number of increments for ALL joint including start and end positions (i.e. all joints step through the same increment simultaneously)
N = length(dh.t);                                                               % Read the dimension of configuration space (i.e., the number of joints)
q = zeros(n_inc,N);                                                             % output initialized as placeholder array with defined dimensions, no data yet
for i = 1:N                                                                     % Loop through each joint. Joints assigned index i based on the order they appear in dh.t
    q(:,i) = linspace(pos2(i),pos3(i),n_inc);                                   % Generate an evenly spaced array from pos 2 to pos 3 of joint i (with n_inc elenments) and use that array to fill the column associated with joint i
end
%END{GENERATE JOINT DISPLACEMENTS}---------------------------------------------

end

