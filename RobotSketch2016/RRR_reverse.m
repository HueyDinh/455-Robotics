function dht = RRR_reverse(dh) % Reverse Displacement Analysis
% Input: dh - Data structure containing serial manipulator's information
% Output: dht - A row vector containing the joint angles (note: index 1 (ground)
% = nan, last index (offset angle) = 0)
a1 = dh.a(2); % Extract the link length from dh.a
a2 = dh.a(3);
a3 = dh.a(4);
x_e = dh.Xe(1); % Extract the end-effector location from dh.Xe
y_e = dh.Xe(2);
phi = dh.Xe(3);

p3 = [x_e y_e] - a3*[cos(phi) sin(phi)]; % Calculate the ABSOLUTE coordinate of Joint 3
p3_1 = p3 - dh.p1; % Calculate coordinate of joint 3 relative to joint 1
l3_1 = norm(p3_1); % Calculate the distance between Joint 3 and Joint 1
alpha_1 = atan2(p3_1(2),p3_1(1)); % Calculate the angle between the long side of the triangle (Joint 3 - Joint 1) and the positive x axis
gamma_1 = acos((a1^2 + l3_1^2 - a2^2)/(2*a1*l3_1)); % Calculate the angle between the long side and link 1.
gamma_2 = acos((a1^2 + a2^2 - l3_1^2)/(2*a1*a2)); % Calculate the angle between link 1 and link 2 (NOT theta 2, triangle internal angle)

if dh.elbowplus % If elbowplus is set to 1 (true)
    t1 = alpha_1 - gamma_1; % Evident by geometry
    t2 = pi - gamma_2; % Evident by geometry
else % If elbowplus is set to 0 (false)
    t1 = alpha_1 + gamma_1; % The triangle is mirrored, the geometrical angles can be reused with some sign changes.
    t2 = -(pi - gamma_2);
end
t3 = phi - t1 - t2; % From the output angle calculation: t1 + t2 + t3 = phi
dht = [nan, t1, t2, t3, 0]; % Package athe joint angles and return the row vector
end