function varargout = WheelerLab(varargin)
% WHEELERLAB MATLAB code for WheelerLab.fig
%      WHEELERLAB, by itself, creates a new WHEELERLAB or raises the existing
%      singleton*.
%
%      H = WHEELERLAB returns the handle to a new WHEELERLAB or the handle to
%      the existing singleton*.
%
%      WHEELERLAB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WHEELERLAB.M with the given input arguments.
%
%      WHEELERLAB('Property','Value',...) creates a new WHEELERLAB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before WheelerLab_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to WheelerLab_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help WheelerLab

% Last Modified by GUIDE v2.5 26-Jun-2016 16:17:17

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % WheelerLab License Notice
% % % -------------------------
% % % Copyright (c) 2016, Adewale Amosu
% % % All rights reserved.
% % % 
% % % Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
% % % 
% % % 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
% % % 
% % % 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
% % % 
% % % 3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
% % % 
% % % THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR 
% % % A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT 
% % % NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, 
% % % OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @WheelerLab_OpeningFcn, ...
                   'gui_OutputFcn',  @WheelerLab_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before WheelerLab is made visible.
function WheelerLab_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to WheelerLab (see VARARGIN)

% Choose default command line output for WheelerLab
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes WheelerLab wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Outputs from this function are returned to the command line.
function varargout = WheelerLab_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in LoadDatatag.
function LoadDatatag_Callback(hObject, eventdata, handles)
% hObject    handle to LoadDatatag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
addpath('./dependencies/');addpath('./dependencies/SegyMAT/')
[PathName,FileName] = uigetfile({'*.segy;*.sgy;*.png;*.jpg;*.jpeg;*.tiff;*.tif;*.gif;*.mat'},'Select the Data file');
if (FileName == 0)
set(handles.edit1,'String','Input file is not selected')
pause(1)
set(handles.edit1,'String','Status')
return;
end

[~,~,ext] = fileparts(fullfile(FileName,PathName)) ;
if (strcmp(ext,'.segy') || strcmp(ext,'.sgy') )
    
   [ Seisdata,SegyTraceHeaders,SegyHeader]=ReadSegy(fullfile(FileName,PathName));
   handles.Seisdata=Seisdata;
   handles.SegyTraceHeaders=SegyTraceHeaders;
   handles.SegyHeader=SegyHeader;
   handles.linecount=0;
   handles.dataloadedchk=1;
   guidata(hObject,handles)
   plotdata(hObject, eventdata, handles)

elseif (strcmp(ext,'.png') || strcmp(ext,'.jpg') || strcmp(ext,'.jpeg') || strcmp(ext,'.tif') ...
       || strcmp(ext,'.tiff') || strcmp(ext,'.gif') );
    
    set(handles.checkbox1,'Value',0);
    handles.seisimage= imread(fullfile(FileName,PathName));
    axis(handles.axes1,'off');
    handles.dataloadedchk=1;
    handles.linecount=0;
    guidata(hObject,handles)
    image(handles.axes1,handles.seisimage);
    set(handles.axes1,'ytick',[]);set(handles.axes1,'xtick',[]);
    xlabel(handles.axes1,'Relative Distance','Fontsize',20,'fontweight','bold');
    ylabel(handles.axes1,'Relative Distance','Fontsize',20,'fontweight','bold');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in AddLayerTag.
function AddLayerTag_Callback(hObject, eventdata, handles)
% hObject    handle to AddLayerTag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'ordercheck')
    
if ~isfield(handles,'dataloadedchk')
 %xlim(handles.axes1,[0 1000]);ylim(handles.axes1, [0 1000]);
 if ~isfield(handles,'fchk')
