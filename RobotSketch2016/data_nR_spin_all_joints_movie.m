function [q] = data_nR_spin_all_joints_movie(dh)
%% HEADER                                                                       
%
% Drexel MEM455 - Introduction to Robotics
% Fall 2021
%--------------------------------------------------------------------------
% DESCRIPTION:
%       Generates joint angles that sequentially moves each R joint through
%            360 degrees. Probably get weird results for P joints!
%
% INPUTS: (read in as a file)
%       dh = structure containing robot and drawing data 
%
% OUTPUTS:
%       q  = array of joint angles, one row for each robot configuration
%--------------------------------------------------------------------------
% OTHER INFORMATION:
%       n_inc = number of increments for each joint between 0 and 2*pi
%--------------------------------------------------------------------------
%
%% BEGIN{GENERATE JOINT DISPLACEMENTS}******************************************
n_inc  = 9;                                                                     %number increments for each joint
q_inc  = linspace(0,2*pi,n_inc);                                                %simple motion - rotate each joint sequentially by 2pi
N      = length(dh.t);                                                          %number of joints (0...n+1) specifed
n      = N-1;                                                                   %last joint index; logically indexed from 0 
n_pose = (n-1)*n_inc;                                                           %number of poses
q      = repmat(zeros(1,N),[n_pose,1]);                                         %array of initial poses
c_pose = 0;                                                                     %pose counter
for i = 1:(n-1)                                                                 %for each moving joint (base is 0th joint, gripper is nth joint)
    I = i+1;                                                                    %joint vector index
        for j = 1:n_inc                                                         %draw robot thru motion range
            c_pose = c_pose+1;                                                  %pose displacement counter
            q(c_pose,I) = q(c_pose,I)+q_inc(j);                                 %update ith joint to jth displacement
        end %j
end %i
%END{GENERATE JOINT DISPLACEMENTS}---------------------------------------------

end

