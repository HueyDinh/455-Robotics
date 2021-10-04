function [q] = data_nR_spin_first_joint_movie(dh)
%% HEADER                                                                       
%
% Drexel MEM455 - Introduction to Robotics
% Fall 2021
%--------------------------------------------------------------------------
% DESCRIPTION:
%       Generates joint angles that sequentially moves the first R joint through
%            360 degrees. Probably gets weird results for P joints!
%
% INPUTS: (read in as a file)
%       dh = structure containing robot and drawing data 
%
% OUTPUTS:
%       q  = array of joint angles, one row for each robot configuration
%--------------------------------------------------------------------------
% OTHER INFORMATION:
%       n_inc = number of increments for joint 1 between 0 and 2*pi
%--------------------------------------------------------------------------
%
%% BEGIN{GENERATE JOINT DISPLACEMENTS}******************************************
n_inc  = 9;                                                                     %number increments for joint 1
n_pose = n_inc+1;                                                               %number of poses (1st and last are the same)
q_inc  = linspace(0,2*pi,n_pose);                                               %simple motion - rotate each joint sequentially by 2pi
N      = length(dh.t);                                                          %number of joints (0...n+1) specified
n      = N-1;                                                                   %last joint index; logically indexed from 0 
q      = repmat(dh.t,[n_pose,1]);                                               %initialize an array of poses all specified by dh.t
i = 1;                                                                          %moving joint 1 only (base is 0th joint)
I = i+1;                                                                        %joint 1 index in dh.t
for j = 1:n_pose                                                                %draw robot thru motion range
    q(j,I) = q(j,I)+q_inc(j);                                                   %update ith joint to jth displacement
end %j
%END{GENERATE JOINT DISPLACEMENTS}---------------------------------------------

end

