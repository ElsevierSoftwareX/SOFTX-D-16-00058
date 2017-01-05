clear all; clc; close all;
addpath /Users/adewaleamosu/Desktop/GEO_LIFE_H/RESEARCH/saltdiapirs/dependencies/SegyMAT;

% colormap(gray);
% [PathName,FileName] = uigetfile({'*.segy;*.sgy;*.png;*.jpg;*.jpeg;*.tiff;*.tif;*.gif;*.mat'},'Select the Data file');
% [~,~,ext] = fileparts(fullfile(FileName,PathName)) ;
% if (strcmp(ext,'.segy') || strcmp(ext,'.sgy') )
%     [ Seisdata,SegyTraceHeaders,SegyHeader]=ReadSegy(fullfile(FileName,PathName));
%     imagesc([SegyTraceHeaders.cdp],SegyHeader.time,Seisdata);
% end

files = dir( fullfile('./SEGY','*.sgy') );   %# list all *.xyz files
files = {files.name}';  
for kk=1:numel(files)
   title(files(kk,:)) 
   pause(2)
end