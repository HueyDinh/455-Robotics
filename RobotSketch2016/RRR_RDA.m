function dh = RRR_RDA(dh) % Reverse Displacement Analysis
% Input: dh - Data structure containing serial manipulator's information
% Output: A COPY (pass by value) of dh with the attribute dh.t_RDA
% populated (or overriden if it already exist).
a1 = dh.a(2); % Extract the link length from dh.a
a2 = dh.a(3);
a3 = dh.a(4);
x_e = dh.Xe(1); % Extract the end-effector location from dh.Xe
y_e = dh.Xe(2);
phi = dh.Xe(3);

p3_1 = [x_e y_e] - a3*[cos(phi) sin(phi)]; % Calculate the Cartesian coordinate of Joint 3 by substracting the relative position of the effector relative to Joint 3 from the effector's coordinate
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
dh.t_RDA = [nan, t1, t2, t3, 0]; % Package and assign to attribute dh.t_RDA
end