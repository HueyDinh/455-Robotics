%% SCRIPT Denavit-Hartenberg (DH) data and options for RRR Serial Robot                    
% Drexel MEM455 - Introduction to Robotics
% Fall 2021
%-------------------------------------------------------------------------------
% - dh structure for the RRR robot used in the lab
% - set options for movies
% - Unless otherwise noted, dh structure values are logically indexed from frame 0 (base) to frame n+1 (gripper)
%  
%-------------------------------------------------------------------------------
%% BEGIN{PICTURE DATA}**********************************************************
%joint and link parameters
%                   [  0,     1,     2,     3,     4]                           %dh structure values are logically indexed from frame 0 (base) to frame n+1 (gripper)
dh.t              = [nan,    30,    45,   -30,     0]*pi/180;                   %joint angles  (first element ignored)
dh.d              = [nan,     7,     0,     0,     0];                          %joint offsets (first element ignored)
dh.a              = [  0,  9.32,  9.32, 10.16,   nan];                          %link common normals (last element ignored)
dh.f              = [  0,     0,     0,     0,   nan]*pi/180;                   %link twist angles (last element ignored)
dh.joint.type     = ['B',   'R',   'R',   'R',   'G'];                          %joint type R/P/G/B/N - Revolute/Prismatic/Gripper/Base/None
dh.frame.type     = ['F',   'N',   'N',   'N',   'F'];                          %F/P/N - ith frame (0..n+1) is Fancy/Plain/None
dh.joint.centered = ['M',   'C',   'M',   'M',   'M'];                          %C/T/M - Center/Top/center of RPG g-joint at o(i)/o(i)/(Midpoint d(i))(0...n+1)

%part options
dh.part.edges     = ['Y'];                                                      %Y/N - Edges/None (Y - good for solid parts; N - good for transparent parts)                                      %                 first argument (i = 0 ) is ignored
dh.part.alpha     = 1;                                                          %set transparency, 0 --> 1 = transparent --> opaque (movies opaque only!)
% dh.part.alpha     = 0.25;                                                       %set transparency, 0 --> 1 = transparent --> opaque (movies opaque only!)
if dh.part.alpha < 0.75                                                         %check transparency
    dh.part.edges = ['N'];                                                      %get rid of edges when using significant transparency (looks better)
end %if
%END{PICTURE DATA}--------------------------------------------------------------
%% BEGIN{MOVIE OPTIONS}*********************************************************
  dh.movie.export   = ['N'];           %(default)                               %Y/N   - export/no export of avi movie
% dh.movie.export   = ['Y'];                                                    %Y/N   - export/no export of avi movie

  dh.movie.name     = ['RRR_robot'];   %(default)                               %exported movie name (.avi appended)

  dh.movie.opt.axes = ['N'];           %(default)                               %determine optimal size of axes (requires an extra motion generation)
% dh.movie.opt.axes = ['Y'];                                                    %determine optimal size of axes (requires an extra motion generation)

  dh.pause          = ['N'];           %(default)                               %Y/N - pause/no pause to adjust view on 1st frame (N - good for testing)
% dh.pause          = ['Y'];                                                    %Y/N - pause/no pause to adjust view on 1st frame (Y - good for final)

  dh.trace          = ['N'];           %(default)                               %Y/N - trace/no trace all poses
% dh.trace          = ['Y'];                                                    %Y/N - trace/no trace all poses

%END{MOVIE OPTIONS}-------------------------------------------------------------