%%%questionbox
prompt = {'minX:','maxX:','minY:','maxY:'};
dlg_title = 'Set Limits';
num_lines = 1;
defaultans = {'0','1000','0','10'};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
limm=str2double(answer);
xlim(handles.axes1,[limm(1) limm(2)]);ylim(handles.axes1, [limm(3) limm(4)]);
handles.fchk=1;
%%%endquestionbox
 end 
 grid(handles.axes1,'on');grid(handles.axes2,'on');
 set(handles.axes1,'Ydir','reverse');
 xlabel(handles.axes1,'Traces (Trace Number)','Fontsize',15,'fontweight','bold');
 ylabel(handles.axes1,{'Two Way';'Travel Time'},'Fontsize',15,'fontweight','bold');
 xlabel(handles.axes2,'Relative Distance','Fontsize',15,'fontweight','bold');
 ylabel(handles.axes2,{'Old   --->   Young';'Relative Geological Time'}','Fontsize',15,'fontweight','bold');
end

if strcmp(get(handles.pushbutton10,'String'),'Layer');
    
if ~isfield(handles,'linecount');handles.linecount=0;end
axes(handles.axes1);[xs,ys,trct]=addline(hObject,eventdata,handles,'b');
handles.linecount=handles.linecount+1;
handles.all_lines{handles.linecount,:}=[xs',ys'];
handles.systemtrct{handles.linecount}=trct;    
if ~isfield(handles,'nl'); handles.nl=handles.linecount;end
handles.nl=handles.linecount;
guidata(hObject,handles);   

elseif strcmp(get(handles.pushbutton10,'String'),'Surface');
    
if ~isfield(handles,'surfcount');handles.surfcount=0;end
axes(handles.axes1);[xs,ys,trct]=addline(hObject,eventdata,handles,'g');
handles.surfcount=handles.surfcount+1;
handles.all_surf{handles.surfcount,:}=[xs',ys'];
handles.surfname{handles.surfcount}=trct;    
if ~isfield(handles,'sl'); handles.sl=handles.surfcount;end
handles.sl=handles.surfcount;    
guidata(hObject,handles);
end

else
set(handles.edit1,'String','Cannot add new');
pause(1)
set(handles.edit1,'String','Status')
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function testcallback(pos,id)
%disp(id)
h = findobj('Tag',['pickline' num2str(id)]);
%disp(get(h,'Tag'));
%disp(pos);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [xs,ys,trct]=addline(hObject,eventdata,handles,cc)
xl(1)=nan;yl(1)=nan;xs(1)=nan;ys(1)=nan;
axes(handles.axes1);
count=0;click=1;
disp(' ');disp('Draw a shape around the layer');
disp(' ');disp('Mouse Usage :...');
disp('Use left mouse button to picks points')
disp('Use middle mouse button to delete last point');
disp('Use right mouse button to end line pick');disp(' ');

while (click == 1 || click == 2) 
    [xg(1),yg(1),click]=ginput(1);
    
    if (click == 1)
    hold(handles.axes1,'on');
    plot(handles.axes1,xg,yg,'s','Color',cc);
    count=count+1;
    xs(count)=xg;ys(count)=yg;
    end
    
    if (click == 2)
        if(count <= 0) count =1; end
     hold(handles.axes1,'on');
     plot(handles.axes1,xs(count),ys(count),'s','Color','w');
     xs(count)=nan;ys(count)=nan;
     count=count-1;
    end   
end %while
if strcmp(get(handles.pushbutton10,'String'),'Layer')
xs(count+1)=xs(1);ys(count+1)=ys(1);
end
hold(handles.axes1,'on');
plot(handles.axes1,xs,ys,'-','Linewidth',0.5,'Color',cc);

systract={'Highstand Systems Tract','Falling Stage Systems Tract',...
    'Lowstand Systems Tract','Transgressive Systems Tract',...
    'Lowstand Wedge','Healing Phase','Shelf Margin Wedge',...
    'Slope Fan','Basin Floor Fan','Sequence Boundary',...
    'Condensed Section','Subaerial Unconformity',...
    'Correlative Conformity','Basal Surface of Forced Regression',...
    'Maximum Regressive Surface','Maximum Flooding Surface','Enter Other',' '};
[s,v] = listdlg('PromptString',...
    'Select System Tract','SelectionMode','single','ListString',systract);
    if (v==0); 
    set(handles.edit1,'String','No selection');  
    pause(1);
    set(handles.edit1,'String','Status');  s=18;
    end
if s ==17
    %questionbox
     prompt = {'Enter Name:'};
     dlg_title = 'User defined System Tract';
     num_lines = 1;
     defaultans = {''};
     trct = inputdlg(prompt,dlg_title,num_lines,defaultans);
     if isempty(trct); 
    set(handles.edit1,'String','No Entry');  
    pause(1);
    set(handles.edit1,'String','Status');  trct=' ';
     else trct=cell2mat(trct);
     end
     %endquestionbox
else

trct=systract{s};
end
guidata(hObject,handles);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%%deletebutton
if isfield(handles,'nl') || isfield(handles,'sl') %check
set(handles.edit1,'String','Deleting...');
if ~isfield(handles,'ordercheck')
        
axes(handles.axes1)
h=impoint;setColor(h,'w');pos = getPosition(h);

if strcmp('Layer',get(handles.pushbutton10,'String'))
    
if isfield(handles,'nl')      
nl=handles.nl;
for kk=1:nl
[xsys]=handles.all_lines{kk,:};
if inpolygon(pos(1),pos(2),xsys(:,1),xsys(:,2)); 
    %disp(['Yes' num2str(kk)]);
    if isfield(handles,'newcol'); handles.newcol(kk,:)=[]; end
    break; 
end
end

 all_lines2=handles.all_lines;all_tracts2=handles.systemtrct;all_tracts=[];
 for jj=1:kk-1;all_lines{jj,:}=all_lines2{jj,:};all_tracts{jj}=all_tracts2{jj};end
 for jj=kk:nl-1;all_lines{jj,:}=all_lines2{jj+1,:};all_tracts{jj}=all_tracts2{jj+1};end
 if (handles.linecount == 1)
     clearvars handles.all_lines;
 else
     handles.all_lines=all_lines;
 end
 handles.systemtrct=all_tracts;
handles.linecount=handles.linecount-1;
handles.nl=handles.nl-1;
guidata(hObject,handles)
end
else
if isfield(handles,'sl') && (handles.sl > 0)   
sl=handles.sl;
for kk=1:sl
 [xlyl]=handles.all_surf{kk,:};
 [~,d(kk)] = dsearchn(xlyl,pos);
end
[~,jk]=min(d);
disp(jk)
all_surf2=handles.all_surf;surfname2=handles.surfname;surfname=[];
 for jj=1:jk-1;all_surf{jj,:}=all_surf2{jj,:};surfname{jj}=surfname2{jj};end
 for jj=jk:sl-1;all_surf{jj,:}=all_surf2{jj+1,:};surfname{jj}=surfname2{jj+1};end
 if (handles.surfcount == 1)
     clearvars handles.all_surf;
 else
     handles.all_surf=all_surf;
 end
handles.surfname=surfname;
handles.sl=handles.sl-1;
handles.surfcount=handles.surfcount-1;
guidata(hObject,handles)
end
end


%replot
cla(handles.axes1)
plotdata(hObject, eventdata, handles)
if isfield(handles,'nl') && (handles.nl >0)
 coltemp=simple_separate_colors(handles.nl) ;  
hold (handles.axes1,'on')
 for kk=1:handles.nl
        axes(handles.axes1); 
        [xsys]=handles.all_lines{kk,:};
        hpatch=plot(handles.axes1, xsys(:,1),xsys(:,2),'Marker','s','Linewidth',1,'Color','b');    
        hold(handles.axes1,'on')
 end
end
if isfield(handles,'sl') && (handles.sl >0)
    for kk=1:handles.sl
     [xlyl]=handles.all_surf{kk,:};
     hold('on');
     hlin=line(xlyl(:,1),xlyl(:,2));
     set(hlin,'Color','g','Linewidth',1);
     hold('on')
    end
end
 
set(handles.edit1,'String','Layer Deleted');
pause(0.05);
set(handles.edit1,'String','Status');
guidata(hObject,handles)
else
    set(handles.edit1,'String','Cannot Delete');
    pause(1)
    set(handles.edit1,'String','Status')
end %%%%ordercheck
else
set(handles.edit1,'String','Cannot Delete');
    pause(1)
    set(handles.edit1,'String','Status')
end %%%ifcheck
 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp('Surface',get(handles.pushbutton10,'String'))
    set(handles.pushbutton10,'String','Layer');
elseif strcmp('Layer',get(handles.pushbutton10,'String'))
    set(handles.pushbutton10,'String','Surface');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,'nl')
