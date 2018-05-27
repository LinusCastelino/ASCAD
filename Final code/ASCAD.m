function varargout = ASCAD(varargin)
% ASCAD MATLAB code for ASCAD.fig
%      ASCAD, by itself, creates a new ASCAD or raises the existing
%      singleton*.
%
%      H = ASCAD returns the handle to a new ASCAD or the handle to
%      the existing singleton*.
%
%      ASCAD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ASCAD.M with the given input arguments.
%
%      ASCAD('Property','Value',...) creates a new ASCAD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ASCAD_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ASCAD_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ASCAD

% Last Modified by GUIDE v2.5 07-Apr-2015 16:20:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ASCAD_OpeningFcn, ...
                   'gui_OutputFcn',  @ASCAD_OutputFcn, ...
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


% --- Executes just before ASCAD is made visible.
function ASCAD_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ASCAD (see VARARGIN)

% Choose default command line output for ASCAD
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ASCAD wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ASCAD_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function P_name_Callback(hObject, eventdata, handles)
% hObject    handle to P_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of P_name as text
%        str2double(get(hObject,'String')) returns contents of P_name as a double


% --- Executes during object creation, after setting all properties.
function P_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function P_age_Callback(hObject, eventdata, handles)
% hObject    handle to P_age (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of P_age as text
%        str2double(get(hObject,'String')) returns contents of P_age as a double


% --- Executes during object creation, after setting all properties.
function P_age_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P_age (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function D_name_Callback(hObject, eventdata, handles)
% hObject    handle to D_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of D_name as text
%        str2double(get(hObject,'String')) returns contents of D_name as a double


% --- Executes during object creation, after setting all properties.
function D_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to D_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function img_path_Callback(hObject, eventdata, handles)
% hObject    handle to img_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of img_path as text
%        str2double(get(hObject,'String')) returns contents of img_path as a double


% --- Executes during object creation, after setting all properties.
function img_path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to img_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = hObject;
[fn pn] = uigetfile('*.jpg','select dicom file');
complete = strcat(pn,fn);
set(handles.img_path,'string',complete);


% --- Executes on button press in Go.
function Go_Callback(hObject, eventdata, handles)
% hObject    handle to Go (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

P= get(handles.P_name, 'String');
A= str2num(get(handles.P_age, 'String'));
D= get(handles.D_name, 'String');
IP= get(handles.img_path, 'String');

if isempty(P)    % checking that the patient name field is not left blank
    errordlg('Please enter the Patient Name.', 'Error');
else if isempty(A)   % checking that the patient age is not left blank
        errordlg('Please enter the age of the patient.', 'Error');
else if A<0    % checking if the user has entered a negative age
        errordlg('Please enter a valid age of the patient.', 'Error');
else if isempty(D);
        errordlg('Please enter the name of the doctor or medical practioner who advised the test. Enter N.A. in case of self test.', 'Error');         
else if isempty(IP)
        errordlg('Image path empty. Please browse to the input image.','Error');
    else
        Code(get(handles.P_name, 'String'), get(handles.P_age, 'String'), get(handles.D_name, 'String'), get(handles.img_path, 'String'));    
    end
    end
    end
    end
end
