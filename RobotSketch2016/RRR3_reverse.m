function dh = RRR3_reverse(dh)
% Drexel MEM455 - Introduction to Robotics
% Fall 2021
% RRR3_reverser perform RDA analysis using the end effector's position
% (dh.Xe), link lengths (dh.a), elbow configurations (dh.elbowplus), and base
% positions (dh.p1)
% - dh = structure for the 3RRR robot used in the lab (note a that a COPY with modified attributes is returned) 
%-------------------------------------------------------------------------------
num_leg = size(dh.t,1); % number of legs = number of rows of dh.t (note that an empty dh.t matrix is used in the data_3RRR_default file as a placeholder)
for i=1:num_leg % Loop through each leg
    % Data  re-packaging from dh to sub-objects dh_serial
    offset = dh.t(i,end); % Get the offset from the last entry of row i in dh.t
    dh_serial.Xe = dh.Xe - [0 0 offset]; % Subtract the offset from the effector orientation to get the output orientation. Effector's positiona stored in attribute dh_serial.Xe
    dh_serial.p1 = dh.p1(i,1:2); % Current leg's base position extracted from the first 2 entries (x1,y1) of row i (the third entry is 0) and stored in dh_serial.p1
    dh_serial.a = dh.a(i,:); % Current leg's link length extracted from row i of dh.a and stored in dh_serial.a
    dh_serial.elbowplus = dh.elbowplus(i); % Current leg's elbow config (plus/minus) extracted from row i of dh.elbowplus and stored in dh_serial.elbowplus
    dh.t(i,:) = RRR_reverse(dh_serial); % Apply the RRR_reverse function to the sub-object. RRR_reverse return a row vector containing the joint angles (with a nan entry at index 1 and 0 offset at index 5)
    dh.t(i,end) = offset; % Since RRR_reverse wipe the offset, it is added back in in this line
end
end