if ishandle(findobj('type','figure','name','rearrange'));
 
    for kk=1:handles.nl
    dtemp=getPosition(handles.hpline(kk));
    dtempnew(kk,1:2)=dtemp(:,1);
    dtempnew(kk,3:4)=dtemp(:,2);
    dtempold(kk,:)=handles.oldpos(kk,:);
    end
    close(findobj('type','figure','name','rearrange'));
    [~,I] = sort(dtempnew(:,4),'descend');
    for kk=1:handles.nl
        all_lines_fin{kk,:}=handles.all_lines{I(kk),:};
        all_tracts{kk}=handles.systemtrct{I(kk)};
    end
    handles.all_lines_fin=all_lines_fin;
    handles.systemtrct=all_tracts;
    handles.ordercheck=1;
      guidata(hObject,handles);
     set(handles.edit1,'String','Layers Order Saved')
     
else
axes(handles.axes1);
handles.xlimold=get(handles.axes1,'XLim'); 
handles.ylimold=get(handles.axes1,'YLim');

nl=handles.nl;
if ~isfield(handles,'newcol');handles.newcol=simple_separate_colors(nl);end
if ~isfield(handles,'surfcol');
    if isfield(handles,'sl');sl=handles.sl;
        scol=simple_separate_colors(nl+sl);
    handles.surfcol=scol(nl+1:nl+sl,:);
    
    end;
