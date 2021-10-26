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

%      [  0,       1,       2,       3,       4]                                %dh structure values are logically indexed from frame 0 (base) to frame n+1 (gripper)
dh.t = [nan,     nan,     nan,     nan,       0; ...                            %leg 1 joint angle placeholder, offset known (without this placeholder, the storage of offset angle data is going to be more complicated)
        nan,     nan,     nan,     nan,      45; ...                            %leg 2 joint angle placeholder, offset known
        nan,     nan,     nan,     nan,     -45]*pi/180;                        %leg 3 joint angle placeholder, offset known

dh.Xe = [2 5 3*pi/4];                                                           %end effector's position

dh.elbowplus = [1 1 1];                                                         %RRR elbows' configurations (all plus)

%Leg base frame offsets (all parallel to global frame)
dh.p1   = ...
       [      8,       0,      0; ...                                           %leg 1: base frame location (third entry added to maintain compatibility with homogenous transformation below)
             -2,       4,      0; ...                                           %leg 2: base frame location
              4,       8,      0];                                              %leg 3: base frame location

dh.a = [  0, sqrt(8), sqrt(5), sqrt(8),     nan; ...                            %leg 1: link lengths (index 2: link 1, index 3: link 2, index 4: virtual link)
          0, sqrt(8), sqrt(5),       2,     nan; ...                            %leg 2: link lengths
          0, sqrt(8), sqrt(5),       2,     nan];                               %leg 3: link lengths

dh = RRR3_reverse(dh);                                                          %calculating RDA for the paralellel robot (dh.t modified in the returned dh object)

% The section below remain unmodified from the original data_3RRR_default.m
% file (except for the base offset, which was moved above).

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
