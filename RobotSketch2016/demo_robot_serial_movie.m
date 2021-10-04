%% SCRIPT demo_robot_serial_movie                                               
%
% Drexel MEM455 - Introduction to Robotics
% Fall 2021
%--------------------------------------------------------------------------
% DESCRIPTION:
%       Animates a serial robot from specified data files
%
% INPUTS: (read in as a files)
%       dh_robot_data  = specifies SCRIPT   containing Denavit-Hartenberg parameters and options 
%            (see data_RRR_lab.m for structure example)
%       dh_robot_movie = specified FUNCTION containing multiple sets of joint angles for animation
%            (see data_RRR_lab_movie.m for structure example)
%
% OUTPUTS:
%       None
%--------------------------------------------------------------------------
% OTHER INFORMATION:
%       Transparency does not work for movies - conflict between LIGHTING and GETFRAME
%--------------------------------------------------------------------------
%
%% BEGIN{USER DATA}*************************************************************
%clean up
clear all                                                                       %clear the workspace

%user data files
dh_robot_data = 'data_RRR_lab';                                                 %filename for dh parameters and options data (SCRIPT)
% dh_robot_data = 'data_RRR_lab_modified';                                        %load dh parameters and options from data file (SCRIPT)
dh_movie_data = 'data_nR_spin_first_joint_movie';                               %filename for movie joint data (FUNCTION)
% dh_movie_data = 'data_nR_spin_all_joints_movie';                                %filename for movie joint data (FUNCTION)

%input data and set parameters
eval(dh_robot_data);                                                            %input dh parameters and options
dh.q          = eval([dh_movie_data,'(dh)']);                                   %input joint angles for movie

N             = length(dh.t);                                                   %number of joints (0...n+1) specifed
n             = N-1;                                                            %last joint index; logically indexed from 0 
n_pose        = size(dh.q,1);                                                   %number of configurations
%END{USER DATA}----------------------------------------------------------------                                                                      
%% BEGIN{NEW FIGURE}************************************************************
figure                                                                          %open new window
hold on                                                                         %keep open to plot multiple links, joints, frames, etc.
view(3)                                                                         %usually a good viewpoint
grid                                                                            %good background
if dh.movie.opt.axes == 'Y'                                                     %find smallest containing axes
    for j = 1:n_pose                                                            %draw robot thru motion range
        cla                                                                     %clear figure from axes
        frame_type_opt = char('P'*(dh.frame.type == 'F'));                      %use plain axes for optimal workspace (faster)
        draw_robot_serial(dh.q(j,:),dh.d,dh.f,dh.a,dh.joint.type,dh.frame.type,dh.joint.centered,dh.part.edges) %draw robot
        drawnow                                                                 %dump buffer (else following 'axis' commands may cause warnings)
        axis equal                                                              %1:1:1 aspect ratios
        axis tight                                                              %best detail for figure dimensions
        if j == 1                                                               %initialize axis_dims
            axis_dims = axis;                                                   %get axis dimensions
        end %if            
        
        %adjust axis values to capture all configurations
        axis_dims_current = axis;                                               %get current axis dimensions
        axis_dims(1) = min(axis_dims(1),axis_dims_current(1));                  %minimum x axis value
        axis_dims(2) = max(axis_dims(2),axis_dims_current(2));                  %maximum x axis value
        axis_dims(3) = min(axis_dims(3),axis_dims_current(3));                  %minimum y axis value
        axis_dims(4) = max(axis_dims(4),axis_dims_current(4));                  %maximum y axis value
        axis_dims(5) = min(axis_dims(5),axis_dims_current(5));                  %minimum z axis value
        axis_dims(6) = max(axis_dims(6),axis_dims_current(6));                  %maximum z axis value
    end %for j
    cla                                                                         %clear figure from axes
else                                                                            %approximate size of axes
    axis equal                                                                  %maintain realistic dimensions
    len = sum(dh.a(1:length(dh.a)-1)) + sum(dh.d(2:length(dh.d)));              %add up common normals and offsets
    axis_dims = len*[-1/2, 1/2,-1/2, 1/2, -1/4, 1/2];                           %estimate coordinate axis dimensions
end %if optimal_axes   
axis(axis_dims)                                                                 %set axis dimensions
%END{NEW FIGURE}---------------------------------------------------------------
%% BEGIN{DRAW ROBOT}************************************************************
%preallocation
M(1:n_pose)  = struct('cdata', [],'colormap', []);                              %preallocate variable for movie                        

%figure lighting
material shiny                                                                  %also try default, dull, metal
% alpha(dh.part.alpha)                                                          %set transparency (0 to 1) - CANNOT BE USED WITH GETFRAME
light_handle = camlight(0,0);                                                   %light added relative to camera with view(3)
[az,el]=lightangle(light_handle);                                               %new coords of light
lighting phong                                                                  %smooth lighting (gouraud is similar)

%draw robot in each position
for j=1:n_pose                                                                  %for each frame
    if dh.trace == 'N'; cla; end                                                %clear previous position from figure buffer
    draw_robot_serial(dh.q(j,:),dh.d,dh.f,dh.a,dh.joint.type,dh.frame.type,dh.joint.centered,dh.part.edges) %draw robot in buffer
    if dh.trace == 'N'; 
        lighting phong;                                                         %reset smooth lighting (gouraud is similar)
        light_handle = lightangle(az,el);                                       %reset light for each new frame
    end                                                                         %smooth lighting (gouraud is similar)
%    alpha(dh.part.alpha)                                                       %set transparency (0 to 1) - CANNOT BE USED WITH GETFRAME
   
    %user input to adjust view on 1st frame
    if (dh.pause == 'Y')&&(j == 1);                                             %allow user to change view
        disp('Set view, adjust light, then press any key to continue');         %user message to set view and lighting
        pause;                                                                  %wait for key press
        [az,el]  = lightangle(light_handle);                                    %new coords of light
    end %user message to set view
  
    %output frame
    drawnow                                                                     %output current position from figure buffer
    M(:,j)       = getframe;                                                    %save current frame to movie
end %for j
%END{DRAW ROBOT}---------------------------------------------------------------
%% BEGIN{EXPORT MOVIE}**********************************************************
%export movie to avi file
if dh.movie.export == 'Y'                                                       %export movie
        vw=VideoWriter(dh.movie.name);                                          %construct object to write an avi video
        open(vw);                                                               %open file for writing
        for i=1:length(M)                                                       %for each frame
            writeVideo(vw,M(:,i));                                              %write each frame to file (less memory than writing entire movie M)
        end %for   
        close(vw);                                                              %close file
end %if export_movie
%END{EXPORT MOVIE}-------------------------------------------------------------
