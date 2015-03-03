function varargout = swc_gui(varargin)
% SWC_GUI MATLAB code for swc_gui.fig
%      SWC_GUI, by itself, creates a new SWC_GUI or raises the existing
%      singleton*.
%
%      H = SWC_GUI returns the handle to a new SWC_GUI or the handle to
%      the existing singleton*.
%
%      SWC_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SWC_GUI.M with the given input arguments.
%
%      SWC_GUI('Property','Value',...) creates a new SWC_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before swc_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to swc_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help swc_gui

% Last Modified by GUIDE v2.5 03-Mar-2015 15:20:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @swc_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @swc_gui_OutputFcn, ...
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


% --- Executes just before swc_gui is made visible.
function swc_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to swc_gui (see VARARGIN)

% Choose default command line output for swc_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes swc_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = swc_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in box_save.
function box_save_Callback(hObject, eventdata, handles)
% hObject    handle to box_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of box_save



function edit_mouse_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mouse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mouse as text
%        str2double(get(hObject,'String')) returns contents of edit_mouse as a double


% --- Executes during object creation, after setting all properties.
function edit_mouse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mouse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_session_Callback(hObject, eventdata, handles)
% hObject    handle to edit_session (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_session as text
%        str2double(get(hObject,'String')) returns contents of edit_session as a double


% --- Executes during object creation, after setting all properties.
function edit_session_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_session (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_init.
function pushbutton_init_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_init (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('init done');
set(handles.pushbutton_init,'String','...'); drawnow;
disp(' ');disp(' ');disp(' ');
disp('initializing daq etc');
%%clear all;set(handles.pushbutton_init,'String','...');

x=daqhwinfo;
x.InstalledAdaptors;
ai = analoginput('nidaq','Dev1');
ch = addchannel(ai, [0 3 4 7 6]); % 7: 0 primary 3 secondary out, 4 wh stim, 7 frame trig. 6 laser/trial trig
%ch = addchannel(ai, [0 3 4 1 6]);
set(handles.figure1,'Color',[1 1 1].*.8);
set(handles.text_cellnum,'ForegroundColor',[1 1 1].*.5); drawnow;


global recording_nr ai sess_datestr;
sess_datestr=datestr(now,29);
set(handles.text_datestr,'String',['( date str: ',sess_datestr,')']); 
recording_nr=0;
set(handles.text_cellnum,'String',num2str(recording_nr));
set(handles.pushbutton_start,'Enable','on');
set(handles.pushbutton_view,'Enable','on');  drawnow;

disp('init done');set(handles.pushbutton_init,'String','init');

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton_init.
function pushbutton_init_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_init (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_start.
function pushbutton_start_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (~isempty(daqfind))
    stop(daqfind);
end

global recording_nr ai sess_datestr;

swc=[];
global swc;

swc.date=date;
swc.time=now;


swc.note=get(handles.edit_note,'String');

swc.mouse_id=get(handles.edit_mouse,'String');
swc.max_hrs=2;
swc.SampleRate=20000;
swc.session_nr=str2num(get(handles.edit_session,'String'));
swc.R_bath=str2num(get(handles.edit_rbath,'String'));


swc.chs.trial_trigger=4;  %where in the input train is the data, not where oin the daq
swc.chs.frame_trigger=5;  %where in the input train is the data, not where oin the daq
swc.chs.whisker_stim=3;  %where in the input train is the data, not where oin the daq

swc.gain_primary=10; % multiclamp gain
swc.gain_secondary=10;
swc.ylims=[-100 20];

ai.LogToDiskMode = 'overwrite';
ai.LoggingMode = 'Disk';
ai.TriggerType = 'Immediate';
ai.TriggerRepeat = 1;
ai.SampleRate = swc.SampleRate;
ai.SamplesPerTrigger = ceil(swc.max_hrs*(60^2)*ai.SampleRate); % 2 hrs?


disp(['set up for ',num2str(swc.max_hrs) ,' hrs max recording'] );
disp(['sample rate ',num2str(swc.SampleRate) ,' Hz'] );
disp(['session nr  [ ',num2str(swc.session_nr),' ]'] );

swc.base_dir='E:\Chris\ntsr_wholecell\swc_data\';
mkdir(swc.base_dir);
swc.mouse_dir=swc.mouse_id;
mkdir(fullfile(swc.base_dir,swc.mouse_dir));
swc.sess_dir=['session_',num2str(swc.session_nr)];
mkdir(fullfile(swc.base_dir,swc.mouse_dir,[swc.sess_dir,'_',sess_datestr]));
swc.data_dir=fullfile(swc.base_dir,swc.mouse_dir,[swc.sess_dir,'_',sess_datestr]);


disp(['saving to ',swc.data_dir]);

recording_nr=recording_nr+1;
swc.recording_nr=recording_nr;

set(handles.text_cellnum,'String',num2str(recording_nr)); 
set(handles.text_next_rec,'String',[num2str(recording_nr+1),' next']); 



set(handles.pushbutton_stop,'Enable','on'); drawnow;

swc.displaybuffersize=5; % in sec
swc.displaybuffersize_samples=ceil(swc.SampleRate*swc.displaybuffersize);
swc.displaybuffer=zeros(swc.displaybuffersize_samples,5);

disp(['session [ ',num2str(swc.session_nr),' ] recording nr. [ ',num2str(swc.recording_nr),' ]'] );

ai.LogFileName = fullfile(swc.data_dir,['wc_',num2str(swc.recording_nr),'.daq']);
if numel(dir(ai.LogFileName))>0
    button = questdlg(['overwrite ',ai.LogFileName],'file existst already','yes','no',2);
    if strcmp(button,'no')
        ai.LogFileName =[];
    end;
end;

set(handles.text_path,'String',ai.LogFileName); drawnow;

swc.tic=clock;

ai.SamplesAcquiredFcn={@display_swc_data_legacy_gui,handles,ai};
ai.SamplesAcquiredFcnCount=ceil(ai.SampleRate/4);

start(ai);

disp(['started recording to ', ai.LogFileName] ); 

set(handles.text_cellnum,'ForegroundColor',[0 0 1]); drawnow;
set(handles.pushbutton_start,'Enable','off');
set(handles.pushbutton_view,'Enable','off');  drawnow;




% --- Executes on button press in pushbutton_stop.
function pushbutton_stop_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


set(hObject,'String','saving..');
set(handles.pushbutton_stop,'Enable','off'); drawnow;
global ai swc;

stop(ai);
%stop(lh);
%delete(lh);

disp(['stopped recording to ', ai.LogFileName] );
disp(['>> ended session [ ',num2str(swc.session_nr),' ] recording nr. [ ',num2str(swc.recording_nr),' ]'] );

swc.meta_data_file=fullfile(swc.data_dir,['swc_data_',num2str(swc.recording_nr),'.mat']);
save(swc.meta_data_file,'swc');
disp(['saved meta data to ', swc.meta_data_file] );
disp(' ')

set(hObject,'String','stop'); 
set(handles.pushbutton_start,'Enable','on'); 
set(handles.pushbutton_view,'Enable','on'); 

set(handles.text_cellnum,'ForegroundColor',[1 1 1].*.5); drawnow;

function edit_ylim_a_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ylim_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ylim_a as text
%        str2double(get(hObject,'String')) returns contents of edit_ylim_a as a double

global swc;
try
swc.ylims(1)=str2num(get(hObject,'String'));
end;

% --- Executes during object creation, after setting all properties.
function edit_ylim_a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ylim_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ylim_b_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ylim_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ylim_b as text
%        str2double(get(hObject,'String')) returns contents of edit_ylim_b as a double
global swc;
try
swc.ylims(1)=str2num(get(hObject,'String'));
end;


% --- Executes during object creation, after setting all properties.
function edit_ylim_b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ylim_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_autorange.
function checkbox_autorange_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_autorange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_autorange


% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;



function edit_note_Callback(hObject, eventdata, handles)
% hObject    handle to edit_note (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_note as text
%        str2double(get(hObject,'String')) returns contents of edit_note as a double


% --- Executes during object creation, after setting all properties.
function edit_note_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_note (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_view.
function pushbutton_view_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (~isempty(daqfind))
    stop(daqfind);
end

global recording_nr ai;

swc=[];
global swc;

swc.date=date;
swc.time=now;


swc.note=get(handles.edit_note,'String');

swc.mouse_id=get(handles.edit_mouse,'String');
swc.max_hrs=1;
swc.SampleRate=20000;
swc.session_nr=str2num(get(handles.edit_session,'String'));
swc.chs.trial_trigger=4;  %where in the input train is the data, not where oin the daq
swc.chs.frame_trigger=3;  %where in the input train is the data, not where oin the daq
swc.chs.whisker_stim=5;  %where in the input train is the data, not where oin the daq

swc.gain_primary=10; % multiclamp gain
swc.gain_secondary=10;
swc.ylims=[-100 20];

ai.LogToDiskMode = 'overwrite';
ai.LoggingMode = 'disk';
ai.TriggerType = 'Immediate';
ai.TriggerRepeat = 1;
ai.SampleRate = swc.SampleRate;
ai.SamplesPerTrigger = ceil(swc.max_hrs*(60^2)*ai.SampleRate); % 2 hrs?

disp(['set up for ',num2str(swc.max_hrs) ,' hrs max recording'] );
disp(['sample rate ',num2str(swc.SampleRate) ,' Hz'] );
disp(['session nr  [ ',num2str(swc.session_nr),' ]'] );

swc.base_dir='E:\Chris\ntsr_wholecell\swc_data\';
mkdir(swc.base_dir);
swc.mouse_dir=swc.mouse_id;
mkdir(fullfile(swc.base_dir,swc.mouse_dir,'temp'));
swc.sess_dir=['session_temp'];
mkdir(fullfile(swc.base_dir,swc.mouse_dir,[swc.sess_dir]));
swc.data_dir=fullfile(swc.base_dir,swc.mouse_dir,'temp');



disp(['temp saving to ',swc.data_dir]);

%recording_nr=recording_nr+1;
swc.recording_nr=recording_nr;

set(handles.text_cellnum,'String',num2str(recording_nr)); 

set(handles.pushbutton_viewstop,'Enable','on'); drawnow;

swc.displaybuffersize=5; % in sec
swc.displaybuffersize_samples=ceil(swc.SampleRate*swc.displaybuffersize);
swc.displaybuffer=zeros(swc.displaybuffersize_samples,5);

disp(['session [ ',num2str(swc.session_nr),' ] recording nr. [ ',num2str(swc.recording_nr),' ]'] );

ai.LogFileName = fullfile(swc.data_dir,['wc_',num2str(swc.recording_nr),'.daq']);
set(handles.text_path,'String',ai.LogFileName); drawnow;

swc.tic=clock;

ai.SamplesAcquiredFcn={@display_swc_data_legacy_gui,handles,ai};
ai.SamplesAcquiredFcnCount=ceil(ai.SampleRate/4);

start(ai);

disp(['started recording to ', ai.LogFileName] ); 
set(handles.figure1,'Color',[.9 .4 .4]);
set(handles.pushbutton_view,'Enable','off'); drawnow;

% --- Executes on button press in pushbutton_viewstop.
function pushbutton_viewstop_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_viewstop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%set(hObject,'String','saving..');
set(handles.pushbutton_viewstop,'Enable','off'); drawnow;
global ai swc;

stop(ai);
%stop(lh);
%delete(lh);

disp(['stopped viewing'] );

set(hObject,'String','stop'); 
set(handles.pushbutton_view,'Enable','on'); 
set(handles.pushbutton_start,'Enable','on'); 
set(handles.figure1,'Color',[1 1 1].*.8);
drawnow;


% --- Executes on button press in checkbox_range_median.
function checkbox_range_median_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_range_median (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_range_median



function edit_rbath_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rbath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rbath as text
%        str2double(get(hObject,'String')) returns contents of edit_rbath as a double


% --- Executes during object creation, after setting all properties.
function edit_rbath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rbath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_bridgeoffs.
function checkbox_bridgeoffs_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_bridgeoffs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_bridgeoffs


% --- Executes on slider movement.
function slider_bridgeoffs_Callback(hObject, eventdata, handles)
% hObject    handle to slider_bridgeoffs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_bridgeoffs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_bridgeoffs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
