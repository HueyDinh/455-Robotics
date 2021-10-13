function dh = RRR_FDA(dh) % Forward Dispacement Analysis
% Input: dh - Data structure containing serial manipulator's information
% Output: A COPY (pass by value) of dh with the attribute dh.Xe_FDA
% populated (or overriden if it already exist).
t1 = dh.t(2); % Extracting the joint angles from dh.t 
t2 = dh.t(3);
t3 = dh.t(4);

a1 = dh.a(2); % Extracting the link length from dh.a
a2 = dh.a(3);
a3 = dh.a(4);

phi_e = t1+t2+t3; % Output orientaiton angle calculation
x_e = cos(t1)*a1 + cos(t1+t2)*a2 + cos(t1+t2+t3)*a3; % Adding up Cartesian vector component of these following relative position (in-order):
y_e = sin(t1)*a1 + sin(t1+t2)*a2 + sin(t1+t2+t3)*a3; % Joint 2 relative to Joint 1 / Joint 3 relative to Joint 2 / Effector relative to Joint 3

dh.Xe_FDA = [x_e y_e phi_e]; % Package and assign as a new attribute Xe_FDA of dh.

end