function connectome_wb_render(vol,wbpath,rsurf,lsurf,interp)
% connectome_wb_render
% Can be used to render volumes (e.g. SPMs) on the cortical surface using
% connectome workbench. Documentation here:
% http://www.humanconnectome.org/software/workbench-command.php
% Requires connectome workbench installation, as well as downloading
% appropriate surface files for rendering, e.g. the Conte69 dataset: 
% http://brainvis.wustl.edu/wiki/index.php//Caret:Atlases/Conte69_Atlas
%
% Arguments:
% vol - the volume you wish to render, as .nii file
%
% wbpath - the complete path to workbench install. For convenience, you
% may want to simply edit this function to hardcode this for your system.
% If on Windows, this will likely looking something like:
% 'C:\\"Program Files"\\workbench' (be careful to deal with the path name
% appropriately if it contains spaces.)
%
% interp - method of interpolation for the rendering. Options include
% 'trilinear' (worse but faster), 'cubic' (better but slower), and
% 'enclosing' (not really interpolation - just assigns points based on
% value of voxel enclosing point on surface. Will result in "blocky"
% looking maps, but may be better if you have pre-masked wyour images).
%
% rsurf & lsurf - paths to left and right hemisphere surf.gii files onto
% which you wish to render the volumes.
%
% Results:
% Will produce two (left and right) .shape.gii files named like your volume
% in the current working directory. See the workbench documentation for how
% to view these files.
%
% Only supported for Windows right now! (Tested on Win7)

exe = ['bin_windows64' filesep 'wb_command.exe -volume-to-surface-mapping '];
command = [wbpath filesep exe vol ' ' rsurf ' ' vol(1:end-4) '_R.shape.gii -' interp];
system(command)
command = [wbpath filesep exe vol ' ' lsurf ' ' vol(1:end-4) '_L.shape.gii -' interp];
system(command)
return