end

if isfield(handles,'nl')
for kk=1:nl
if isfield(handles,'all_lines_fin')
    [xsys]=handles.all_lines_fin{kk,1};
else
    [xsys]=handles.all_lines{kk,1};
end
hold(handles.axes1,'on');
hpatch=patch(handles.axes1, xsys(:,1),xsys(:,2),handles.newcol(kk,:));
set(hpatch,'facealpha',.5)
set(hpatch,'edgealpha',.5)
end
hfig1=figure('units','normalized','Position',[0.55 0.5 0.1 .8],'Name','rearrange');
for kk=1:nl
    hpline(kk)=imline(gca,[-100 100],[nl-kk+1 nl-kk+1]);
    oldpos(kk,:)=[-100 100 nl-kk+1 nl-kk+1];
    setColor(hpline(kk),handles.newcol(kk,:));
    nom=['pickline',num2str(kk)];
    set(hpline(kk),'Tag',nom);
    api1(kk) = iptgetapi(hpline(kk));
    id1(kk) = api1(kk).addNewPositionCallback(@(x) testcallback(x,1));
    hold('on');
end

handles.hpline=hpline;
handles.oldpos=oldpos;
set(handles.edit1,'String','Move lines to reorder layers');
guidata(hObject,handles);

text(-0.3,0.05,{'move lines to order'; 'click done to finish'},'Fontsize',10);
text(-0.3,0.5,'Youngest','Fontsize',20);text(-0.1,nl+1,'Oldest','Fontsize',20);
axis([-0.5 1.5 0 kk+2]);xlabel('Oldest');axis off;
set(gca,'Ydir','reverse');
end
end
else
set(handles.edit1,'String','No layers found')
pause(1)
set(handles.edit1,'String','Status')
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in DisplayTag.
function DisplayTag_Callback(hObject, eventdata, handles)
% hObject    handle to DisplayTag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isfield(handles,'nl')
if isfield(handles,'ordercheck')
    
    if ~isfield(handles,'dchk'); handles.oldcol=handles.newcol;handles.dchk=1; end
    if get(handles.checkbox3, 'Value') == 1;
     [handles.Usystemtrct,IS,IU] =unique(handles.systemtrct);
     handles.Unewcol=handles.newcol(IU,:);
     handles.UUnewcol=handles.Unewcol(IS,:);
     handles.UUsystemtrct=handles.systemtrct(IS);
     handles.UUsystemtrct=handles.UUsystemtrct(IU);
     handles.nlU=length(IS);
     handles.newcol=handles.Unewcol;
      guidata(hObject,handles)
    else
      handles.newcol=handles.oldcol; 
      guidata(hObject,handles)
     end

handles.xlimold=get(handles.axes1,'XLim');
cla(handles.axes1);cla(handles.axes2);
set(handles.edit1,'String','Displaying Wheeler Diagram...');
plotdata(hObject, eventdata, handles)
linkaxes([handles.axes1,handles.axes2],'x');
plot_tract(hObject, eventdata, handles,handles.axes1)
plot_rel_time(hObject, eventdata, handles,handles.axes2)
else
set(handles.edit1,'String','Click Done ')
pause(1)
set(handles.edit1,'String','Status')
end
else
set(handles.edit1,'String','No layers found')
pause(1)
set(handles.edit1,'String','Status')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
function plotdata(hObject, eventdata, handles,varargin)
if nargin <4; ax=handles.axes1; else ax=varargin{1};end

if isfield(handles,'seisimage')
    
