%% SCRIPT Denavit-Hartenberg (DH) data for 3RRR Parallel Robot                  
% Drexel MEM455 - Introduction to Robotics
% Fall 2021
%-------------------------------------------------------------------------------
% - dh structure for the 3RRR robot used in the lab 
% - Unless otherwise noted, dh structure values are logically indexed from frame 0 (base) to frame n+1 (gripper)
% - Within dh structure each row corresponds to a leg
%  
%-------------------------------------------------------------------------------
%% BEGIN{PICTURE DATA}**********************************************************
%Denavit-Hartenberg data - logically indexed from frame 0 (base) to frame n+1 (gripper)
h = atan2(1,2)*180/pi;                                                          %a useful angle

%      [  0,       1,       2,       3,       4]                                %dh structure values are logically indexed from frame 0 (base) to frame n+1 (gripper)
dh.t = [nan,    -135,   -45-h,   -45+h,       0; ...                            %leg 1: joint angles        0...n+1
        nan,      45,   135-h,   -90+h,      45; ...                            %leg 2: joint angles        0...n+1
        nan,     225,   135-h,  -180+h,     -45]*pi/180;                        %leg 3: joint angles        0...n+1
dh.a = [  0, sqrt(8), sqrt(5), sqrt(8),     nan; ...                            %leg 1: link common normals 0...n+1
          0, sqrt(8), sqrt(5),       2,     nan; ...                            %leg 2: link common normals 0...n+1
          0, sqrt(8), sqrt(5),       2,     nan];                               %leg 3: link common normals 0...n+1
dh.d = [nan,       3,       0,       0,       0; ...                            %leg 1: joint offsets       0...n+1
        nan,       3,       0,       0,       0; ...                            %leg 2: joint offsets       0...n+1
        nan,       3,       0,       0,       0];                               %leg 3: joint offsets       0...n+1
dh.f = [  0,       0,       0,       0,     nan; ...                            %leg 1: link twist angles   0...n+1
          0,       0,       0,       0,     nan;                                %leg 2: link twist angles   0...n+1
          0,       0,       0,       0,     nan];                               %leg 3: link twist angles   0...n+1
dh.joint.type = ...
       ['B',     'R',       'R',      'H',     'G'; ...                         %leg 1: R/P/G/B/N/H - Revolute/Prismatic/Gripper/Base/None/PlatformR g-joint
        'B',     'R',       'R',      'R',     'G'; ...                         %leg 2: R/P/G/B/N/H - Revolute/Prismatic/Gripper/Base/None/PlatformR g-joint
        'B',     'R',       'R',      'R',     'G'];                            %leg 3: R/P/G/B/N/H - Revolute/Prismatic/Gripper/Base/None/PlatformR g-joint
dh.joint.centered = ...
       ['M',     'C',       'M',      'M',     'M'; ...                         %leg 1: C/T/M - Center/Top/center of RPG g-joint at o(i)/o(i)/(Midpoint d(i))(0...n+1)
        'M',     'C',       'M',      'M',     'M'; ...                         %leg 2: C/T/M - Center/Top/center of RPG g-joint at o(i)/o(i)/(Midpoint d(i))(0...n+1)
        'M',     'C',       'M',      'M',     'M'];                            %leg 3: C/T/M - Center/Top/center of RPG g-joint at o(i)/o(i)/(Midpoint d(i))(0...n+1)
dh.frame.type   = ...
       ['F',     'N',       'N',      'N',     'F'; ...                         %leg 1: F/P/N - ith frame (0..n+1) is Fancy/Plain/None
        'N',     'N',       'N',      'N',     'N'; ...                         %leg 2: F/P/N - ith frame (0..n+1) is Fancy/Plain/None
        'N',     'N',       'N',      'N',     'N'];                            %leg 3: F/P/N - ith frame (0..n+1) is Fancy/Plain/None

%Leg base frame offsets as 1x3 vectors (all parallel to global frame)
dh.p1   = ...
       [      8,       4,      0; ...                                           %leg 1: base frame location
              2,       0,      0; ...                                           %leg 2: base frame location
              4,       8,      0];                                              %leg 3: base frame location
    
%Leg base frame offsets as 4x4 matrices (all parallel to global frame)
dh.T{1} = trans(dh.p1(1,1),dh.p1(1,2),dh.p1(1,3));                              %leg 1: base frame location
dh.T{2} = trans(dh.p1(2,1),dh.p1(2,2),dh.p1(2,3));                              %leg 2: base frame location
dh.T{3} = trans(dh.p1(3,1),dh.p1(3,2),dh.p1(3,3));                              %leg 3: base frame location

%local platform vertices: 1) use leg 1: origin at joint 3 and x axis along link a_3
%                         2) coordinates ordered ccw(+) around the vertices with gripper last
dh.Hx = [ sqrt(2), 0, sqrt(2), sqrt(8)]; % x coords - order: leg 3, leg 1, leg 2, gripper
dh.Hy = [-sqrt(2), 0, sqrt(2),       0]; % y coords - order: leg 3, leg 1, leg 2, gripper

%options
dh.R_rad_ratio = 35;                                                            %ratio of total link distance to R joint radius (main robot scale factor)
dh.part.edges  = ['Y'];                                                         %Y/N - Edges/None (Y - default; N - good for transparent parts)                                      %                 first argument (i = 0 ) is ignored
dh.part.alpha  = 1;                                                             %set transparency, 0 --> 1 = transparent --> opaque (movies opaque only!)
%dh.part.alpha  = 0.25;                                                          %set transparency, 0 --> 1 = transparent --> opaque (movies opaque only!)
if dh.part.alpha < 0.75                                                         %check transparency
    dh.part.edges = ['N'];                                                      %get rid of edges when using significant transparency (looks better)
end %if
%END{PICTURE DATA}--------------------------------------------------------------
%% BEGIN{MOVIE   DATA}**********************************************************
% for future implementation
%
% dh.movie.export   = ['N'];                                                      %Y/N   - export/no export of avi movie
% %dh.movie.export   = ['Y'];                                                      %Y/N   - export/no export of avi movie
% 
% dh.movie.name     = ['RRR_robot'];                                              %exported movie name (.avi appended)
% 
% %dh.movie.opt.axes = ['Y'];                                                      %determine optimal size of axes (requires an extra motion generation)
% dh.movie.opt.axes = ['N'];                                                      %determine optimal size of axes (requires an extra motion generation)
% 
% dh.pause = ['N'];                                                               %Y/N - pause/no pause to adjust view on 1st frame (N - good for testing)
% %dh.pause = ['Y'];                                                               %Y/N - pause/no pause to adjust view on 1st frame (Y - good for final)
%END{MOVIE DATA}----------------------------------------------------------------