cla(ax); image(ax,handles.seisimage);
xlabel(ax,'Relative Distance','Fontsize',15,'fontweight','bold');
ylabel(ax,'Relative Distance','Fontsize',15,'fontweight','bold');
elseif  isfield(handles,'Seisdata')
cla(ax)
SegyTraceHeaders=handles.SegyTraceHeaders;
SegyHeader=handles.SegyHeader;
Seisdata=handles.Seisdata;
grid(ax,'on');
axes(ax);
colormap(american_seismic);
imagesc([SegyTraceHeaders.cdp],SegyHeader.time,Seisdata);
title(ax,'Sequence-stratigraphic Analysis','Fontsize',15)
set(ax,'Ydir','reverse');
 hold (ax, 'on');
 if get(handles.checkbox1, 'Value') == 1;
 wiggle([SegyTraceHeaders.TraceNumber],SegyHeader.time,Seisdata);
 end
 xlabel(ax,'Traces (Trace Number)','Fontsize',15,'fontweight','bold');
 ylabel(ax,{'Two Way';'Travel Time'},'Fontsize',15,'fontweight','bold');
 xlabel(handles.axes2,'Relative Distance','Fontsize',15,'fontweight','bold');
 ylabel(handles.axes2,{'Old   --->   Young';'Relative Geological Time'}','Fontsize',15,'fontweight','bold');
 guidata(hObject,handles)
 
elseif isfield(handles,'Suseisdata')
    
grid(ax,'on');
axes(ax);
colormap(american_seismic);
%%%%%imagesc([SegyTraceHeaders.cdp],SegyHeader.time,Seisdata);
title(ax,'Sequence-stratigraphic Analysis','Fontsize',15)
set(ax,'Ydir','reverse');
 hold (ax, 'on');
 if get(handles.checkbox1, 'Value') == 1;
 %%%wiggle([SegyTraceHeaders.TraceNumber],SegyHeader.time,Seisdata);
 end
 xlabel(ax,'Traces (Trace Number)','Fontsize',15,'fontweight','bold');ylabel(ax,{'Two Way';'Travel Time'},'Fontsize',15,'fontweight','bold');
 xlabel(handles.axes2,'Relative Distance','Fontsize',15,'fontweight','bold');ylabel({'Old   --->   Young';'Relative Geological Time'}','Fontsize',15,'fontweight','bold');
 guidata(hObject,handles)
 
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plot_rel_time(hObject, eventdata, handles,varargin)
ax=varargin{1};hold(ax,'on');grid(ax,'on'); axes(ax);
nl=handles.nl;

for kk=1:nl
[xsys]=handles.all_lines_fin{kk,:};
x1=xsys(:,1);y1=xsys(:,2);

x2=[];y2=[];
for jj=1:length(x1)-1
    if (x1(jj) ~= x1(jj+1))
    xq=linspace(x1(jj),x1(jj+1),10*abs(x1(jj+1)-x1(jj))); 
    yq=interp1([x1(jj) x1(jj+1)],[y1(jj) y1(jj+1)],xq);
    x2=[x2 xq ];y2=[y2 yq ];
    end
end
xgrid=linspace(min(x2),max(x2),round(length(x2)/10)); 
tol=abs(range(x2)/2);
for jj=1:length(xgrid)-1
xtemp= x2( (x2 >= (xgrid(jj))-tol) & (x2 <= (xgrid(jj+1) )+tol) ) ; 
 if   ~isempty(xtemp)
       yshft=max(y2)-max(y2(   (x2 >= xgrid(jj))   &   (x2 <= xgrid(jj+1))   ));
       y2(   (x2 >= xgrid(jj))   &   (x2 <= xgrid(jj+1))   )=...
           y2(   (x2 >= xgrid(jj))   &   (x2 <= xgrid(jj+1))   )+...
           yshft;
 end   
end
ynew=y2;
x1=x2;



if (kk > 1)
    ynew=ynew-(max(ynew)-old_ynew_min);
end
old_ynew_max=max(ynew);old_ynew_range=range(ynew);old_ynew_min=min(ynew);

hpatch=patch(ax, x1,ynew,handles.newcol(kk,:));
hold(ax,'on');
set(hpatch,'facealpha',.5);
set(hpatch,'edgealpha',.5);
hold(ax,'on');
end

set(ax,'Ydir','reverse');
xlabel(ax,'Relative Distance','Fontsize',15,'fontweight','bold');
ylabel({'Old   --->   Young';'Relative Geological Time'}','Fontsize',15,'fontweight','bold');
set(gca,'ytick',[]);
handles.ylimoldb=get(ax,'YLim');
guidata(hObject,handles)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plot_tract(hObject, eventdata, handles,varargin)
ax=varargin{1};hold(ax,'on');grid(ax,'on'); axes(ax);
nl=handles.nl;
 for kk=1:nl
        [xsys]=handles.all_lines_fin{kk,:};
        x1=min(xsys(:,1)); x2=range(xsys(:,1));xm=max(xsys(:,1));
        axes(ax); 
        hold(ax,'on')
        hpatch=patch(ax, xsys(:,1),xsys(:,2),handles.newcol(kk,:));
        hold(ax,'on')
        set(hpatch,'facealpha',.5);
        set(hpatch,'edgealpha',.5);
        xlim(ax,handles.xlimold);
 end
 if isfield(handles,'sl')
 for kk=1:handles.sl
     [xlyl]=handles.all_surf{kk,:};
     hold(ax,'on');
     hlin=line(ax,xlyl(:,1),xlyl(:,2));
     set(hlin,'Color',handles.surfcol(kk,:),'Linewidth',2);
     hold(ax,'on')
     xlim(ax,handles.xlimold);
     ylim(ax,handles.ylimold);    
 end
 end
 set(ax,'Ydir','reverse');
 if isfield(handles,'seisimage')
xlabel('Relative Distance','Fontsize',15,'fontweight','bold');
ylabel('Relative Distance','Fontsize',15,'fontweight','bold');
elseif  isfield(handles,'Seisdata')
 xlabel('Traces (Trace Number)','Fontsize',15,'fontweight','bold');
 ylabel({'Two Way';'Travel Time'},'Fontsize',15,'fontweight','bold');
 end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function rwb=american_seismic()
n=64;r=linspace(0,n,n)'./n;g=flipud(r);b(1:n,1)=1;rwb=[r,r,b;b,g,g];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function col=simple_separate_colors(n)
  col = zeros(n,3);
x=linspace(0.1,0.9,30);[X,Y,Z]=meshgrid(x,x,x);col_large_rgb=[X(:),Y(:),Z(:)];
C = makecform('srgb2lab');col_large_lab = applycform(col_large_rgb,C);
benchmarkcol = applycform([1 0 0],C);prevcol = benchmarkcol(end,:); gap = inf(size(col_large_rgb,1),1);
for k = 1:n
    eulerd=sqrt(sum((col_large_lab-repmat(prevcol,[size(col_large_lab,1) 1])).^2,2));
    gap = min(eulerd,gap);[dummy,ind] = max(gap);  
    prevcol = col_large_lab(ind,:); col(k,:) = col_large_rgb(ind,:);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function savemovie(hObject, eventdata, handles,saveName1,saveName2,saveName3,saveName4)
%%%movie
ylimold=handles.ylimold;
hfigm = figure('units','normalized','Position',[0 0 1 1]);
subplot(2,1,1)
ax=gca;
plotdata(hObject, eventdata, handles,ax)
nl=handles.nl;

for kk=1:nl
[xsys]=handles.all_lines_fin{kk,:};
x1=xsys(:,1);y1=xsys(:,2);

x2=[];y2=[];
for jj=1:length(x1)-1
    if (x1(jj) ~= x1(jj+1))
    xq=linspace(x1(jj),x1(jj+1),10*abs(x1(jj+1)-x1(jj))); 
    yq=interp1([x1(jj) x1(jj+1)],[y1(jj) y1(jj+1)],xq);
    x2=[x2 xq ];y2=[y2 yq ];
    end
end
xgrid=linspace(min(x2),max(x2),round(length(x2)/10)); 
tol=abs(range(x2)/2);
for jj=1:length(xgrid)-1
xtemp= x2( (x2 >= (xgrid(jj))-tol) & (x2 <= (xgrid(jj+1) )+tol) ) ; 
 if   ~isempty(xtemp)
       yshft=max(y2)-max(y2(   (x2 >= xgrid(jj))   &   (x2 <= xgrid(jj+1))   ));
       y2(   (x2 >= xgrid(jj))   &   (x2 <= xgrid(jj+1))   )=...
           y2(   (x2 >= xgrid(jj))   &   (x2 <= xgrid(jj+1))   )+...
           yshft;
 end   
end
ynew=y2;
x1=x2;

if (kk > 1)
    ynew=ynew-(max(ynew)-old_ynew_min);
end
old_ynew_max=max(ynew);old_ynew_range=range(ynew);old_ynew_min=min(ynew);

subplot(2,1,2)
hold('on');grid('on');
hpatch=patch(x1,ynew,handles.newcol(kk,:));
hold('on');
set(hpatch,'facealpha',.5);
set(hpatch,'edgealpha',.5);
hold('on');
set(gca,'Ydir','reverse');
xlabel('Relative Distance','Fontsize',15,'fontweight','bold');ylabel({'Old   --->   Young';'Relative Geological Time'}','Fontsize',15,'fontweight','bold');
title('Chronostratigraphic Chart','Fontsize',15)
hold('on')
xlim(handles.xlimold);    
ylim(handles.ylimoldb);
set(gca,'ytick',[])



subplot(2,1,1)
hold('on');grid('on');
hpatch=patch(xsys(:,1),xsys(:,2),handles.newcol(kk,:));
hold('on')
set(hpatch,'facealpha',.5);
set(hpatch,'edgealpha',.5);
set(gca,'Ydir','reverse');
xlabel('Traces (Trace Number)','Fontsize',15,'fontweight','bold');ylabel({'Two Way';'Travel Time'},'Fontsize',15,'fontweight','bold');
xlim(handles.xlimold);
ylim(handles.ylimold)
title('Sequence-stratigraphic Analysis','Fontsize',15)
hold('on')
pause(0.02)
M(kk)=getframe(hfigm);
if kk== nl; savefig(hfigm,saveName4) ; end
end
close(hfigm);

%for save avi
v = VideoWriter(saveName1);
if nl<10;v.FrameRate = 1;else v.FrameRate=5;end
open(v);
writeVideo(v,M)
close(v);
handles.moviedata=M;
guidata(hObject,handles)

%%%%save gif
mk=size(M,2);
 for k=1:mk
im = frame2im(M(k));
      [imind,cm] = rgb2ind(im,256);
      if k == 1;
          imwrite(imind,cm,saveName2,'gif', 'Loopcount',inf);
      else
          imwrite(imind,cm,saveName2,'gif','WriteMode','append');
      end
 end
%%%%lastgif
imwrite(imind,cm,saveName3)
%%%animations


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in SaveButtonTag.
function SaveButtonTag_Callback(hObject, eventdata, handles)
% hObject    handle to SaveButtonTag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,'nl')
handles.xlimold=get(handles.axes1,'XLim'); 
handles.ylimold=get(handles.axes1,'YLim');
guidata(hObject,handles)
PathName='./WheelerLab_Output';
[statuspath,message,messageid] = mkdir(PathName);
FileName1=['WheelerLab_systracts_',datestr(now, 'dd_mmm_yyyy_HH_MM_SS'),'.fig'];
FileName2=['WheelerLab_systracts_',datestr(now, 'dd_mmm_yyyy_HH_MM_SS'),'.png'];
FileName3=['WheelerLab_relativetime_',datestr(now, 'dd_mmm_yyyy_HH_MM_SS'),'.fig'];
FileName4=['WheelerLab_relativetime_',datestr(now, 'dd_mmm_yyyy_HH_MM_SS'),'.png'];
FileName5=['WheelerLab_combined_',datestr(now, 'dd_mmm_yyyy_HH_MM_SS'),'.fig'];
FileName6=['WheelerLab_combined_',datestr(now, 'dd_mmm_yyyy_HH_MM_SS'),'.png'];
FileName7=['WheelerLab_movie_',datestr(now, 'dd_mmm_yyyy_HH_MM_SS'),'.gif'];
FileName8=['WheelerLab_movie_',datestr(now, 'dd_mmm_yyyy_HH_MM_SS'),'.avi'];
FileName9=['WheelerLab_key_',datestr(now, 'dd_mmm_yyyy_HH_MM_SS'),'.fig'];
FileName10=['WheelerLab_coordinates_',datestr(now, 'dd_mmm_yyyy_HH_MM_SS'),'.txt'];
%%%nowsave
set(handles.edit1,'String','Please wait saving files ...')

%%savetracts
saveName = fullfile(PathName,FileName1);
hfig = figure('units','normalized','Position',[0 0 1 1]);
ax=gca;
colormap(american_seismic);
plotdata(hObject, eventdata,handles,ax);
plot_tract(hObject, eventdata, handles,ax)
title(ax,'Sequence-stratigraphic Analysis','Fontsize',15)
saveas(hfig, saveName,'fig');
saveName = fullfile(PathName,FileName2);
saveas(hfig, saveName,'png');
close(hfig);

%%savereltime
saveName = fullfile(PathName,FileName3);
hfig2=figure('units','normalized','Position',[0 0 1 1]);
ax=gca;
plot_rel_time(hObject, eventdata, handles,ax)
title(ax,'Chronostratigraphic Chart','Fontsize',15);
saveas(hfig2, saveName,'fig');
saveName = fullfile(PathName,FileName4);
saveas(hfig2, saveName,'png');
close(hfig2);

%%%savemovie
saveName8 = fullfile(PathName,FileName8);
saveName7 = fullfile(PathName,FileName7);
saveName6 = fullfile(PathName,FileName6);
saveName5 = fullfile(PathName,FileName5);
savemovie(hObject, eventdata, handles,saveName8,saveName7,saveName6,saveName5)

%%%%savetextinfo
if isfield(handles,'nl')
saveName = fullfile(PathName,FileName10);
hdr=sprintf('%s','Layer Coordinates ');hdr(end)='';
dlmwrite(saveName,hdr,'');
nl=handles.nl;
for kk=1:nl
dlmwrite(saveName,kk,'-append');
[xsys]=handles.all_lines_fin{kk,:};
dlmwrite(saveName,xsys,'-append','delimiter','\t','precision','%.6f')
end
end
if isfield(handles,'sl')
dlmwrite(saveName,' ','-append','delimiter','');  
hdr=sprintf('%s','Surface Coordinates ');hdr(end)='';
dlmwrite(saveName,hdr,'-append','delimiter','');
sl=handles.sl;
for kk=1:sl
dlmwrite(saveName,kk,'-append');
[xlyl]=handles.all_surf{kk,:};
dlmwrite(saveName,xlyl,'-append','delimiter','\t','precision','%.6f')
end
end

%%%savekey
saveName = fullfile(PathName,FileName9);       
hfig4 = figure('units','normalized','outerposition',[0 0 1 1]);
keyaxes=gca;axes(keyaxes);
if get(handles.checkbox3, 'Value') == 1;
    nleg=handles.nlU;legtract=handles.Usystemtrct;legcol=handles.UUnewcol;
else
    nleg=handles.nl;legtract=handles.systemtrct;legcol=handles.newcol;
end
for kk=1:nleg
    ck=kk*0.2;
    xp=[1 1.1 1.1 1];yp=[-ck -ck -ck+0.05 -ck+0.05];
hrect=patch(xp,yp,legcol(kk,:)); hold(keyaxes, 'on') ; 
set(hrect,'facealpha',.5);
set(hrect,'edgealpha',.5);
text(1.15 ,-ck+0.025,legtract{kk},'Parent',keyaxes);hold(keyaxes, 'on') ; 
oldck=-ck+0.025;
end
text(1 ,0.05,'Chronostratigraphic Chart Key','Fontsize',15,'Parent',keyaxes);
xlim(keyaxes,[0 3]); ylim([-0.2*nleg 0 ])

if isfield(handles,'all_surf')
  sl=handles.sl;
  for kk=1:sl
     ck=(kk*0.2)-oldck;
     hold(keyaxes, 'on')
     hl=line(keyaxes, [1 1.1],[-ck+0.025 -ck+0.025]);
     set(hl,'Color',handles.surfcol(kk,:),'Linewidth',2);
     text(1.15 ,-ck+0.025,handles.surfname{kk},'Parent',keyaxes);hold(keyaxes, 'on') ; 
  end
  ylim([-0.2*(nleg+sl) 0 ])
end

axis off;
drawnow;
savefig(hfig4, saveName);
close(hfig4)


%endsave
set(handles.edit1,'String','Files Saved')
else
set(handles.edit1,'String','Data not loaded')
pause(1)
set(handles.edit1,'String','Status')
end %%check

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in ResetButtonTag.
function ResetButtonTag_Callback(hObject, eventdata, handles)
% hObject    handle to ResetButtonTag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ishandle(findobj('type','figure','name','rearrange'));
    close(findobj('type','figure','name','rearrange'));
end
close(gcbf);
WheelerLab;
